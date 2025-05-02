CREATE TABLE CTTBurnRecord (
    burnID INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(15, 2) NOT NULL,
    operationDate DATE,
    execTX VARCHAR(72)      
);
