package com.supplychainfinance.blockchain.service;

import com.supplychainfinance.blockchain.connection.FabricGatewayManager;
import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.ContractException;

import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeoutException;
import java.util.logging.Logger;

public class CTTTokenService {
    private static final Logger logger = Logger.getLogger(CTTTokenService.class.getName());
    private final FabricGatewayManager gatewayManager;

    public CTTTokenService() {
        this.gatewayManager = FabricGatewayManager.getInstance();
    }

    /**
     * Generate a new CTT token
     */
    public String generateCTTToken(String tokenId, String issuer, String owner, 
                                 double amount, String issuedDate, String expiryDate,
                                 String sourceInvoiceId, String description) {
        try {
            Contract contract = gatewayManager.getCTTTokenContract();
            
            byte[] result = contract.submitTransaction(
                "genCTT",
                tokenId,
                issuer,
                owner,
                String.valueOf(amount),
                issuedDate,
                expiryDate,
                sourceInvoiceId,
                description
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Generated CTT token: " + response);
            return response;
            
        } catch (ContractException | TimeoutException | InterruptedException e) {
            logger.severe("Error generating CTT token: " + e.getMessage());
            throw new RuntimeException("Failed to generate CTT token", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in generateCTTToken: " + e.getMessage());
            throw new RuntimeException("Unexpected error in generateCTTToken", e);
        }
    }

    /**
     * Transfer a CTT token to a new owner
     */
    public String transferCTTToken(String tokenId, String currentOwner, String newOwner) {
        try {
            Contract contract = gatewayManager.getCTTTokenContract();
            
            byte[] result = contract.submitTransaction(
                "transferCTT",
                tokenId,
                currentOwner,
                newOwner
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Transferred CTT token: " + response);
            return response;
            
        } catch (ContractException | TimeoutException | InterruptedException e) {
            logger.severe("Error transferring CTT token: " + e.getMessage());
            throw new RuntimeException("Failed to transfer CTT token", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in transferCTTToken: " + e.getMessage());
            throw new RuntimeException("Unexpected error in transferCTTToken", e);
        }
    }

    /**
     * Redeem a CTT token
     */
    public String redeemCTTToken(String tokenId, String owner) {
        try {
            Contract contract = gatewayManager.getCTTTokenContract();
            
            byte[] result = contract.submitTransaction(
                "redeemCTT",
                tokenId,
                owner
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Redeemed CTT token: " + response);
            return response;
            
        } catch (ContractException | TimeoutException | InterruptedException e) {
            logger.severe("Error redeeming CTT token: " + e.getMessage());
            throw new RuntimeException("Failed to redeem CTT token", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in redeemCTTToken: " + e.getMessage());
            throw new RuntimeException("Unexpected error in redeemCTTToken", e);
        }
    }

    /**
     * Query a CTT token
     */
    public String queryToken(String tokenId) {
        try {
            Contract contract = gatewayManager.getCTTTokenContract();
            
            byte[] result = contract.evaluateTransaction(
                "queryCTT",
                tokenId
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Queried CTT token: " + response);
            return response;
            
        } catch (ContractException e) {
            logger.severe("Error querying CTT token: " + e.getMessage());
            throw new RuntimeException("Failed to query CTT token", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in queryToken: " + e.getMessage());
            throw new RuntimeException("Unexpected error in queryToken", e);
        }
    }

    /**
     * Query tokens by owner
     */
    public String queryTokensByOwner(String owner) {
        try {
            Contract contract = gatewayManager.getCTTTokenContract();
            
            byte[] result = contract.evaluateTransaction(
                "queryTokensByOwner",
                owner
            );
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Queried tokens for owner: " + response);
            return response;
            
        } catch (ContractException e) {
            logger.severe("Error querying tokens by owner: " + e.getMessage());
            throw new RuntimeException("Failed to query tokens by owner", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in queryTokensByOwner: " + e.getMessage());
            throw new RuntimeException("Unexpected error in queryTokensByOwner", e);
        }
    }

    /**
     * Query all tokens
     */
    public String queryAllTokens() {
        try {
            Contract contract = gatewayManager.getCTTTokenContract();
            
            byte[] result = contract.evaluateTransaction("queryAllTokens");
            
            String response = new String(result, StandardCharsets.UTF_8);
            logger.info("Queried all tokens: " + response);
            return response;
            
        } catch (ContractException e) {
            logger.severe("Error querying all tokens: " + e.getMessage());
            throw new RuntimeException("Failed to query all tokens", e);
        } catch (Exception e) {
            logger.severe("Unexpected error in queryAllTokens: " + e.getMessage());
            throw new RuntimeException("Unexpected error in queryAllTokens", e);
        }
    }
}