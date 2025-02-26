docker run --name scf-mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=SCFDB -p 3306:3306 -d mysql:5.7
-- Step 1: Create the database
CREATE DATABASE SCFDB;

-- Step 2: Switch to the SCFDB database
USE SCFDB;

-- Step 3: Create 'core' table
CREATE TABLE core (
    coreID INT AUTO_INCREMENT PRIMARY KEY,       -- Core enterprise ID
    coreName VARCHAR(255) NOT NULL,              -- Core enterprise name
    issueCTT BOOLEAN DEFAULT FALSE              -- Whether core issues contracts (True/False)
);

-- Step 4: Create 'bank' table
CREATE TABLE bank (
    bankID INT AUTO_INCREMENT PRIMARY KEY,      -- Bank ID
    bankName VARCHAR(255) NOT NULL,              -- Bank name
    limit DECIMAL(15, 2) NOT NULL               -- Financial limit for the bank
);

-- Step 5: Create 'supplier' table
CREATE TABLE supplier (
    suppID INT AUTO_INCREMENT PRIMARY KEY,      -- Supplier ID
    suppName VARCHAR(255) NOT NULL,              -- Supplier name
    tier ENUM('Tier 1', 'Tier 2') NOT NULL      -- Supplier tier (Tier 1 or Tier 2)
);

-- Step 6: Create 'contract' table
CREATE TABLE contract (
    contractID INT AUTO_INCREMENT PRIMARY KEY,  -- Contract ID
    realNo VARCHAR(255) NOT NULL,               -- Real contract number
    part1 TEXT,                                 -- Part 1 of the contract description
    part2 TEXT,                                 -- Part 2 of the contract description
    amount DECIMAL(15, 2) NOT NULL,             -- Contract amount
    date DATE NOT NULL                          -- Date when the contract was created
);

-- Step 7: Create 'invoice' table
CREATE TABLE invoice (
    invoiceID INT AUTO_INCREMENT PRIMARY KEY,   -- Invoice ID
    contractID INT,                             -- Contract ID (Foreign Key to 'contract')
    amount DECIMAL(15, 2) NOT NULL,             -- Invoice amount
    date DATE NOT NULL,                         -- Invoice creation date
    FOREIGN KEY (contractID) REFERENCES contract(contractID) -- Foreign key to contract table
);

-- Step 8: Create 'CTT' (Contract Tracking Table)
CREATE TABLE CTT (
    total INT NOT NULL,                         -- Total number of contracts
    invalidDate DATE,                           -- Invalid date for the contract
    burn BOOLEAN DEFAULT FALSE                  -- Whether the contract is canceled or fulfilled (True/False)
);

-- Step 9: Sample Data Insertion (optional for testing purposes)
-- Insert data into 'core' table
INSERT INTO core (coreName, issueCTT) VALUES ('Core Enterprise 1', TRUE), ('Core Enterprise 2', FALSE);

-- Insert data into 'bank' table
INSERT INTO bank (bankName, limit) VALUES ('Bank A', 1000000), ('Bank B', 500000);

-- Insert data into 'supplier' table
INSERT INTO supplier (suppName, tier) VALUES ('Supplier 1', 'Tier 1'), ('Supplier 2', 'Tier 2');

-- Insert data into 'contract' table
INSERT INTO contract (realNo, part1, part2, amount, date) VALUES 
('CONTRACT001', 'Contract part 1 description', 'Contract part 2 description', 50000.00, '2023-01-01'),
('CONTRACT002', 'Contract part 1 description', 'Contract part 2 description', 75000.00, '2023-02-01');

-- Insert data into 'invoice' table
INSERT INTO invoice (contractID, amount, date) VALUES 
(1, 50000.00, '2023-01-15'),
(2, 75000.00, '2023-02-15');

-- Insert data into 'CTT' table
INSERT INTO CTT (total, invalidDate, burn) VALUES (2, '2023-12-31', FALSE);
