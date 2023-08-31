// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.8;

import {UUPSUpgradeable} from '@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol';
import {IERC1822ProxiableUpgradeable} from
  '@openzeppelin/contracts-upgradeable/interfaces/draft-IERC1822Upgradeable.sol';
import {ERC165Upgradeable} from '@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol';

import {DaoAuthorizableUpgradeable} from '@aragon/osx/core/plugin/dao-authorizable/DaoAuthorizableUpgradeable.sol';
import {IDAO} from '@aragon/osx/core/dao/IDAO.sol';

abstract contract UpgradableUUPSBase is ERC165Upgradeable, UUPSUpgradeable, DaoAuthorizableUpgradeable {
  // NOTE: When adding new state variables to the contract, the size of `_gap` has to be adapted below as well.

  /// @notice Disables the initializers on the implementation contract to prevent it from being left uninitialized.
  constructor() {
    _disableInitializers();
  }

  /// @notice The ID of the permission required to call the `_authorizeUpgrade` function.
  bytes32 public constant UPGRADE_PERMISSION_ID = keccak256('UPGRADE_PERMISSION');

  /// @notice Initializes the plugin by storing the associated DAO.
  /// @param _dao The DAO contract.
  function __UpgradableUUPSBase_init(IDAO _dao) internal virtual onlyInitializing {
    __DaoAuthorizableUpgradeable_init(_dao);
  }

  /// @notice Checks if an interface is supported by this or its parent contract.
  /// @param _interfaceId The ID of the interface.
  /// @return Returns `true` if the interface is supported.
  function supportsInterface(bytes4 _interfaceId) public view virtual override returns (bool) {
    return _interfaceId == type(IERC1822ProxiableUpgradeable).interfaceId || super.supportsInterface(_interfaceId);
  }

  /// @notice Returns the address of the implementation contract in the [proxy storage slot](https://eips.ethereum.org/EIPS/eip-1967) slot the [UUPS proxy](https://eips.ethereum.org/EIPS/eip-1822) is pointing to.
  /// @return The address of the implementation contract.
  function implementation() public view returns (address) {
    return _getImplementation();
  }

  /// @notice Internal method authorizing the upgrade of the contract via the [upgradeability mechanism for UUPS proxies](https://docs.openzeppelin.com/contracts/4.x/api/proxy#UUPSUpgradeable) (see [ERC-1822](https://eips.ethereum.org/EIPS/eip-1822)).
  /// @dev The caller must have the `UPGRADE_PLUGIN_PERMISSION_ID` permission.
  function _authorizeUpgrade(address) internal virtual override auth(UPGRADE_PERMISSION_ID) {}

  /// @notice This empty reserved space is put in place to allow future versions to add new variables without shifting down storage in the inheritance chain (see [OpenZeppelin's guide about storage gaps](https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps)).
  uint256[50] private __gap;
}
