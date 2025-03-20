package com.supplychainfinance.chaincode;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.Chaincode;
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;

import com.owlike.genson.Genson;
import com.supplychainfinance.chaincode.model.Invoice;
import com.supplychainfinance.chaincode.model.InvoiceState;

@Contract(name = "InvoiceProcessorChaincode", info = @Info(title = "Invoice Processor Contract", description = "Process invoices and generate CTT tokens", version = "1.0.0"))
@Default
public class InvoiceProcessorChaincode implements ContractInterface {
    private static final Logger logger = Logger.getLogger(InvoiceProcessorChaincode.class.getName());
    private final Genson genson = new Genson();

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
        if (invoiceState != null && !invoiceState.isEmpty()) {
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
        logger.info("Approving invoice with ID: " + invoiceId);

        ChaincodeStub stub = ctx.getStub();

        // Get invoice state
        String invoiceState = stub.getStringState(invoiceId);
        if (invoiceState == null || invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }

        // Deserialize the invoice
        Invoice invoice = genson.deserialize(invoiceState, Invoice.class);

        // Verify invoice state
        if (invoice.getState() != InvoiceState.CREATED) {
            String errorMessage = String.format("Invoice %s is not in CREATED state", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVALID_INVOICE_STATE");
        }

        // Update invoice state
        invoice.setState(InvoiceState.APPROVED);

        // Save updated invoice
        String updatedInvoiceJSON = genson.serialize(invoice);
        stub.putStringState(invoiceId, updatedInvoiceJSON);

        logger.info("Invoice approved successfully: " + updatedInvoiceJSON);
        return updatedInvoiceJSON;
    }

    /**
     * Flag an invoice as tokenized (CTT token generated)
     */
    @Transaction
    public String tokenizeInvoice(final Context ctx, String invoiceId) {
        logger.info("Tokenizing invoice with ID: " + invoiceId);

        ChaincodeStub stub = ctx.getStub();

        // Get invoice state
        String invoiceState = stub.getStringState(invoiceId);
        if (invoiceState == null || invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }

        // Deserialize the invoice
        Invoice invoice = genson.deserialize(invoiceState, Invoice.class);

        // Verify invoice state
        if (invoice.getState() != InvoiceState.APPROVED) {
            String errorMessage = String.format("Invoice %s must be in APPROVED state to tokenize", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVALID_INVOICE_STATE");
        }

        // Update invoice state
        invoice.setState(InvoiceState.TOKENIZED);

        // Save updated invoice
        String updatedInvoiceJSON = genson.serialize(invoice);
        stub.putStringState(invoiceId, updatedInvoiceJSON);

        logger.info("Invoice tokenized successfully: " + updatedInvoiceJSON);
        return updatedInvoiceJSON;
    }

    /**
     * Generate a CTT token from an approved invoice
     */
    @Transaction
    public String generateCTTFromInvoice(final Context ctx, String invoiceId, String recipientId) {
        logger.info("Generating CTT token from invoice with ID: " + invoiceId);

        ChaincodeStub stub = ctx.getStub();

        // Get invoice state
        String invoiceState = stub.getStringState(invoiceId);
        if (invoiceState == null || invoiceState.isEmpty()) {
            String errorMessage = String.format("Invoice %s does not exist", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_NOT_FOUND");
        }

        // Deserialize the invoice
        Invoice invoice = genson.deserialize(invoiceState, Invoice.class);

        // Verify invoice state
        if (invoice.getState() != InvoiceState.APPROVED) {
            String errorMessage = String.format("Invoice %s must be in APPROVED state to generate token", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVALID_INVOICE_STATE");
        }

        try {
            // Generate a unique token ID
            String tokenId = "CTT-" + invoiceId;

            // 创建字符串参数列表
            List<String> stringArgs = new ArrayList<>();
            stringArgs.add("genCTT");
            stringArgs.add(tokenId);
            stringArgs.add(invoice.getFromEnterpriseId()); // issuer
            stringArgs.add(recipientId); // recipient/owner
            stringArgs.add(invoice.getAmount().toString());
            stringArgs.add(invoice.getIssueDate());
            stringArgs.add(invoice.getDueDate());
            stringArgs.add(invoiceId);
            stringArgs.add(invoice.getDescription());

            // 将字符串参数转换为字节数组列表
            List<byte[]> args = new ArrayList<>();
            for (String arg : stringArgs) {
                args.add(arg.getBytes());
            }

            // Invoke CTTTokenChaincode
            Chaincode.Response response = stub.invokeChaincode("cttTokenChaincode", args, "mychannel");

            // 检查响应是否为 null
            if (response == null) {
                String errorMessage = "CTT token generation failed: null response";
                logger.severe(errorMessage);
                throw new ChaincodeException(errorMessage, "TOKEN_CREATION_FAILED");
            }

            // 获取响应的有效载荷
            byte[] payload = response.getPayload();
            if (payload == null || payload.length == 0) {
                String errorMessage = "CTT token generation failed: empty payload";
                logger.severe(errorMessage);
                throw new ChaincodeException(errorMessage, "TOKEN_CREATION_FAILED");
            }

            String responseStr = new String(payload);

            // Update invoice with token ID and state
            invoice.setTokenId(tokenId);
            invoice.setState(InvoiceState.TOKENIZED);

            // Save updated invoice
            String updatedInvoiceJSON = genson.serialize(invoice);
            stub.putStringState(invoiceId, updatedInvoiceJSON);

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

        if (invoiceState == null || invoiceState.isEmpty()) {
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

        try {
            for (KeyValue result : results) {
                String value = result.getStringValue();
                if (value != null && !value.isEmpty()) {
                    Invoice invoice = genson.deserialize(value, Invoice.class);
                    allInvoices.add(invoice);
                }
            }

            String invoicesJSON = genson.serialize(allInvoices);
            logger.info("All invoices retrieved: " + invoicesJSON);
            return invoicesJSON;
        } finally {
            try {
                if (results != null) {
                    results.close(); 
                }
            } catch (Exception e) {
                logger.warning("Error closing query results: " + e.getMessage());
            }
        }
    }
}