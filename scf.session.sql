ALTER TABLE invoice
MODIFY COLUMN paymentMethod ENUM('CTT', 'Transfer', 'Check', 'Card') DEFAULT NULL;
