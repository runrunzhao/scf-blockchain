// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev A simple ERC-20 Token contract with minting functionality and expiration date.
 */
contract CustomToken is ERC20, Ownable {
    uint256 public expirationDate;

    /**
     * @dev Constructor that initializes the token with a name, symbol, and expiration date.
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 _expirationDate
    ) ERC20(name, symbol) Ownable(msg.sender) {
        require(
            _expirationDate > block.timestamp,
            "Expiration date must be in the future"
        );
        expirationDate = _expirationDate;
    }

    /**
     * @dev Check if the token has expired.
     */
    modifier notExpired() {
        require(block.timestamp <= expirationDate, "Token has expired");
        _;
    }

    /**
     * @dev Mint new tokens. Only the owner can call this function.
     */
    function mint(address to, uint256 amount) public onlyOwner notExpired {
        _mint(to, amount);
    }

    /**
     * @dev Override the transfer function to check for expiration.
     */
    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        notExpired
        returns (bool)
    {
        return super.transfer(recipient, amount);
    }

    /**
     * @dev Override the transferFrom function to check for expiration.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override notExpired returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }


     function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
    

    function burnFrom(address account, uint256 amount) public {
        uint256 currentAllowance = allowance(account, msg.sender);
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        
        unchecked {
            _approve(account, msg.sender, currentAllowance - amount);
        }
        
        _burn(account, amount);
    }
    

    function getTimeInfo() public view returns (uint256 currentTime, uint256 expiryTime, bool isExpired) {
        currentTime = block.timestamp;
        expiryTime = expirationDate;
        isExpired = block.timestamp > expirationDate;
    }

}
