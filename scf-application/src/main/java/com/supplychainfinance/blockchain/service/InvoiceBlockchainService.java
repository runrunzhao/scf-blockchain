package com.supplychainfinance.blockchain.service;

import com.supplychainfinance.blockchain.connection.FabricGatewayManager;
import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.ContractException;

import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeoutException;
import java.util.logging.Logger;

public class InvoiceBlockchainService {
    private static final Logger logger = Logger.getLogger(InvoiceBlockchainService.class.getName());
    private final FabricGatewayManager gatewayManager;

    public InvoiceBlockchainService() {
        this.gatewayManager = FabricGatewayManager.getInstance();
    }

    /**
     * Create a new invoice in the blockchain
     */
    public String createInvoice(String invoiceId, String contractId, 
                              String fromEnterpriseId, String toEnterpriseId, 
                              double amount, String issueDate, String dueDate, 
                              String description) {
        try {
            Contract contract = gatewayManager.getInvoiceProcessorContract();
            
            byte[] result = contract.submitTransaction(
                "createInvoice",
                invoiceId,
                contractId,
                fromEnterpriseId,
                toEnterpriseId,
                String.valueOf(amount),
                issueDate,
                dueDate,
                description
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Created invoice on blockchain: " + response);
            return response;
            
        } catch (ContractException | TimeoutException | InterruptedException e) {
            logger.severe("Error creating invoice on blockchain: " + e.getMessage());
            throw new RuntimeException("Failed to create invoice on blockchain", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in createInvoice: " + e.getMessage());
            throw new RuntimeException("Unexpected error in createInvoice", e);
        }
    }

    /**
     * Approve an invoice in the blockchain
     */
    public String approveInvoice(String invoiceId, String approverId) {
        try {
            Contract contract = gatewayManager.getInvoiceProcessorContract();
            
            byte[] result = contract.submitTransaction(
                "approveInvoice",
                invoiceId,
                approverId
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Approved invoice on blockchain: " + response);
            return response;
            
        } catch (ContractException | TimeoutException | InterruptedException e) {
            logger.severe("Error approving invoice on blockchain: " + e.getMessage());
            throw new RuntimeException("Failed to approve invoice on blockchain", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in approveInvoice: " + e.getMessage());
            throw new RuntimeException("Unexpected error in approveInvoice", e);
        }
    }

    /**
     * Generate CTT token from an invoice and send to a recipient
     */
    public String generateCTTFromInvoice(String invoiceId, String recipientId) {
        try {
            Contract contract = gatewayManager.getInvoiceProcessorContract();
            
            byte[] result = contract.submitTransaction(
                "generateCTTFromInvoice",
                invoiceId,
                recipientId
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Generated CTT from invoice: " + response);
            return response;
            
        } catch (ContractException | TimeoutException | InterruptedException e) {
            logger.severe("Error generating CTT from invoice: " + e.getMessage());
            throw new RuntimeException("Failed to generate CTT from invoice", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in generateCTTFromInvoice: " + e.getMessage());
            throw new RuntimeException("Unexpected error in generateCTTFromInvoice", e);
        }
    }

    /**
     * Query a specific invoice from the blockchain
     */
    public String queryInvoice(String invoiceId) {
        try {
            Contract contract = gatewayManager.getInvoiceProcessorContract();
            
            byte[] result = contract.evaluateTransaction(
                "queryInvoice",
                invoiceId
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Queried invoice: " + response);
            return response;
            
        } catch (ContractException e) {
            logger.severe("Error querying invoice: " + e.getMessage());
            throw new RuntimeException("Failed to query invoice", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in queryInvoice: " + e.getMessage());
            throw new RuntimeException("Unexpected error in queryInvoice", e);
        }
    }

    /**
     * Query all invoices from the blockchain
     */
    public String queryAllInvoices() {
        try {
            Contract contract = gatewayManager.getInvoiceProcessorContract();
            
            byte[] result = contract.evaluateTransaction("queryAllInvoices");
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Queried all invoices: " + response);
            return response;
            
        } catch (ContractException e) {
            logger.severe("Error querying all invoices: " + e.getMessage());
            throw new RuntimeException("Failed to query all invoices", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in queryAllInvoices: " + e.getMessage());
            throw new RuntimeException("Unexpected error in queryAllInvoices", e);
        }
    }
}