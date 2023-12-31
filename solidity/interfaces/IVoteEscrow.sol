// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

interface IVoteEscrow {
  /**
   * @notice Returns the balance of the given account at the specified block number.
   * @param account The address of the account.
   * @param blockNumber The block number at which the balance is checked.
   * @return The balance of the given account at the specified block number.
   */
  function balanceOfAt(address account, uint256 blockNumber) external view returns (uint256);

  /**
   * @notice Returns the total supply of the token at the specified block number.
   * @param blockNumber The block number at which the total supply is checked.
   * @return The total supply of the token at the specified block number.
   */
  function totalSupplyAt(uint256 blockNumber) external view returns (uint256);

  /**
   * @notice Deposit `_value` tokens for `msg.sender` and lock until `_unlock_time`
   * @param _value Amount to deposit
   * @param _unlock_time Epoch time when tokens unlock, rounded down to whole weeks
   */
  function create_lock(uint256 _value, uint256 _unlock_time) external;
}
