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

import com.owlike.genson.Genson;
import com.supplychainfinance.chaincode.model.Invoice;
import com.supplychainfinance.chaincode.model.InvoiceState;

@Contract(name = "InvoiceProcessorChaincode", info = @Info(title = "Invoice Processor Contract", description = "Process invoices and CTT payments", version = "1.0.0"))
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
     * Pay an invoice using CTT tokens - transferring from issuer to receiver
     */
    @Transaction
    public String payCTTFromInvoice(final Context ctx, String invoiceId, String tokenId) {
        logger.info(String.format("Processing payment for invoice %s using token %s", invoiceId, tokenId));

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

        // Verify invoice is not already paid
        if (invoice.getState() == InvoiceState.PAID) {
            String errorMessage = String.format("Invoice %s has already been paid", invoiceId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "INVOICE_ALREADY_PAID");
        }

        try {
            // Create arguments for transferring CTT token from issuer to receiver
            List<String> stringArgs = new ArrayList<>();
            stringArgs.add("transferCTT");
            stringArgs.add(tokenId);                   // token to transfer
            stringArgs.add(invoice.getFromEnterpriseId()); // FROM: issuer (payer)
            stringArgs.add(invoice.getToEnterpriseId());   // TO: receiver (payee)
            
            // Convert arguments to byte arrays
            List<byte[]> args = new ArrayList<>();
            for (String arg : stringArgs) {
                args.add(arg.getBytes());
            }

            // Invoke CTTTokenChaincode to transfer the token
            Chaincode.Response response = stub.invokeChaincode("cttTokenChaincode", args, "mychannel");

            if (response.getStatus() != Chaincode.Response.Status.SUCCESS) {
                String errorMessage = "CTT token transfer failed: " + response.getMessage();
                logger.severe(errorMessage);
                throw new ChaincodeException(errorMessage, "TOKEN_TRANSFER_FAILED");
            }

            // Update invoice state to PAID
            invoice.setState(InvoiceState.PAID);
            invoice.setTokenId(tokenId);

            // Save updated invoice
            String updatedInvoiceJSON = genson.serialize(invoice);
            stub.putStringState(invoiceId, updatedInvoiceJSON);

            logger.info("Invoice paid successfully: " + updatedInvoiceJSON);
            return updatedInvoiceJSON;
        } catch (Exception e) {
            String errorMessage = "Failed to process payment: " + e.getMessage();
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "PAYMENT_PROCESSING_FAILED");
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
}