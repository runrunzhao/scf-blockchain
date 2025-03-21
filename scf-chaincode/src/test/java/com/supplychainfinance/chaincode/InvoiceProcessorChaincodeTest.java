package com.supplychainfinance.chaincode;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.Chaincode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.owlike.genson.Genson;
import com.supplychainfinance.chaincode.model.Invoice;
import com.supplychainfinance.chaincode.model.InvoiceState;

@ExtendWith(MockitoExtension.class)
public class InvoiceProcessorChaincodeTest {

    private final Genson genson = new Genson();
    
    private InvoiceProcessorChaincode contract;
    
    @Mock(lenient = true)
    private Context ctx;
    
    @Mock(lenient = true)
    private ChaincodeStub stub;
    
    @Mock(lenient = true)
    private Chaincode.Response chaincodeResponse;
    
    @BeforeEach
    public void setup() {
        contract = new InvoiceProcessorChaincode();
        when(ctx.getStub()).thenReturn(stub);
    }
    
    @Test
    public void testInitLedger() {
        // Just verify it doesn't throw exceptions
        assertDoesNotThrow(() -> contract.initLedger(ctx));
    }
    
    @Test
    public void testCreateInvoice_Success() {
        // Setup
        String invoiceId = "INV-001";
        String contractId = "CON-001";
        String fromEnterpriseId = "CompanyA";
        String toEnterpriseId = "CompanyB";
        Double amount = 1000.0;
        String issueDate = "2023-01-01";
        String dueDate = "2023-02-01";
        String description = "Test Invoice";
        
        // Mock that invoice doesn't exist yet
        when(stub.getStringState(invoiceId)).thenReturn("");
        
        // Execute
        String result = contract.createInvoice(ctx, invoiceId, contractId, fromEnterpriseId, 
                                            toEnterpriseId, amount, issueDate, dueDate, description);
        
        // Verify
        verify(stub).putStringState(eq(invoiceId), anyString());
        Invoice invoice = genson.deserialize(result, Invoice.class);
        assertEquals(invoiceId, invoice.getInvoiceId());
        assertEquals(contractId, invoice.getContractId());
        assertEquals(fromEnterpriseId, invoice.getFromEnterpriseId());
        assertEquals(toEnterpriseId, invoice.getToEnterpriseId());
        assertEquals(amount, invoice.getAmount());
        assertEquals(issueDate, invoice.getIssueDate());
        assertEquals(dueDate, invoice.getDueDate());
        assertEquals(description, invoice.getDescription());
        assertEquals(InvoiceState.CREATED, invoice.getState());
    }
    
    @Test
    public void testCreateInvoice_AlreadyExists() {
        // Setup - invoice already exists
        String invoiceId = "INV-001";
        when(stub.getStringState(invoiceId)).thenReturn("{\"id\":\"INV-001\"}");
        
        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.createInvoice(ctx, invoiceId, "CON-001", "CompanyA", "CompanyB", 
                               1000.0, "2023-01-01", "2023-02-01", "Test Invoice");
        });
        
        assertEquals("INVOICE_ALREADY_EXISTS", new String(exception.getPayload()));
    }
    
    @Test
    public void testPayCTTFromInvoice_Success() {
        // Setup
        String invoiceId = "INV-001";
        String tokenId = "CTT-001";
        String fromEnterpriseId = "CompanyA";
        String toEnterpriseId = "CompanyB";
        
        // Create invoice instance
        Invoice invoice = new Invoice(invoiceId, "CON-001", fromEnterpriseId, toEnterpriseId, 
                               1000.0, "2023-01-01", "2023-02-01", "Test Invoice");
        invoice.setState(InvoiceState.CREATED); // Ensure not PAID yet
        String invoiceJSON = genson.serialize(invoice);
        
        // Mock invoice exists
        when(stub.getStringState(invoiceId)).thenReturn(invoiceJSON);
        
        // Mock successful token transfer
        when(stub.invokeChaincode(eq("cttTokenChaincode"), anyList(), eq("mychannel")))
            .thenReturn(chaincodeResponse);
        when(chaincodeResponse.getStatus()).thenReturn(Chaincode.Response.Status.SUCCESS);
        
        // Execute
        String result = contract.payCTTFromInvoice(ctx, invoiceId, tokenId);
        
        // Verify
        verify(stub).putStringState(eq(invoiceId), anyString());
        Invoice updatedInvoice = genson.deserialize(result, Invoice.class);
        assertEquals(InvoiceState.PAID, updatedInvoice.getState());
        assertEquals(tokenId, updatedInvoice.getTokenId());
    }
    
    @Test
    public void testPayCTTFromInvoice_InvoiceNotFound() {
        // Setup - invoice doesn't exist
        String invoiceId = "INV-001";
        when(stub.getStringState(invoiceId)).thenReturn("");
        
        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.payCTTFromInvoice(ctx, invoiceId, "CTT-001");
        });
        
        assertEquals("INVOICE_NOT_FOUND", new String(exception.getPayload()));
    }
    
    @Test
    public void testPayCTTFromInvoice_AlreadyPaid() {
        // Setup - invoice already paid
        String invoiceId = "INV-001";
        Invoice invoice = new Invoice(invoiceId, "CON-001", "CompanyA", "CompanyB", 
                               1000.0, "2023-01-01", "2023-02-01", "Test Invoice");
        invoice.setState(InvoiceState.PAID);
        String invoiceJSON = genson.serialize(invoice);
        
        when(stub.getStringState(invoiceId)).thenReturn(invoiceJSON);
        
        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.payCTTFromInvoice(ctx, invoiceId, "CTT-001");
        });
        
        assertEquals("INVOICE_ALREADY_PAID", new String(exception.getPayload()));
    }
    
    @Test
    public void testPayCTTFromInvoice_TokenTransferFailed() {
        // Setup
        String invoiceId = "INV-001";
        String tokenId = "CTT-001";
        
        // Create invoice instance
        Invoice invoice = new Invoice(invoiceId, "CON-001", "CompanyA", "CompanyB", 
                               1000.0, "2023-01-01", "2023-02-01", "Test Invoice");
        invoice.setState(InvoiceState.CREATED);
        String invoiceJSON = genson.serialize(invoice);
        
        // Mock invoice exists
        when(stub.getStringState(invoiceId)).thenReturn(invoiceJSON);
        
        // Mock failed token transfer
        when(stub.invokeChaincode(eq("cttTokenChaincode"), anyList(), eq("mychannel")))
            .thenReturn(chaincodeResponse);
        when(chaincodeResponse.getStatus()).thenReturn(Chaincode.Response.Status.INTERNAL_SERVER_ERROR);
        when(chaincodeResponse.getMessage()).thenReturn("Token transfer error");
        
        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.payCTTFromInvoice(ctx, invoiceId, tokenId);
        });
        
        assertEquals("PAYMENT_PROCESSING_FAILED", new String(exception.getPayload()));
    }
    
    @Test
    public void testQueryInvoice_Success() {
        // Setup
        String invoiceId = "INV-001";
        Invoice invoice = new Invoice(invoiceId, "CON-001", "CompanyA", "CompanyB", 
                               1000.0, "2023-01-01", "2023-02-01", "Test Invoice");
        String invoiceJSON = genson.serialize(invoice);
        
        when(stub.getStringState(invoiceId)).thenReturn(invoiceJSON);
        
        // Execute
        String result = contract.queryInvoice(ctx, invoiceId);
        
        // Verify
        assertEquals(invoiceJSON, result);
    }
    
    @Test
    public void testQueryInvoice_NotFound() {
        // Setup - invoice doesn't exist
        String invoiceId = "INV-001";
        when(stub.getStringState(invoiceId)).thenReturn("");
        
        // Execute & Verify
        ChaincodeException exception = assertThrows(ChaincodeException.class, () -> {
            contract.queryInvoice(ctx, invoiceId);
        });
        
        assertEquals("INVOICE_NOT_FOUND", new String(exception.getPayload()));
    }
}