mvn jetty:run
docker ps -a | grep scf-mysql
-- docker run --name scf-mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=SCFDB -p 3306:3306 -d mysql:5.7
docker start scf-mysql
docker exec -it scf-mysql bash ;

docker exec -it scf-mysql mysqldump -u root -p SCFDB > backup0418.sql
docker exec -i scf-mysql mysql -u root -ppassword SCFDB < /workspaces/scf-blockchain/backup0418.sql

git add .                        
git commit -m "02261824"     
git push origin main    
 git push second  main
 
select * from  users;
-- 用户表 - 存储注册用户信息
CREATE TABLE  users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,  
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL ,
    enterprise_id  char(8),  
    registration_date date,
    last_login TIMESTAMP,
    account_status ENUM('active', 'inactive', 'suspended', 'pending') DEFAULT 'active',
    memo VARCHAR(100)
    
);

ALTER TABLE users ADD COLUMN walletAddr VARCHAR(42);

-- 用户角色表 - 用于权限管理
CREATE TABLE IF NOT EXISTS user_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    role_name VARCHAR(30) NOT NULL,  -- 如: admin, user, enterprise_manager等
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_role (user_id, role_name)
);

-- 密码重置令牌表 - 用于支持忘记密码功能
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    expiry_date TIMESTAMP NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 登录日志表 - 记录用户登录活动
CREATE TABLE IF NOT EXISTS login_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),  -- 支持IPv6地址
    device_info VARCHAR(255),
    success BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

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
    status ENUM('Active', 'Pending','End','drfting') NOT NULL,
    remarks VARCHAR(255)                        
                   
    );

-- Step 7: Create 'invoice' table
CREATE TABLE invoice (
    invoiceID char(8) PRIMARY KEY,   -- Invoice ID
    contractID char(8),                             -- Contract ID 
    amount DECIMAL(15, 2) NOT NULL,             -- Invoice amount
    PayDate DATE NOT NULL,   
    status ENUM('Pending','End','Draft') NOT NULL,                      -- Invoice creation date
    memo VARCHAR(255),
    FOREIGN KEY (contractID) REFERENCES contract(contractID) -- Foreign key to contract table
);

ALTER TABLE invoice
ADD paymentMethod ENUM('Bank Transfer', 'Credit Card', 'Check', 'CTT') DEFAULT NULL;

--0404 1720 add table SCToken
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

--ALTER TABLE SCToken
--ADD COLUMN multContractAddr VARCHAR(42),
--ADD COLUMN multiCreateTime DATETIME;


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
ALTER TABLE scMulti
ADD COLUMN requiredConfirmations INT AFTER signer3;

CREATE TABLE scTransMultiConnection (
    connectionID INT AUTO_INCREMENT PRIMARY KEY,
    scTransAddr VARCHAR(42) NOT NULL,
    scMultiAddr VARCHAR(42) NOT NULL,
    scConnectTime DATETIME,
    signTx VARCHAR(72),
    memo VARCHAR(42)
);


docker run --name scf-mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=SCFDB -p 3306:3306 -d mysql:5.7
-- Step 1: Create the database
CREATE DATABASE SCFDB;

-- Step 2: Switch to the SCFDB database
USE SCFDB;

--git pull origin 

         


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