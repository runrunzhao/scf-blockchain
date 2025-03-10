package com.supplychainfinance.model;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Contract {
    private String contractId;     // contractID
    private String contractName;   // realNo - 真实合同编号
    private String contractType;   // 合同类型 (非数据库字段)
    private String fromEnterpriseId; // part1
    private String fromEnterpriseName; // 企业名称 (非数据库字段)
    private String toEnterpriseId;   // part2
    private String toEnterpriseName; // 企业名称 (非数据库字段)
    private double amount;      // amount
    private Date signDate;         // signingDate
    private Date effectiveDate;    // effectiveDate
    private Date expiryDate;       // invalidDate
    private String status;         // status
    private String paymentTerms;   // 支付条款 (非数据库字段)
    private String description;    // 描述 (非数据库字段)
    private String remarks;        // 备注 (非数据库字段)
    
    // 默认构造函数
    public Contract() {
        // 设置默认值
        this.amount = 0;
        this.signDate = new Date();
        this.effectiveDate = new Date();
        
        // 默认到期日为一年后
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, 1);
        this.expiryDate = calendar.getTime();
        
        this.status = "Active";
    }
    
    // Getters and Setters
    public String getContractId() {
        return contractId;
    }
    
    public void setContractId(String contractId) {
        this.contractId = contractId;
    }
    
    public String getContractName() {
        return contractName;
    }
    
    public void setContractName(String contractName) {
        this.contractName = contractName;
    }
    
    public String getContractType() {
        return contractType;
    }
    
    public void setContractType(String contractType) {
        this.contractType = contractType;
    }
    
    public String getFromEnterpriseId() {
        return fromEnterpriseId;
    }
    
    public void setFromEnterpriseId(String fromEnterpriseId) {
        this.fromEnterpriseId = fromEnterpriseId;
    }
    
    public String getFromEnterpriseName() {
        return fromEnterpriseName;
    }
    
    public void setFromEnterpriseName(String fromEnterpriseName) {
        this.fromEnterpriseName = fromEnterpriseName;
    }
    
    public String getToEnterpriseId() {
        return toEnterpriseId;
    }
    
    public void setToEnterpriseId(String toEnterpriseId) {
        this.toEnterpriseId = toEnterpriseId;
    }
    
    public String getToEnterpriseName() {
        return toEnterpriseName;
    }
    
    public void setToEnterpriseName(String toEnterpriseName) {
        this.toEnterpriseName = toEnterpriseName;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    // 兼容性方法 - 支持从字符串设置金额
    public void setAmount(String amount) {
        try {
            this.amount = Double.parseDouble(amount);
        } catch (Exception e) {
            this.amount = 0;
        }
    }
    
    // 兼容性方法 - 支持从 BigDecimal 设置金额
    public void setAmount(BigDecimal amount) {
        if (amount != null) {
            this.amount = amount.doubleValue();
        } else {
            this.amount = 0;
        }
    }
    
    public Date getSignDate() {
        return signDate;
    }
    
    public void setSignDate(Date signDate) {
        this.signDate = signDate;
    }
    
    // 兼容性方法 - 支持从字符串设置日期
    public void setSignDate(String signDateStr) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.signDate = dateFormat.parse(signDateStr);
        } catch (Exception e) {
            this.signDate = new Date(); // 默认为当前日期
        }
    }
    
    public Date getEffectiveDate() {
        return effectiveDate;
    }
    
    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }
    
    // 兼容性方法 - 支持从字符串设置日期
    public void setEffectiveDate(String effectiveDateStr) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.effectiveDate = dateFormat.parse(effectiveDateStr);
        } catch (Exception e) {
            this.effectiveDate = new Date(); // 默认为当前日期
        }
    }
    
    public Date getExpiryDate() {
        return expiryDate;
    }
    
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    // 兼容性方法 - 支持从字符串设置日期
    public void setExpiryDate(String expiryDateStr) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.expiryDate = dateFormat.parse(expiryDateStr);
        } catch (Exception e) {
            // 默认为一年后
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.YEAR, 1);
            this.expiryDate = calendar.getTime();
        }
    }


    // 在 Contract 类中添加以下方法来确保日期格式的一致性
public String getFormattedSignDate() {
    if (this.signDate == null) {
        return "";
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    return dateFormat.format(this.signDate);
}

public String getFormattedEffectiveDate() {
    if (this.effectiveDate == null) {
        return "";
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    return dateFormat.format(this.effectiveDate);
}

public String getFormattedExpiryDate() {
    if (this.expiryDate == null) {
        return "";
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    return dateFormat.format(this.expiryDate);
}
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getPaymentTerms() {
        return paymentTerms;
    }
    
    public void setPaymentTerms(String paymentTerms) {
        this.paymentTerms = paymentTerms;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getRemarks() {
        return remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    // 兼容 EnterpriseRelationController 使用的旧方法名称
    public void setContractID(String contractId) {
        this.contractId = contractId;
    }
    
    public void setContractNumber(String contractName) {
        this.contractName = contractName;
    }
    
    public void setContractAmount(BigDecimal amount) {
        if (amount != null) {
            this.amount = amount.doubleValue();
        }
    }
    
    public void setContractDate(java.sql.Date date) {
        if (date != null) {
            this.signDate = new Date(date.getTime());
        }
    }
    
    public void setStartDate(java.sql.Date date) {
        if (date != null) {
            this.effectiveDate = new Date(date.getTime());
        }
    }
    
    public void setEndDate(java.sql.Date date) {
        if (date != null) {
            this.expiryDate = new Date(date.getTime());
        }
    }
    
    public void setPartyAID(String fromEnterpriseId) {
        this.fromEnterpriseId = fromEnterpriseId;
    }
    
    public void setPartyBID(String toEnterpriseId) {
        this.toEnterpriseId = toEnterpriseId;
    }
    
    @Override
    public String toString() {
        return "Contract{" +
                "contractId='" + contractId + '\'' +
                ", contractName='" + contractName + '\'' +
                ", fromEnterpriseId='" + fromEnterpriseId + '\'' +
                ", toEnterpriseId='" + toEnterpriseId + '\'' +
                ", amount=" + amount +
                ", status='" + status + '\'' +
                '}';
    }
}