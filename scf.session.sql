


CREATE TABLE scTransMultiConnection (
    connectionID INT AUTO_INCREMENT PRIMARY KEY,
    scTransAddr VARCHAR(42) NOT NULL,
    scMultiAddr VARCHAR(42) NOT NULL,
    scConnectTime DATETIME,
    memo VARCHAR(42)
);
