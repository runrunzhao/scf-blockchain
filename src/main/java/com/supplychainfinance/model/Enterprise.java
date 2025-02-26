package com.supplychainfinance.model;

public class Enterprise {
    private String enterpriseID;
    private String enterpriseName;
    private String address;
    private String telephone;
    private String role;  // Core, Bank, Supplier, or Distributor
    private String email;  // Not in DB schema, but useful for UI
    private String memo;
    
    // Constructors
    public Enterprise() {
    }
    
    public Enterprise(String enterpriseID, String enterpriseName, String address, String telephone, String role, String memo) {
        this.enterpriseID = enterpriseID;
        this.enterpriseName = enterpriseName;
        this.address = address;
        this.telephone = telephone;
        this.role = role;
        this.memo = memo;
    }
    
    // Getters and setters
    public String getEnterpriseID() {
        return enterpriseID;
    }
    
    public void setEnterpriseID(String enterpriseID) {
        this.enterpriseID = enterpriseID;
    }
    
    public String getEnterpriseName() {
        return enterpriseName;
    }
    
    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getTelephone() {
        return telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getMemo() {
        return memo;
    }
    
    public void setMemo(String memo) {
        this.memo = memo;
    }
}