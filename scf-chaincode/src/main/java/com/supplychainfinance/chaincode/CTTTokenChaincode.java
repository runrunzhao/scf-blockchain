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
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;

import com.owlike.genson.Genson;
import com.supplychainfinance.chaincode.model.CTTToken;
import com.supplychainfinance.chaincode.model.TokenState;

@Contract(
    name = "CTTTokenChaincode",
    info = @Info(
        title = "CTT Token Contract",
        description = "Supply Chain Finance Token Contract",
        version = "1.0.0"
    )
)
@Default
public class CTTTokenChaincode implements ContractInterface {
    private static final Logger logger = Logger.getLogger(CTTTokenChaincode.class.getName());
    private final Genson genson = new Genson();
    
    /**
     * Initialize the chaincode
     */
    @Transaction
    public void initLedger(final Context ctx) {
        logger.info("Initializing CTT Token Chaincode");
        // No initial tokens needed, they will be generated from invoices
    }
    
    /**
     * Generate a new CTT token
     */
    @Transaction
    public String genCTT(final Context ctx, String tokenId, String issuer, String owner, 
                      Double amount, String issuedDate, String expiryDate, 
                      String sourceInvoiceId, String description) {
        logger.info("Generating new CTT token with ID: " + tokenId);
        
        ChaincodeStub stub = ctx.getStub();
        
        // Check if token already exists
        String tokenState = stub.getStringState(tokenId);
        if (!tokenState.isEmpty()) {
            String errorMessage = String.format("Token %s already exists", tokenId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_ALREADY_EXISTS");
        }
        
        // Create new token
        CTTToken token = new CTTToken(tokenId, issuer, owner, amount, issuedDate, 
                                    expiryDate, sourceInvoiceId, description);
        
        // Save token to state
        String tokenJSON = genson.serialize(token);
        stub.putStringState(tokenId, tokenJSON);
        
        logger.info("Token generated successfully: " + tokenJSON);
        return tokenJSON;
    }
    
    /**
     * Transfer a CTT token to a new owner
     */
    @Transaction
    public String transferCTT(final Context ctx, String tokenId, String currentOwner, String newOwner) {
        logger.info(String.format("Transferring token %s from %s to %s", tokenId, currentOwner, newOwner));
        
        ChaincodeStub stub = ctx.getStub();
        
        // Get token state
        String tokenState = stub.getStringState(tokenId);
        if (tokenState.isEmpty()) {
            String errorMessage = String.format("Token %s does not exist", tokenId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_NOT_FOUND");
        }
        
        // Deserialize the token
        CTTToken token = genson.deserialize(tokenState, CTTToken.class);
        
        // Verify current owner
        if (!token.getOwner().equals(currentOwner)) {
            String errorMessage = String.format("Token %s is not owned by %s", tokenId, currentOwner);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "UNAUTHORIZED_TRANSFER");
        }
        
        // Verify token state
        if (token.getState() == TokenState.REDEEMED) {
            String errorMessage = String.format("Token %s has already been redeemed", tokenId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_ALREADY_REDEEMED");
        }
        
        // Transfer token
        token.setOwner(newOwner);
        token.setState(TokenState.TRANSFERRED);
        
        // Save updated token
        String updatedTokenJSON = genson.serialize(token);
        stub.putStringState(tokenId, updatedTokenJSON);
        
        logger.info("Token transferred successfully: " + updatedTokenJSON);
        return updatedTokenJSON;
    }
    
    /**
     * Redeem a CTT token
     */
    @Transaction
    public String redeemCTT(final Context ctx, String tokenId, String owner) {
        logger.info(String.format("Redeeming token %s by owner %s", tokenId, owner));
        
        ChaincodeStub stub = ctx.getStub();
        
        // Get token state
        String tokenState = stub.getStringState(tokenId);
        if (tokenState.isEmpty()) {
            String errorMessage = String.format("Token %s does not exist", tokenId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_NOT_FOUND");
        }
        
        // Deserialize the token
        CTTToken token = genson.deserialize(tokenState, CTTToken.class);
        
        // Verify owner
        if (!token.getOwner().equals(owner)) {
            String errorMessage = String.format("Token %s is not owned by %s", tokenId, owner);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "UNAUTHORIZED_REDEMPTION");
        }
        
        // Verify token state
        if (token.getState() == TokenState.REDEEMED) {
            String errorMessage = String.format("Token %s has already been redeemed", tokenId);
            logger.severe(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_ALREADY_REDEEMED");
        }
        
        // Redeem token
        token.setState(TokenState.REDEEMED);
        
        // Save updated token
        String updatedTokenJSON = genson.serialize(token);
        stub.putStringState(tokenId, updatedTokenJSON);
        
        logger.info("Token redeemed successfully: " + updatedTokenJSON);
        return updatedTokenJSON;
    }
    
    /**
     * Query a specific token
     */
    @Transaction
    public String queryCTT(final Context ctx, String tokenId) {
        logger.info("Querying token with ID: " + tokenId);
        
        ChaincodeStub stub = ctx.getStub();
        String tokenState = stub.getStringState(tokenId);
        
        if (tokenState.isEmpty()) {
            String errorMessage = String.format("Token %s does not exist", tokenId);
            logger.info(errorMessage);
            throw new ChaincodeException(errorMessage, "TOKEN_NOT_FOUND");
        }
        
        logger.info("Token found: " + tokenState);
        return tokenState;
    }
    
    /**
     * Query tokens by owner
     */
    @Transaction
    public String queryTokensByOwner(final Context ctx, String owner) {
        logger.info("Querying tokens for owner: " + owner);
        
        ChaincodeStub stub = ctx.getStub();
        
        // Get all tokens and filter by owner
        String queryString = "{\"selector\":{\"owner\":\"" + owner + "\"}}";
        List<CTTToken> ownerTokens = new ArrayList<>();
        
        // Run the query
        QueryResultsIterator<KeyValue> results = stub.getQueryResult(queryString);
        
        for (KeyValue result : results) {
            CTTToken token = genson.deserialize(result.getStringValue(), CTTToken.class);
            ownerTokens.add(token);
        }
        
        String tokensJSON = genson.serialize(ownerTokens);
        logger.info("Found tokens: " + tokensJSON);
        return tokensJSON;
    }
    
    /**
     * Query all tokens
     */
    @Transaction
    public String queryAllTokens(final Context ctx) {
        logger.info("Querying all tokens");
        
        ChaincodeStub stub = ctx.getStub();
        List<CTTToken> allTokens = new ArrayList<>();
        
        // Range query with empty string for startKey and endKey returns all tokens
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");
        
        for (KeyValue result : results) {
            CTTToken token = genson.deserialize(result.getStringValue(), CTTToken.class);
            allTokens.add(token);
        }
        
        String tokensJSON = genson.serialize(allTokens);
        logger.info("All tokens: " + tokensJSON);
        return tokensJSON;
    }
}