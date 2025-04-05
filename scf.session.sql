CREATE TABLE SCToken (
    tokenID INT AUTO_INCREMENT PRIMARY KEY,
    owerAddr VARCHAR(42) NOT NULL,
    tokenName VARCHAR(64) NOT NULL,
    tokenSymbol VARCHAR(16) NOT NULL,
    scexpireDate DATETIME NOT NULL,
    genContractAddr VARCHAR(42),
    scCreateTime DATETIME,
    tokenAmount DECIMAL(15, 2),
    tokenCreateTime DATETIME,
    memo VARCHAR(64)
);