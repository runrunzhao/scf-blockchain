package com.supplychainfinance.model;

public enum PaymentMethod {
    CTT("CTT"),
    BANK_TRANSFER("Bank Transfer"),
    CHECK("Check"),
    CREDIT_CARD("Credit Card"),
    UNKNOWN("");
    
    private final String displayName;
    
    PaymentMethod(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public static PaymentMethod fromString(String value) {
        if (value == null || value.isEmpty()) {
            return UNKNOWN;
        }
        
        for (PaymentMethod method : PaymentMethod.values()) {
            if (method.displayName.equalsIgnoreCase(value)) {
                return method;
            }
        }
        
        return UNKNOWN;
    }
    
    @Override
    public String toString() {
        return displayName;
    }
}