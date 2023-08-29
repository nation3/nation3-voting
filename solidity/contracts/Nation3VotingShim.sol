// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity =0.8.17;

import {Initializable} from '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';
import {ERC165Upgradeable} from '@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol';

import {PluginUUPSUpgradeable} from '@aragon/osx/core/plugin/PluginUUPSUpgradeable.sol';
import {IVotesUpgradeable} from '@openzeppelin/contracts-upgradeable/governance/utils/IVotesUpgradeable.sol';
import {DaoAuthorizableUpgradeable} from '@aragon/osx/core/plugin/dao-authorizable/DaoAuthorizableUpgradeable.sol';
import {IDAO} from '@aragon/osx/core/dao/IDAO.sol';

import {IPassportIssuer} from '../interfaces/IPassportIssuer.sol';
import {IPassport} from '../interfaces/IPassport.sol';
import {IVoteEscrow} from '../interfaces/IVoteEscrow.sol';

/// @title Nation3VotingShim
/// @author Nation3: (@pythonpete32)
/// @dev support for the IVotesUpgradeable is required to make this contract compatable with the Aragon [TokenVoting plugin](https://github.com/aragon/osx/blob/0ad8cad2bb661fbd53086d097d11228304d9b73e/packages/contracts/src/plugins/governance/majority-voting/token/TokenVotingSetup.sol#L107).
/// @notice This is a wrapper contract that enables 1 person 1 vote for Nation3 passport holders.
contract Nation3VotingShim is Initializable, ERC165Upgradeable, IVotesUpgradeable, PluginUUPSUpgradeable {
  /// @dev Address of the PassportIssuer contract
  IPassportIssuer private constant _passportIssuer = IPassportIssuer(0x279c0b6bfCBBA977eaF4ad1B2FFe3C208aa068aC);
  /// @dev Address of the VoteEscrow contract
  IVoteEscrow private constant _nation = IVoteEscrow(0x333A4823466879eeF910A04D473505da62142069);

  IPassport private constant _passport = IPassport(0x3337dac9F251d4E403D6030E18e3cfB6a2cb1333);

  /// @notice The [ERC-165](https://eips.ethereum.org/EIPS/eip-165) interface ID of the contract.
  bytes4 internal constant NATION3_SHIM_INTERFACE_ID = this.initialize.selector;

  /// @dev Error to be thrown when a delegation is attempted.
  error DelegationDisabled();

  constructor() {
    _disableInitializers();
  }

  /// @notice Initializes the contract and mints tokens to a list of receivers.
  /// @param _dao The managing DAO.
  function initialize(IDAO _dao) public initializer {
    __PluginUUPSUpgradeable_init(_dao);
  }

  /// @notice Checks if this or the parent contract supports an interface by its ID.
  /// @param _interfaceId The ID of the interface.
  /// @return Returns `true` if the interface is supported.
  function supportsInterface(bytes4 _interfaceId)
    public
    view
    virtual
    override(ERC165Upgradeable, PluginUUPSUpgradeable)
    returns (bool)
  {
    return _interfaceId == NATION3_SHIM_INTERFACE_ID || _interfaceId == type(IVotesUpgradeable).interfaceId
      || super.supportsInterface(_interfaceId);
  }

  /// @inheritdoc IVotesUpgradeable
  function getPastVotes(address account, uint256 timepoint) public view override returns (uint256) {
    uint256 balance = _nation.balanceOfAt(account, timepoint);
    if (balance < _passportIssuer.revokeUnderBalance()) return 0;
    return _passportIssuer.passportStatus(account) == 1 ? 1 : 0;
  }

  /// @inheritdoc IVotesUpgradeable
  function getVotes(address account) public view override returns (uint256) {
    return getPastVotes(account, block.number);
  }

  /// @inheritdoc IVotesUpgradeable
  /// @dev delegation is not used so the passport holder is their own delegate.
  function delegates(address account) public pure override returns (address) {
    return account;
  }

  /// @inheritdoc IVotesUpgradeable
  /// @dev The timepoint is not used since we dont have the checkpointing mechanism. This means minting and burning after a vote is created will affect the quorum.
  // solhint-disable-next-line
  function getPastTotalSupply(uint256 timepoint) public view override returns (uint256) {
    return _passport.totalSupply();
  }

  /// @inheritdoc IVotesUpgradeable
  /// @dev delegation is not used
  function delegate(address) public virtual override {
    revert DelegationDisabled();
  }

  /// @inheritdoc IVotesUpgradeable
  /// @dev delegation is not used
  function delegateBySig(address, uint256, uint256, uint8, bytes32, bytes32) public virtual override {
    revert DelegationDisabled();
  }

  /// @dev This empty reserved space is put in place to allow future versions to add new
  /// variables without shifting down storage in the inheritance chain.
  /// https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
  uint256[49] private __gap;
}
