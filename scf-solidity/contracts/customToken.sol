// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title CustomToken
 * @dev A simple ERC-20 Token contract with minting functionality.
 */
contract CustomToken is ERC20, Ownable {
    /**
     * @dev Constructor that initializes the token with a name and symbol.
     * @param name The name of the token.
     * @param symbol The symbol of the token.
     */
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    /**
     * @dev Mint new tokens. Only the owner can call this function.
     * @param to The address to receive the minted tokens.
     * @param amount The amount of tokens to mint (in smallest units, e.g., wei).
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}