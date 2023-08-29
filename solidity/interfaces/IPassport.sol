// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

interface IPassport {
  /// @notice Returns the total supply of passports.
  function totalSupply() external view returns (uint256);
}
