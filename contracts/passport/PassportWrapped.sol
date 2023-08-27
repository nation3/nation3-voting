// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity 0.8.17;

import { ERC721 } from "solmate/src/tokens/ERC721.sol";
import { ERC721Wrapper } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Wrapper.sol";
import { IVotesUpgradeable } from "@openzeppelin/contracts-upgradeable/governance/utils/IVotesUpgradeable.sol";
import {
    IERC20PermitUpgradeable
} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-IERC20PermitUpgradeable.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {
    IERC20MetadataUpgradeable
} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import { ERC721Votes } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Votes.sol";
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { ERC165Upgradeable } from "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";
import { DaoAuthorizableUpgradeable } from "@aragon/osx/core/plugin/dao-authorizable/DaoAuthorizableUpgradeable.sol";
import { IDAO } from "@aragon/osx/core/dao/IDAO.sol";
import { IPassportWrapped } from "./IPassportWrapped.sol";

/// @title PassportWrapper
/// @author Nation3 DAO
/// @notice Wraps an existing [ERC-721](https://eips.ethereum.org/EIPS/eip-721) token by inheriting from `ERC721Wrapper` and allows to use it for voting by inheriting from `ERC721Votes`. The latter is compatible with [OpenZeppelin's `Votes`](https://docs.openzeppelin.com/contracts/4.x/api/governance#Votes) interface.
/// The contract also supports meta transactions. To use an `amount` of underlying tokens for voting, the token owner has to
/// 1. call `approve` for the tokens to be used by this contract
/// 2. call `depositFor` to wrap them, which safely transfers the underlying [ERC-721](https://eips.ethereum.org/EIPS/eip-721) tokens to the contract and mints wrapped [ERC-721](https://eips.ethereum.org/EIPS/eip-721) tokens.
/// To get the [ERC-721](https://eips.ethereum.org/EIPS/eip-721) tokens back, the owner of the wrapped tokens can call `withdrawFor`, which  burns the wrapped [ERC-721](https://eips.ethereum.org/EIPS/eip-721) tokens and safely transfers the underlying tokens back to the owner.
/// @dev This contract intentionally has no public mint functionality because this is the responsibility of the underlying [ERC-20](https://eips.ethereum.org/EIPS/eip-20) token contract.
contract PassportWrapped is IPassportWrapped, ERC165Upgradeable, ERC721Votes, ERC721Wrapper {
    /// @notice Calls the initialize function.
    /// @param _token The underlying [ERC-20](https://eips.ethereum.org/EIPS/eip-20) token.
    /// @param _name The name of the wrapped token.
    /// @param _symbol The symbol of the wrapped token.
    constructor(IERC721 _token, string memory _name, string memory _symbol) ERC721(_token, _name, _symbol) {}

    /// @notice Checks if this or the parent contract supports an interface by its ID.
    /// @param _interfaceId The ID of the interface.
    /// @return Returns `true` if the interface is supported.
    function supportsInterface(bytes4 _interfaceId) public view virtual override returns (bool) {
        return
            _interfaceId == type(IPassportWrapped).interfaceId ||
            _interfaceId == type(IERC721).interfaceId ||
            _interfaceId == type(IERC20PermitUpgradeable).interfaceId ||
            _interfaceId == type(IERC20MetadataUpgradeable).interfaceId ||
            _interfaceId == type(IVotesUpgradeable).interfaceId ||
            super.supportsInterface(_interfaceId);
    }

    /// @inheritdoc ERC721Wrapper
    /// @dev Uses the `decimals` of the underlying [ERC-721](https://eips.ethereum.org/EIPS/eip-721) token.
    function decimals() public view override(ERC721, ERC721Wrapper) returns (uint8) {
        return ERC721Wrapper.decimals();
    }

    /// @inheritdoc IPassportWrapped
    function depositFor(
        address account,
        uint256 amount
    ) public override(IPassportWrapped, ERC721Wrapper) returns (bool) {
        return ERC721Wrapper.depositFor(account, amount);
    }

    /// @inheritdoc IPassportWrapped
    function withdrawTo(
        address account,
        uint256 amount
    ) public override(IPassportWrapped, ERC721Wrapper) returns (bool) {
        return ERC721Wrapper.withdrawTo(account, amount);
    }

    // https://forum.openzeppelin.com/t/self-delegation-in-erc20votes/17501/12?u=novaknole
    /// @inheritdoc ERC721Votes
    function _afterTokenTransfer(address from, address to, uint256 amount) internal override(ERC721Votes, ERC721) {
        super._afterTokenTransfer(from, to, amount);

        // Automatically turn on delegation on mint/transfer but only for the first time.
        // Look into this a bit more.
        if (to != address(0) && numCheckpoints(to) == 0 && delegates(to) == address(0)) {
            _delegate(to, to);
        }
    }

    /// @inheritdoc ERC721Votes
    function _mint(address to, uint256 amount) internal override(ERC721Votes, ERC721) {
        super._mint(to, amount);
    }

    /// @inheritdoc ERC721Votes
    function _burn(address account, uint256 amount) internal override(ERC721Votes, ERC721) {
        super._burn(account, amount);
    }
}
