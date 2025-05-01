ALTER TABLE loanRecord
ADD COLUMN issueDate DATE AFTER interestRate;

ALTER TABLE loanRecord
MODIFY COLUMN correspondpingTXDate DATE;
