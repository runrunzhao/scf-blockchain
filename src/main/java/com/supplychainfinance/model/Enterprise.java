package com.supplychainfinance.model;

public class Enterprise {
    // 企业基本信息
    private String enterpriseID;
    private String enterpriseName;
    private String role;
    private String telephone;
    private String address;
    private int tier;
    private String memo;
    
    // 额外属性
    private String email;
    private String contactPerson;
    private String registrationNumber;
    private String establishDate;
    private String businessScope;
    
    // 基本 getter 和 setter 方法
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
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getTelephone() {
        return telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public int getTier() {
        return tier;
    }
    
    public void setTier(int tier) {
        this.tier = tier;
    }
    
    public String getMemo() {
        return memo;
    }
    
    public void setMemo(String memo) {
        this.memo = memo;
    }
    
    // 额外属性的 getter 和 setter
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getContactPerson() {
        return contactPerson;
    }
    
    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }
    
    public String getRegistrationNumber() {
        return registrationNumber;
    }
    
    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }
    
    public String getEstablishDate() {
        return establishDate;
    }
    
    public void setEstablishDate(String establishDate) {
        this.establishDate = establishDate;
    }
    
    public String getBusinessScope() {
        return businessScope;
    }
    
    public void setBusinessScope(String businessScope) {
        this.businessScope = businessScope;
    }


    
    @Override
    public String toString() {
        return "Enterprise{" +
                "enterpriseID='" + enterpriseID + '\'' +
                ", enterpriseName='" + enterpriseName + '\'' +
                ", role='" + role + '\'' +
                ", tier=" + tier +
                '}';
    }
}