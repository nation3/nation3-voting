// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.17;

import {Script} from 'forge-std/Script.sol';
import {IERC20} from 'isolmate/interfaces/tokens/IERC20.sol';
import {Address} from '@openzeppelin/contracts/utils/Address.sol';
import {ERC1967Proxy} from '@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol';

import {Nation3VotingShim} from 'contracts/Nation3VotingShim.sol';

abstract contract Deploy is Script {
  using Address for address;

  function _deploy() internal {
    vm.startBroadcast();
    address nation3VotingShimBase = address(new Nation3VotingShim());
    new ERC1967Proxy(nation3VotingShimBase, "");
    vm.stopBroadcast();
  }
}

contract DeployMainnet is Deploy {
  function run() external {
    _deploy();
  }
}

contract DeployMumbai is Deploy {
  function run() external {
    _deploy();
  }
}
