package com.supplychainfinance.chaincode;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.util.Iterator;

import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.owlike.genson.Genson;
import com.supplychainfinance.chaincode.model.CTTToken;
import com.supplychainfinance.chaincode.model.TokenState;

@ExtendWith(MockitoExtension.class)
public class CTTTokenChaincodeTest {

    private final Genson genson = new Genson();

    private CTTTokenChaincode contract;

    @Mock(lenient = true)
    private Context ctx;

    @Mock(lenient = true)
    private ChaincodeStub stub;

    @Mock(lenient = true)
    private QueryResultsIterator<KeyValue> resultsIterator;

    @BeforeEach
    public void setup() {
        contract = new CTTTokenChaincode();
        when(ctx.getStub()).thenReturn(stub);
    }

    @Test
    public void testInitLedger() {
        // Just verify it runs without errors
        assertDoesNotThrow(() -> contract.initLedger(ctx));
    }

    @Test
    public void testGenCTT_Success() {
        // Setup
        String tokenId = "CTT";
        when(stub.getStringState(tokenId)).thenReturn("");

        // Execute
        String result = contract.genCTT(ctx, tokenId, "Issuer", "Owner", 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");

        // Verify
        verify(stub).putStringState(eq(tokenId), anyString());
        CTTToken token = genson.deserialize(result, CTTToken.class);
        assertEquals(tokenId, token.getTokenId());
        assertEquals("Issuer", token.getIssuer());
        assertEquals("Owner", token.getOwner());
        assertEquals(100.0, token.getAmount());
        assertEquals(TokenState.ISSUED, token.getState());
    }

    @Test
    public void testGenCTT_TokenExists() {
        // Setup - token already exists
        String tokenId = "CTT";
        when(stub.getStringState(tokenId)).thenReturn("{\"id\":\"CTT\"}");

        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.genCTT(ctx, tokenId, "Issuer", "Owner", 100.0,
                    "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        });

        assertEquals("TOKEN_ALREADY_EXISTS", new String(exception.getPayload()));
    }

    @Test
    public void testTransferCTT_Success() {
        // Setup
        String tokenId = "CTT";
        String currentOwner = "OwnerA";
        String newOwner = "OwnerB";

        CTTToken token = new CTTToken(tokenId, "Issuer", currentOwner, 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute
        String result = contract.transferCTT(ctx, tokenId, currentOwner, newOwner);

        // Verify
        verify(stub).putStringState(eq(tokenId), anyString());
        CTTToken updatedToken = genson.deserialize(result, CTTToken.class);
        assertEquals(newOwner, updatedToken.getOwner());
        assertEquals(TokenState.TRANSFERRED, updatedToken.getState());
    }

    @Test
    public void testTransferCTT_TokenNotFound() {
        // Setup - token doesn't exist
        String tokenId = "CTT";
        when(stub.getStringState(tokenId)).thenReturn("");

        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.transferCTT(ctx, tokenId, "OwnerA", "OwnerB");
        });

        assertEquals("TOKEN_NOT_FOUND", new String(exception.getPayload()));
    }

    @Test
    public void testTransferCTT_UnauthorizedOwner() {
        // Setup - token exists but with different owner
        String tokenId = "CTT";
        CTTToken token = new CTTToken(tokenId, "Issuer", "RealOwner", 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.transferCTT(ctx, tokenId, "FakeOwner", "NewOwner");
        });

        assertEquals("UNAUTHORIZED_TRANSFER", new String(exception.getPayload()));
    }

    @Test
    public void testRedeemCTT_Success() {
        // Setup
        String tokenId = "CTT";
        String owner = "OwnerA";

        CTTToken token = new CTTToken(tokenId, "Issuer", owner, 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute
        String result = contract.redeemCTT(ctx, tokenId, owner);

        // Verify
        verify(stub).putStringState(eq(tokenId), anyString());
        CTTToken updatedToken = genson.deserialize(result, CTTToken.class);
        assertEquals(TokenState.REDEEMED, updatedToken.getState());
    }

    @Test
    public void testRedeemCTT_AlreadyRedeemed() {
        // Setup - token already redeemed
        String tokenId = "CTT";
        String owner = "OwnerA";

        CTTToken token = new CTTToken(tokenId, "Issuer", owner, 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        token.setState(TokenState.REDEEMED);
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.redeemCTT(ctx, tokenId, owner);
        });

        assertEquals("TOKEN_ALREADY_REDEEMED", new String(exception.getPayload()));
    }

    @Test
    public void testQueryCTT_Success() {
        // Setup
        String tokenId = "CTT";
        CTTToken token = new CTTToken(tokenId, "Issuer", "Owner", 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute
        String result = contract.queryCTT(ctx, tokenId);

        // Verify
        assertEquals(tokenJSON, result);
    }

    @Test
    public void testQueryTokensByOwner() {
        // Setup mock for query results
        setupMockIterator();
        when(stub.getQueryResult(anyString())).thenReturn(resultsIterator);

        // Execute
        String result = contract.queryTokensByOwner(ctx, "Owner");

        // Verify
        assertTrue(result.contains("CTT"));
    }

    @Test
    public void testQueryAllTokens() {
        // Setup mock for state range results
        setupMockIterator();
        when(stub.getStateByRange("", "")).thenReturn(resultsIterator);

        // Execute
        String result = contract.queryAllTokens(ctx);

        // Verify
        assertTrue(result.contains("CTT"));
    }

    private void setupMockIterator() {
        // Create a mock iterator and KeyValue
        @SuppressWarnings("unchecked")
        Iterator<KeyValue> mockIterator = mock(Iterator.class);
        KeyValue mockKeyValue = mock(KeyValue.class);

        when(mockIterator.hasNext()).thenReturn(true, false); // Return true on first call, false on next
        when(mockIterator.next()).thenReturn(mockKeyValue);
        when(mockKeyValue.getStringValue()).thenReturn(genson.serialize(
                new CTTToken("CTT", "Issuer", "Owner", 100.0,
                        "2023-01-01", "2023-12-31", "INV-001", "Test Token")));

        when(resultsIterator.iterator()).thenReturn(mockIterator);
    }

    @Test
    public void testBurnCTT_PartialBurn() {
        // Setup
        String tokenId = "CTT";
        String owner = "OwnerA";

        CTTToken token = new CTTToken(tokenId, "Issuer", owner, 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute - burn 30 units
        String result = contract.burnCTT(ctx, tokenId, owner, 30.0);

        // Verify
        verify(stub).putStringState(eq(tokenId), anyString());
        CTTToken updatedToken = genson.deserialize(result, CTTToken.class);
        assertEquals(70.0, updatedToken.getAmount());
        assertNotEquals(TokenState.BURNED, updatedToken.getState());
        assertEquals(owner, updatedToken.getOwner());
    }

    @Test
    public void testBurnCTT_CompleteBurn() {
        // Setup
        String tokenId = "CTT";
        String owner = "OwnerA";

        CTTToken token = new CTTToken(tokenId, "Issuer", owner, 100.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute - burn all 100 units
        String result = contract.burnCTT(ctx, tokenId, owner, 100.0);

        // Verify
        verify(stub).putStringState(eq(tokenId), anyString());
        CTTToken updatedToken = genson.deserialize(result, CTTToken.class);
        assertEquals(0.0, updatedToken.getAmount());
        assertEquals(TokenState.BURNED, updatedToken.getState());
        assertEquals("BLACKHOLE_ADDRESS", updatedToken.getOwner());
    }

    @Test
    public void testBurnCTT_InsufficientAmount() {
        // Setup
        String tokenId = "CTT";
        String owner = "OwnerA";

        CTTToken token = new CTTToken(tokenId, "Issuer", owner, 50.0,
                "2023-01-01", "2023-12-31", "INV-001", "Test Token");
        String tokenJSON = genson.serialize(token);

        when(stub.getStringState(tokenId)).thenReturn(tokenJSON);

        // Execute & Verify - try to burn 100 when only 50 available
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.burnCTT(ctx, tokenId, owner, 100.0);
        });

        assertEquals("BURN_AMOUNT_EXCEEDS_BALANCE", new String(exception.getPayload()));
    }

}