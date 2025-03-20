package com.supplychainfinance.chaincode;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contact;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;

import com.owlike.genson.Genson;

@Contract(
    name = "InvoiceProcessorChaincode",
    info = @Info(
        title = "Invoice Processor Contract",
        description = "Process invoices and generate CTT tokens",
        version = "1.0.0"
    )
)
@Default
public class InvoiceProcessorChaincode implements ContractInterface {
    private static final Logger logger = Logger.getLogger(InvoiceProcessorChaincode.class.getName());
    private final Genson genson = new Genson();

    private enum InvoiceState {
        CREATED,
        APPROVED,
        REJECTED,
        PAID,
        TOKENIZED
    }

    private class Invoice {
        private String invoiceId;
        private String contractId;
        private String fromEnterpriseId;
        private String toEnterpriseId;
        private Double amount;
        private String issueDate;
        private String dueDate;
        private InvoiceState state;
        private String description;
        private String tokenId;  // ID of associated CTT token, if any

        public Invoice() {
            // Default constructor needed for serialization
        }

        public Invoice(String invoiceId, String contractId, String fromEnterpriseId, 
                     String toEnterpriseId, Double amount, String issueDate, 
                     String dueDate, String description) {
            this.invoiceId = invoiceId;
            this.contractId = contractId;
            this.fromEnterpriseId = fromEnterpriseId;
            this.toEnterpriseId = toEnterpriseId;
            this.amount = amount;
            this.issueDate = issueDate;
            this.dueDate = dueDate;
            this.state = InvoiceState.CREATED;
            this.description = description;
            this.tokenId = "";
        }

        // Getters and setters
        public String getInvoiceId() { return invoiceId; }
        public void setInvoiceId(String invoiceId) { this.invoiceId = invoiceId; }
        
        public String getContractId() { return contractId; }
        public void setContractId(String contractId) { this.contractId = contractId; }
        
        public String getFromEnterpriseId() { return fromEnterpriseId; }
        public void setFromEnterpriseId(String fromEnterpriseId) { this.fromEnterpriseId = fromEnterpriseId; }
        
        public String getToEnterpriseId() { return toEnterpriseId; }
        public void setToEnterpriseId(String toEnterpriseId) { this.toEnterpriseId = toEnterpriseId; }
        
        public Double getAmount() { return amount; }
        public void setAmount(Double amount) { this.amount = amount; }
        
        public String getIssueDate() { return issueDate; }
        public void setIssueDate(String issueDate) { this.issueDate = issueDate; }
        
        public String getDueDate() { return dueDate; }
        public void setDueDate(String dueDate) { this.dueDate = dueDate; }
        
        public InvoiceState getState() { return state; }
        public void setState(InvoiceState state) { this.state = state; }
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        
        public String getTokenId() { return tokenId; }
        public void setTokenId(String tokenId) { this.tokenId = tokenId; }
    }

    /**
     * Initialize the chaincode
     */
    @Transaction
    public void initLedger(final Context ctx) {
        logger.info("Initializing Invoice Processor Chaincode");
        // No initial invoices needed
    }

    /**
     * Create a new invoice
     */
    @Transaction
    public String createInvoice(final Context ctx, String invoiceId, String contractId, 
                              String fromEnterpriseId, String toEnterpriseId, 
                              Double amount, String issueDate, String dueDate, 
                              String description) {
        logger.info("Creating new invoice with ID: " + invoiceId);
        
        ChaincodeStub stub = ctx.getStub();
        
        // Check if invoice already exists
        String invoiceState = stub.getStringState(invoiceId);
        if (!invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s already exists", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_ALREADY_EXISTS");
        }
        
        // Create new invoice
        Invoice invoice = new Invoice(invoiceId, contractId, fromEnterpriseId, 
                                    toEnterpriseId, amount, issueDate, 
                                    dueDate, description);
        
        // Save invoice to state
        String invoiceJSON = genson.serialize(invoice);
        stub.putStringState(invoiceId, invoiceJSON);
        
        logger.info("Invoice created successfully: " + invoiceJSON);
        return invoiceJSON;
    }

    /**
     * Approve an invoice
     */
    @Transaction
    public String approveInvoice(final Context ctx, String invoiceId, String approverId) {
        logger.info(String.format("Approving invoice %s by %s", invoiceId, approverId));
        
        ChaincodeStub stub = ctx.getStub();
        
        // Get invoice state
        String invoiceState = stub.getStringState(invoiceId);
        if (invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }
        
        // Deserialize the invoice
        Invoice invoice = genson.deserialize(invoiceState, Invoice.class);
        
        // Check if the approver is the recipient
        if (!invoice.getToEnterpriseId().equals(approverId)) {
            String errorMessage = String.format("Approver %s is not the recipient of invoice %s", 
                                               approverId, invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "UNAUTHORIZED_APPROVAL");
        }
        
        // Approve invoice
        invoice.setState(InvoiceState.APPROVED);
        
        // Save updated invoice
        String updatedInvoiceJSON = genson.serialize(invoice);
        stub.putStringState(invoiceId, updatedInvoiceJSON);
        
        logger.info("Invoice approved successfully: " + updatedInvoiceJSON);
        return updatedInvoiceJSON;
    }

    /**
     * Tokenize an invoice - generates a CTT token for the invoice
     */
    @Transaction
    public String tokenizeInvoice(final Context ctx, String invoiceId) {
        logger.info("Tokenizing invoice with ID: " + invoiceId);
        
        ChaincodeStub stub = ctx.getStub();
        
        // Get invoice state
        String invoiceState = stub.getStringState(invoiceId);
        if (invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }
        
        // Deserialize the invoice
        Invoice invoice = genson.deserialize(invoiceState, Invoice.class);
        
        // Check if invoice is approved
        if (invoice.getState() != InvoiceState.APPROVED) {
            String errorMessage = String.format("Invoice %s is not approved", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_APPROVED");
        }
        
        // Check if invoice is already tokenized
        if (invoice.getState() == InvoiceState.TOKENIZED) {
            String errorMessage = String.format("Invoice %s is already tokenized", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_ALREADY_TOKENIZED");
        }
        
        // Generate token ID
        String tokenId = "CTT-" + invoiceId;
        
        // Update invoice state
        invoice.setState(InvoiceState.TOKENIZED);
        invoice.setTokenId(tokenId);
        
        // Save updated invoice
        String updatedInvoiceJSON = genson.serialize(invoice);
        stub.putStringState(invoiceId, updatedInvoiceJSON);
        
        // Call CTT Token chaincode to generate token
        // NOTE: In Fabric v2+, we can use chaincode-to-chaincode invocation
        
        // Here we would normally invoke the CTT chaincode using ctx.getStub().invokeChaincode()
        // But for simplicity in this example, we'll just log that we'd do this
        logger.info(String.format("Would invoke CTT chaincode to generate token %s for invoice %s", 
                                 tokenId, invoiceId));
        
        logger.info("Invoice tokenized successfully: " + updatedInvoiceJSON);
        return updatedInvoiceJSON;
    }
    
    /**
     * Generate CTT token from an invoice and send to recipient
     */
    @Transaction
    public String generateCTTFromInvoice(final Context ctx, String invoiceId, String recipientId) {
        logger.info(String.format("Generating CTT from invoice %s to recipient %s", 
                                 invoiceId, recipientId));
        
        ChaincodeStub stub = ctx.getStub();
        
        // Get invoice state
        String invoiceState = stub.getStringState(invoiceId);
        if (invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }
        
        // Deserialize the invoice
        Invoice invoice = genson.deserialize(invoiceState, Invoice.class);
        
        // Check if invoice is approved
        if (invoice.getState() != InvoiceState.APPROVED) {
            String errorMessage = String.format("Invoice %s is not approved", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_APPROVED");
        }
        
        // Check if invoice is already tokenized
        if (invoice.getState() == InvoiceState.TOKENIZED) {
            String errorMessage = String.format("Invoice %s is already tokenized", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_ALREADY_TOKENIZED");
        }
        
        // Generate token ID
        String tokenId = "CTT-" + invoiceId;
        
        // Update invoice state
        invoice.setState(InvoiceState.TOKENIZED);
        invoice.setTokenId(tokenId);
        
        // Save updated invoice
        String updatedInvoiceJSON = genson.serialize(invoice);
        stub.putStringState(invoiceId, updatedInvoiceJSON);
        
        // Call CTT Token chaincode to generate token
        // Create parameters for CTT generation
        String issuer = invoice.getFromEnterpriseId();
        String owner = recipientId;
        Double amount = invoice.getAmount();
        String issuedDate = invoice.getIssueDate();
        String expiryDate = invoice.getDueDate();
        String description = "Token for invoice " + invoiceId;
        
        // Invoke CTT Token chaincode (using chaincode-to-chaincode invocation)
        List<byte[]> args = new ArrayList<>();
        args.add("genCTT".getBytes());
        args.add(tokenId.getBytes());
        args.add(issuer.getBytes());
        args.add(owner.getBytes());
        args.add(amount.toString().getBytes());
        args.add(issuedDate.getBytes());
        args.add(expiryDate.getBytes());
        args.add(invoiceId.getBytes());
        args.add(description.getBytes());
        
        try {
            // Invoke CTTTokenChaincode
            byte[] response = stub.invokeChaincode("cttTokenChaincode", args, "mychannel");
            String responseStr = new String(response);
            
            logger.info("CTT token generated from invoice: " + responseStr);
            return updatedInvoiceJSON;
        } catch (Exception e) {
            String errorMessage = "Failed to create CTT token: " + e.getMessage();
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_CREATION_FAILED");
        }
    }

    /**
     * Query a specific invoice
     */
    @Transaction
    public String queryInvoice(final Context ctx, String invoiceId) {
        logger.info("Querying invoice with ID: " + invoiceId);
        
        ChaincodeStub stub = ctx.getStub();
        String invoiceState = stub.getStringState(invoiceId);
        
        if (invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.info(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }
        
        logger.info("Invoice found: " + invoiceState);
        return invoiceState;
    }
    
    /**
     * Query all invoices
     */
    @Transaction
    public String queryAllInvoices(final Context ctx) {
        logger.info("Querying all invoices");
        
        ChaincodeStub stub = ctx.getStub();
        List<Invoice> allInvoices = new ArrayList<>();
        
        // Range query with empty string for startKey and endKey returns all invoices
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");
        
        for (KeyValue result : results) {
            Invoice invoice = genson.deserialize(result.getStringValue(), Invoice.class);
            allInvoices.add(invoice);
        }
        
        String invoicesJSON = genson.serialize(allInvoices);
        logger.info("All invoices: " + invoicesJSON);
        return invoicesJSON;
    }
}