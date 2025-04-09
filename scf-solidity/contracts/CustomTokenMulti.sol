// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./CustomTokenTransfer.sol";

/**
 * @dev Multi-signature contract for token operations requiring multiple approvals.
 */
contract CustomTokenMulti is Ownable {
    enum TransactionType { MINT, BURN, REDEEM }

    struct Transaction {
        address to;                  // Recipient for minting or account for burning/redeeming
        uint256 amount;              // Amount to mint/burn/redeem
        TransactionType txType;      // Type of transaction
        bool executed;               // Whether the transaction has been executed
        uint256 numConfirmations;    // Number of confirmations received
    }

    // The token contract reference
    CustomTokenTransfer public tokenContract;

    // Required confirmations for a transaction
    uint256 public requiredConfirmations;

    // Signer management
    mapping(address => bool) public isSigner;
    address[] public signers;

    // Transaction management
    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public isConfirmed;

    // Events
    event TransactionSubmitted(uint256 indexed txIndex, address indexed to, uint256 amount, TransactionType txType);
    event TransactionConfirmed(uint256 indexed txIndex, address indexed signer);
    event TransactionExecuted(uint256 indexed txIndex);
    event SignerAdded(address indexed signer);
    event SignerRemoved(address indexed signer);
    event RequiredConfirmationsChanged(uint256 oldRequired, uint256 newRequired);

    constructor(
        address _tokenContract,
        address[] memory _signers,
        uint256 _requiredConfirmations
    ) Ownable(msg.sender) {
        require(_signers.length > 0, "Signers required");
        require(_requiredConfirmations > 0 && _requiredConfirmations <= _signers.length, "Invalid confirmations");

        tokenContract = CustomTokenTransfer(_tokenContract);
        requiredConfirmations = _requiredConfirmations;

        for (uint256 i = 0; i < _signers.length; i++) {
            address signer = _signers[i];
            require(signer != address(0), "Invalid signer");
            require(!isSigner[signer], "Signer not unique");

            isSigner[signer] = true;
            signers.push(signer);
            emit SignerAdded(signer);
        }
    }

    /**
     * @dev Restrict function to only approved signers
     */
    modifier onlySigner() {
        require(isSigner[msg.sender], "Not a signer");
        _;
    }

    function submitMintTransaction(address to, uint256 amount) public onlySigner returns (uint256 txIndex) {
        return _submitTransaction(to, amount, TransactionType.MINT);
    }

    function submitBurnTransaction(address from, uint256 amount) public onlySigner returns (uint256 txIndex) {
        return _submitTransaction(from, amount, TransactionType.BURN);
    }

    function submitRedeemTransaction(address from, uint256 amount) public onlySigner returns (uint256 txIndex) {
        return _submitTransaction(from, amount, TransactionType.REDEEM);
    }

    function _submitTransaction(address to, uint256 amount, TransactionType txType) internal returns (uint256 txIndex) {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be positive");

        txIndex = transactions.length;

        transactions.push(Transaction({
            to: to,
            amount: amount,
            txType: txType,
            executed: false,
            numConfirmations: 0
        }));

        emit TransactionSubmitted(txIndex, to, amount, txType);

        // Auto-confirm by submitter
        confirmTransaction(txIndex);
        
        return txIndex;
    }

    /**
     * @dev Confirm a pending transaction.
     * @param _txIndex Index of the transaction to confirm
     */
    function confirmTransaction(uint256 _txIndex) public onlySigner {
        require(_txIndex < transactions.length, "Transaction does not exist");
        Transaction storage transaction = transactions[_txIndex];

        require(!transaction.executed, "Transaction already executed");
        require(!isConfirmed[_txIndex][msg.sender], "Transaction already confirmed");

        isConfirmed[_txIndex][msg.sender] = true;
        transaction.numConfirmations += 1;

        emit TransactionConfirmed(_txIndex, msg.sender);

        // Auto-execute if we have enough confirmations
        if (transaction.numConfirmations >= requiredConfirmations) {
            executeTransaction(_txIndex);
        }
    }

    /**
     * @dev Execute a transaction that has reached required confirmations.
     * @param _txIndex Index of the transaction to execute
     */
    function executeTransaction(uint256 _txIndex) public {
        require(_txIndex < transactions.length, "Transaction does not exist");
        Transaction storage transaction = transactions[_txIndex];

        require(!transaction.executed, "Transaction already executed");
        require(transaction.numConfirmations >= requiredConfirmations, "Not enough confirmations");

        transaction.executed = true;

        // Execute the appropriate function on the token contract
        bool success;
        if (transaction.txType == TransactionType.MINT) {
            tokenContract.mintByMultiSig(transaction.to, transaction.amount);
            success = true;
        } else if (transaction.txType == TransactionType.BURN) {
            tokenContract.burnByMultiSig(transaction.to, transaction.amount);
            success = true;
        } else if (transaction.txType == TransactionType.REDEEM) {
            // For REDEEM transactions, we also burn tokens but might add additional logic
            tokenContract.burnByMultiSig(transaction.to, transaction.amount);
            success = true;
        }

        require(success, "Transaction execution failed");
        
        emit TransactionExecuted(_txIndex);
    }

    /**
     * @dev Add a new signer (owner only).
     */
    function addSigner(address _signer) public onlyOwner {
        require(_signer != address(0), "Invalid signer");
        require(!isSigner[_signer], "Signer already exists");

        isSigner[_signer] = true;
        signers.push(_signer);

        emit SignerAdded(_signer);
    }

    /**
     * @dev Remove a signer (owner only).
      */
    function removeSigner(address _signer) public onlyOwner {
        require(isSigner[_signer], "Not a signer");
        require(signers.length > requiredConfirmations, "Cannot have fewer signers than required confirmations");

        isSigner[_signer] = false;

        for (uint256 i = 0; i < signers.length; i++) {
            if (signers[i] == _signer) {
                signers[i] = signers[signers.length - 1];
                signers.pop();
                break;
            }
        }

        emit SignerRemoved(_signer);
    }

    /**
     * @dev Change required confirmations (owner only).
     * @param _requiredConfirmations New number of required confirmations
     */
    function changeRequiredConfirmations(uint256 _requiredConfirmations) public onlyOwner {
        require(_requiredConfirmations > 0, "Must be > 0");
        require(_requiredConfirmations <= signers.length, "Cannot exceed signer count");

        uint256 oldRequired = requiredConfirmations;
        requiredConfirmations = _requiredConfirmations;

        emit RequiredConfirmationsChanged(oldRequired, _requiredConfirmations);
    }

    function getTransaction(uint256 _txIndex) public view returns (
        address to,
        uint256 amount,
        TransactionType txType,
        bool executed,
        uint256 numConfirmations
    ) {
        require(_txIndex < transactions.length, "Transaction does not exist");

        Transaction storage transaction = transactions[_txIndex];

        return (
            transaction.to,
            transaction.amount,
            transaction.txType,
            transaction.executed,
            transaction.numConfirmations
        );
    }
    
    function isTransactionConfirmedBy(uint256 _txIndex, address _signer) public view returns (bool) {
        require(_txIndex < transactions.length, "Transaction does not exist");
        return isConfirmed[_txIndex][_signer];
    }
    
    /**
     * @dev Get count of all signers.
     * @return Number of signers
     */
    function getSignerCount() public view returns (uint256) {
        return signers.length;
    }
    
    /**
     * @dev Get count of all transactions.
     * @return Number of transactions
     */
    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }
    
    /**
     * @dev Get all signers.
     * @return Array of signer addresses
     */
    function getAllSigners() public view returns (address[] memory) {
        return signers;
    }
}