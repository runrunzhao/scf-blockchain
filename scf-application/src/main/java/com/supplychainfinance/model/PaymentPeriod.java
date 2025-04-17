package com.supplychainfinance.model;

import java.util.Date;

public class PaymentPeriod {
    private int period;
    private Date date;
    private double amount;
    private String terms;
    private PaymentMethod paymentMethod; 
    
    // Constructors
    public PaymentPeriod() {
    }
    
    public PaymentPeriod(int period, Date date, double amount, String terms) {
        this.period = period;
        this.date = date;
        this.amount = amount;
        this.terms = terms;
        this.paymentMethod = PaymentMethod.UNKNOWN;
    }
    
    // Getters and setters
    public int getPeriod() {
        return period;
    }
    
    public void setPeriod(int period) {
        this.period = period;
    }
    
    public Date getDate() {
        return date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public String getTerms() {
        return terms;
    }
    
    public void setTerms(String terms) {
        this.terms = terms;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    
    public void setPaymentMethod(String paymentMethodStr) {
        this.paymentMethod = PaymentMethod.fromString(paymentMethodStr);
    }
    
    
    @Override
    public String toString() {
        return "PaymentPeriod{" +
                "period=" + period +
                ", date=" + date +
                ", amount=" + amount +
                ", terms='" + terms + '\'' +
                '}';
    }
}