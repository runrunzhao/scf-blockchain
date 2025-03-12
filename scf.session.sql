select  * from contract ;
DESCRIBE invoice;

ALTER TABLE invoice MODIFY COLUMN status ENUM('Pending','End','Draft','Approved','Paid','Rejected') NOT NULL;