// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721Wrapper } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Wrapper.sol";

interface IPassportWrapped {
    /// @notice Deposits an amount of underlying token and mints the corresponding number of wrapped tokens for a receiving address.
    /// @param account The address receiving the minted, wrapped tokens.
    /// @param amount The amount of tokens to deposit.
    function depositFor(address account, uint256 amount) external returns (bool);

    /// @notice Withdraws an amount of underlying tokens to a receiving address and burns the corresponding number of wrapped tokens.
    /// @param account The address receiving the withdrawn, underlying tokens.
    /// @param amount The amount of underlying tokens to withdraw.
    function withdrawTo(address account, uint256 amount) external returns (bool);
}
