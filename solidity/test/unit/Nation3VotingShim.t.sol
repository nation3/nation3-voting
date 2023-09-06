// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import {Clones} from '@openzeppelin/contracts/proxy/Clones.sol';
import {ERC20} from '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import {IERC165Upgradeable} from '@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol';
import {IVotesUpgradeable} from '@openzeppelin/contracts-upgradeable/governance/utils/IVotesUpgradeable.sol';
import {IDAO} from '@aragon/osx/core/dao/IDAO.sol';
import {DSTestFull} from 'test/utils/DSTestFull.sol';
import {DAOHelpers} from 'test/utils/DAOHelpers.sol';
import {DAOMock} from 'test/mocks/DAOMock.sol';

import {IVoteEscrow} from 'interfaces/IVoteEscrow.sol';
import {Nation3VotingShim} from 'contracts/Nation3VotingShim.sol';

abstract contract Base is DSTestFull, DAOHelpers {
  using Clones for address;

  // network
  uint256 internal constant _FORK_BLOCK = 18_063_645;
  string internal constant _NETWORK = 'mainnet';
  uint256 internal constant _MAX_TIME = 4 * 365 * 86_400; // 4 years

  // dao
  IDAO internal _dao;
  address internal _shimBase;
  Nation3VotingShim internal _nation3VotingShim;

  // addresses
  address internal _owner = _label('owner');
  address internal _alice = _label('alice');
  address internal _abuUsama = 0x47d80912400ef8f8224531EBEB1ce8f2ACf4b75a;
  address internal _passportIssuer = 0x279c0b6bfCBBA977eaF4ad1B2FFe3C208aa068aC;
  address internal _nation = 0x333A4823466879eeF910A04D473505da62142069;
  address internal _veNation = 0xF7deF1D2FBDA6B74beE7452fdf7894Da9201065d;
  address internal _passport = 0x3337dac9F251d4E403D6030E18e3cfB6a2cb1333;
  address internal _nationWhale = 0x336252602b3a8A0bE336ED942228305173E8082B;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl(_NETWORK), _FORK_BLOCK);
    vm.prank(_owner);

    _dao = new DAOMock(_owner);
    _shimBase = address(new Nation3VotingShim());
    _nation3VotingShim = Nation3VotingShim(_shimBase.clone());
  }

  function lockNationFor(address _user, uint256 _amount) internal {
    vm.prank(_nationWhale);
    ERC20(_nation).transfer(_user, _amount);
    vm.startPrank(_user);
    ERC20(_nation).approve(_veNation, _amount);
    IVoteEscrow(_veNation).create_lock(_amount, block.timestamp + _MAX_TIME);
    vm.stopPrank();
  }
}

contract UnitShimInitialize is Base {
  using Clones for address;

  function test_initializes() public {
    _nation3VotingShim.initialize(_dao);
    assertEq(address(_nation3VotingShim.dao()), address(_dao));
  }

  function test_cannot_initializes_twice() public {
    _nation3VotingShim.initialize(_dao);
    vm.expectRevert('Initializable: contract is already initialized');
    _nation3VotingShim.initialize(_dao);
  }
}

contract UnitShimSupportsInterface is Base {
  using Clones for address;

  function setUp() public override {
    super.setUp();
    _nation3VotingShim.initialize(_dao);
  }

  function test_does_not_supports_empty_interface() public {
    assertFalse(_nation3VotingShim.supportsInterface(0xffffffff));
  }

  function test_supports_IERC165Upgradeable_interface() public {
    assertTrue(_nation3VotingShim.supportsInterface(type(IERC165Upgradeable).interfaceId));
  }

  function test_supports_IVotesUpgradable_interface() public {
    assertTrue(_nation3VotingShim.supportsInterface(type(IVotesUpgradeable).interfaceId));
  }

  // TODO: this wont work because _alice is a contract which is not allowed in the escrow contract
  // function test_cannot_vote_with_veNation_without_passport() public {
  //   lockNationFor(_alice, 100 ether);
  // }
}

contract UnitShimVotingPower is Base {
  using Clones for address;

  function setUp() public override {
    super.setUp();
    _nation3VotingShim.initialize(_dao);
  }

  function test_getTotalSupply() public {
    assertEq(_nation3VotingShim.getPastTotalSupply(block.number), 280);
  }

  function test_citizen_can_vote() public {
    assertEq(_nation3VotingShim.getPastVotes(_abuUsama, block.number), 1);
  }
}
