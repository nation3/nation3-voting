// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

interface IPassportIssuer {
  /// @notice Returns the status of an account: (0) Not issued, (1) Issued, (2) Revoked.
  function passportStatus(address account) external view returns (uint8);

  /// @notice Returns the balance of veToken under which a passport is revocable.
  function revokeUnderBalance() external view returns (uint256);

  /// @notice Returns the total number of passports issued.
  function totalIssued() external view returns (uint256);
}
