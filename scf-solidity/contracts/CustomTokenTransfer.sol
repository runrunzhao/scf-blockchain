// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract CustomTokenTransfer is ERC20, Ownable {
    uint256 public expirationDate;
    address public multiSigContract;

    // Events
    event MultiSigContractSet(address indexed oldMultiSigAddress, address indexed newMultiSigAddress);
    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);

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
     * @dev Modifier to ensure the token has not expired.
     */
    modifier notExpired() {
        require(block.timestamp <= expirationDate, "Token has expired");
        _;
    }

    /**
     * @dev Modifier to restrict access to the multi-signature contract only.
     */
    modifier onlyMultiSig() {
        require(msg.sender == multiSigContract, "Only multi-sig contract can call");
        require(multiSigContract != address(0), "Multi-sig contract not set");
        _;
    }

    /**
     * @dev Set the multi-signature contract address.
     * @param _multiSigContract The address of the multi-signature contract.
     */
    function setMultiSigContract(address _multiSigContract) external onlyOwner {
        require(_multiSigContract != address(0), "Invalid address");
        address oldMultiSigContract = multiSigContract;
        multiSigContract = _multiSigContract;
        emit MultiSigContractSet(oldMultiSigContract, _multiSigContract);
    }

    /**
     * @dev Single-signature transfer function - any token holder can call.
     * @param to The recipient address.
     * @param amount The amount of tokens to transfer.
     */
    function transfer(address to, uint256 amount)
        public
        override
        notExpired
        returns (bool)
    {
        require(to != address(0), "Cannot transfer to zero address");
        return super.transfer(to, amount);
    }

    /**
     * @dev Single-signature transferFrom function - any approved spender can call.
     * @param from The address to transfer tokens from.
     * @param to The recipient address.
     * @param amount The amount of tokens to transfer.
     */
    function transferFrom(address from, address to, uint256 amount)
        public
        override
        notExpired
        returns (bool)
    {
        require(from != address(0), "Cannot transfer from zero address");
        require(to != address(0), "Cannot transfer to zero address");
        return super.transferFrom(from, to, amount);
    }

    /**
     * @dev Multi-signature mint function - only callable by multiSigContract.
     * @param to The recipient address.
     * @param amount The amount of tokens to mint.
     */
    function mintByMultiSig(address to, uint256 amount) external onlyMultiSig notExpired {
        require(to != address(0), "Cannot mint to zero address");
        require(amount > 0, "Amount must be positive");
        
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    /**
     * @dev Multi-signature burn function - only callable by multiSigContract.
     */
    function burnByMultiSig(address from, uint256 amount) external onlyMultiSig {
        require(from != address(0), "Cannot burn from zero address");
        require(amount > 0, "Amount must be positive");
        require(balanceOf(from) >= amount, "Burn amount exceeds balance");
        
        _burn(from, amount);
        emit TokensBurned(from, amount);
    }

    /**
     * @dev Get expiration status of the token.
     */
    function getExpirationStatus() public view returns (uint256 expiryTime, bool isExpired) {
        expiryTime = expirationDate;
        isExpired = block.timestamp > expirationDate;
    }
}