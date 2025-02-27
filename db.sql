mvn jetty:run


docker exec -it scf-mysql bash ;

INSERT INTO enterprise VALUES ('001', 'XYZ Corp', 'London', '123-456-7890','Core');

ALTER TABLE enterprise  ADD COLUMN tier INT;


CREATE TABLE contract (
    contractID char(8) PRIMARY KEY,  -- Contract ID
    realNo VARCHAR(100) NOT NULL,               -- Real contract number
    part1 VARCHAR(255),                                 -- Part 1 of the contract 
    part2 VARCHAR(255),                                 -- Part 2 of the contract 
    amount DECIMAL(15, 2) NOT NULL,             -- Contract amount
    signingDate DATE NOT NULL ,
    effectiveDate  DATE NOT NULL ,
    invalidDate DATE NOT NULL  ,
    status ENUM('Active', 'Pending','End','drfting') NOT NULL                      
    );

-- Step 7: Create 'invoice' table
CREATE TABLE invoice (
    invoiceID char(8) PRIMARY KEY,   -- Invoice ID
    contractID char(8),                             -- Contract ID 
    amount DECIMAL(15, 2) NOT NULL,             -- Invoice amount
    date DATE NOT NULL,                         -- Invoice creation date
    FOREIGN KEY (contractID) REFERENCES contract(contractID) -- Foreign key to contract table
);

docker run --name scf-mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=SCFDB -p 3306:3306 -d mysql:5.7
-- Step 1: Create the database
CREATE DATABASE SCFDB;

-- Step 2: Switch to the SCFDB database
USE SCFDB;


git add .                        
git commit -m "02261824"     
git push origin main             


docker ps -a | grep scf-mysql
docker start scf-mysql

docker exec -it scf-mysql bash
mysql -u root -p


CREATE TABLE enterprise(
    enterpriseID char(8) PRIMARY KEY,      -- enterID
    enterpriseName VARCHAR(255) NOT NULL,              --  name
    address VARCHAR(255) NOT NULL,
    telephone CHAR(12) NOT NULL,
    role ENUM('Core', 'Bank','Supplier','Distributor') NOT NULL ，
    tier INT
);


mvn package
mvn jetty:run

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
INSERT INTO contract (contractID,realNo, part1, part2, amount, date) VALUES 
('CRT001', 'realCrt001', 'C001','S427', 50000.00, '2025-02-01',),
('CONTRACT002', 'Contract part 1 description', 'Contract part 2 description', 75000.00, '2023-02-01');

-- Insert data into 'invoice' table
INSERT INTO invoice (contractID, amount, date) VALUES 
(1, 50000.00, '2023-01-15'),
(2, 75000.00, '2023-02-15');

-- Insert data into 'CTT' table
INSERT INTO CTT (total, invalidDate, burn) VALUES (2, '2023-12-31', FALSE);

mvn jetty:run


docker exec -it scf-mysql bash ;

INSERT INTO enterprise VALUES ('001', 'XYZ Corp', 'London', '123-456-7890','Core');

ALTER TABLE enterprise  ADD COLUMN tier INT;


CREATE TABLE contract (
    contractID char(8) PRIMARY KEY,  -- Contract ID
    realNo VARCHAR(100) NOT NULL,               -- Real contract number
    part1 CHAR(8),                                 -- Part 1 of the contract 
    part2 CHAR(8),                                 -- Part 2 of the contract 
    amount DECIMAL(15, 2) NOT NULL,             -- Contract amount
    signingDate DATE NOT NULL ,
    effectiveDate  DATE NOT NULL ,
    invalidDate DATE NOT NULL  ,
    status ENUM('Active', 'Pending','End','drfting') NOT NULL                      
    );

-- Step 7: Create 'invoice' table
CREATE TABLE invoice (
    invoiceID char(8) PRIMARY KEY,   -- Invoice ID
    contractID char(8),                             -- Contract ID 
    amount DECIMAL(15, 2) NOT NULL,             -- Invoice amount
    createdate DATE NOT NULL,                         -- Invoice creation date
    FOREIGN KEY (contractID) REFERENCES contract(contractID) -- Foreign key to contract table
);

C001         | rewtew         | dfdsaf        | 66666     | Core        | 22222222     | NULL |
D419         | gsgfgd         | rewrite       | 32313     | Distributor | fdasfdsa     |    1 |
S427         | rwre           | 32132         | 32313     | Supplier    | FDSA         |    1 |
S947         | bbagag         | dsafsdafdsafs | 123444    | Supplier    | fdasfsafdsaf | 



INSERT INTO contract (contractID,realNo, part1, part2, amount, signingDate,effectiveDate,invalidDate,status) VALUES ('CRT001', 'realCrt001', 'C001','S427', 50000.00, '2025-02-01','2025-02-01','2026-02-01','Active');


SELECT c.*, e1.enterpriseName as fromEnterpriseName, e2.enterpriseName as toEnterpriseName FROM contract c LEFT JOIN enterprise e1 ON c.fromEnterpriseId = e1.enterpriseID LEFT JOIN enterprise e2 ON c.toEnterpriseId = e2.enterpriseID WHERE 1=1