
USE SCFDB;
USE SCFDB;
-- 用户表 - 存储注册用户信息
CREATE TABLE  users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,  
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(64) NOT NULL ,
    enterprise_id  char(8),  
    registration_date date,
    last_login TIMESTAMP,
    account_status ENUM('active', 'inactive', 'suspended', 'pending') DEFAULT 'active',
    walletAddr VARCHAR(42),
    memo VARCHAR(64)
    
);


CREATE TABLE enterprise(
    enterpriseID char(8) PRIMARY KEY,      -- enterID
    enterpriseName VARCHAR(255) NOT NULL,              --  name
    address VARCHAR(255) NOT NULL,
    telephone CHAR(12) NOT NULL,
    role ENUM('Core', 'Bank','Supplier','Distributor') NOT NULL,
    tier INT
);
ALTER TABLE enterprise ADD COLUMN memo VARCHAR(100);


CREATE TABLE contract (
    contractID char(8) PRIMARY KEY,  -- Contract ID
    realNo VARCHAR(100) NOT NULL,               -- Real contract number
    part1 VARCHAR(255),                                 -- Part 1 of the contract 
    part2 VARCHAR(255),                                 -- Part 2 of the contract 
    amount DECIMAL(15, 2) NOT NULL,             -- Contract amount
    signingDate DATE NOT NULL ,
    effectiveDate  DATE NOT NULL ,
    invalidDate DATE NOT NULL  ,
    status ENUM('Active', 'Pending','End','Draft') NOT NULL,
    remarks VARCHAR(255)                        
    ;

    ALTER TABLE contract 
MODIFY COLUMN status ENUM('Active', 'Pending', 'End',   'Draft') NOT NULL; 
ALTER TABLE contract 
ADD COLUMN contractType ENUM('Purchase', 'Sales', 'Service') NOT NULL DEFAULT 'Service';

-- Step 7: Create 'invoice' table
CREATE TABLE invoice (
    invoiceID char(8) PRIMARY KEY,   -- Invoice ID
    payPeriod int,                             -- Payment period
    contractID char(8),                             -- Contract ID 
    amount DECIMAL(15, 2) NOT NULL,             -- Invoice amount
    PayDate DATE NOT NULL,   
    paymentMethod ENUM('Bank Transfer', 'Credit Card', 'Check', 'CTT') DEFAULT NULL,
    status ENUM('Pending','End','Draft') NOT NULL,                      -- Invoice creation date
    memo VARCHAR(255),
    FOREIGN KEY (contractID) REFERENCES contract(contractID) -- Foreign key to contract table
);
ALTER TABLE invoice ADD COLUMN payPeriod int AFTER contractID
ALTER TABLE invoice
MODIFY COLUMN paymentMethod ENUM('CTT', 'Transfer', 'Check', 'Card') DEFAULT NULL;


CREATE TABLE SCToken (
    tokenID INT AUTO_INCREMENT PRIMARY KEY,
    owerAddr VARCHAR(42) NOT NULL,
    tokenName VARCHAR(64) NOT NULL,
    tokenSymbol VARCHAR(16) NOT NULL,
    scexpireDate DATE NOT NULL,
    genContractAddr VARCHAR(42),
    scCreateTime DATETIME,
    tokenAmount DECIMAL(15, 2),
    tokenCreateTime DATETIME,
    memo VARCHAR(64)
);


CREATE TABLE scMulti (
    multiTokenID INT AUTO_INCREMENT PRIMARY KEY,
    scTransAddr VARCHAR(42) NOT NULL,
    signer1 VARCHAR(42),
    signer2 VARCHAR(42),
    signer3 VARCHAR(42),
    requiredConfirmations INT,
    memo VARCHAR(42),
    genmuliContractAddr VARCHAR(42),
    scmultiCreateTime DATETIME
);


CREATE TABLE scTransMultiConnection (
    connectionID INT AUTO_INCREMENT PRIMARY KEY,
    scTransAddr VARCHAR(42) NOT NULL,
    scMultiAddr VARCHAR(42) NOT NULL,
    scConnectTime DATETIME,
    signTx VARCHAR(72),
    memo VARCHAR(42)
);




-- Step 8: Create 'CTT' (Contract Tracking Table)
CREATE TABLE CTT (
    total INT NOT NULL,                         -- Total number of contracts
    invalidDate DATE,                           -- Invalid date for the contract
    burn BOOLEAN DEFAULT FALSE                  -- Whether the contract is canceled or fulfilled (True/False)
);

CREATE TABLE scheduledTransfers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fromAddress VARCHAR(42) NOT NULL,
  toAddress VARCHAR(42) NOT NULL,
  amount DECIMAL(36,18) NOT NULL,
  scheduledTime DATETIME NOT NULL,
  executed BOOLEAN DEFAULT FALSE,
  executionTime DATETIME,
  transaction_hash VARCHAR(66),
  createdTime DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(10) DEFAULT 'PENDING'
);

CREATE TABLE financing_records (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_address VARCHAR(42) NOT NULL,
    ctt_amount DECIMAL(18,8) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    due_date DATE NOT NULL,
    settlement_amount DECIMAL(18,8) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
