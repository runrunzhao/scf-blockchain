package com.supplychainfinance.servlet;

import com.supplychainfinance.dao.ContractDAO;
import com.supplychainfinance.dao.InvoiceDAO;
import com.supplychainfinance.model.Contract;
import com.supplychainfinance.model.Invoice;
import com.supplychainfinance.model.PaymentPeriod;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class SaveContractServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Read JSON data from request
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        Map<String, Object> result = new HashMap<>();

        try {
            // Parse request JSON into Contract object
            Type contractType = new TypeToken<Map<String, Object>>() {
            }.getType();
            Map<String, Object> contractData = gson.fromJson(sb.toString(), contractType);

            // Create Contract object
            Contract contract = new Contract();

            // Check if this is an update or new contract
            boolean isUpdate = contractData.get("contractId") != null
                    && !contractData.get("contractId").toString().isEmpty();

            if (isUpdate) {
                contract.setContractId(contractData.get("contractId").toString());
            } else {
                // Generate new contract ID
                ContractDAO contractDAO = new ContractDAO();
                String newContractID = contractDAO.generateContractId();
                contract.setContractId(newContractID);
            }

            contract.setContractName(contractData.get("contractName").toString());
            contract.setContractType(contractData.get("contractType").toString());
            contract.setStatus(contractData.get("status").toString());
            contract.setFromEnterpriseId(contractData.get("fromEnterpriseId").toString());
            contract.setToEnterpriseId(contractData.get("toEnterpriseId").toString());
            contract.setAmount(Double.parseDouble(contractData.get("amount").toString()));

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            if (contractData.get("signDate") != null && !contractData.get("signDate").toString().isEmpty()) {
                contract.setSignDate(dateFormat.parse(contractData.get("signDate").toString()));
            }

            if (contractData.get("effectiveDate") != null && !contractData.get("effectiveDate").toString().isEmpty()) {
                contract.setEffectiveDate(dateFormat.parse(contractData.get("effectiveDate").toString()));
            }

            if (contractData.get("expiryDate") != null && !contractData.get("expiryDate").toString().isEmpty()) {
                contract.setExpiryDate(dateFormat.parse(contractData.get("expiryDate").toString()));
            }

            contract.setDescription(
                    contractData.get("description") != null ? contractData.get("description").toString() : "");
            contract.setRemarks(contractData.get("remarks") != null ? contractData.get("remarks").toString() : "");

            // Parse payment periods
            List<PaymentPeriod> paymentPeriods = new ArrayList<>();
            if (contractData.get("paymentPeriods") != null) {
                Type periodListType = new TypeToken<ArrayList<Map<String, Object>>>() {
                }.getType();
                List<Map<String, Object>> periodData = gson.fromJson(
                        gson.toJson(contractData.get("paymentPeriods")), periodListType);

                for (Map<String, Object> period : periodData) {
                    PaymentPeriod paymentPeriod = new PaymentPeriod();
                    paymentPeriod.setPeriod((int) Math.round(Double.parseDouble(period.get("period").toString())));

                    if (period.get("paydate") != null && !period.get("paydate").toString().isEmpty()) {
                        paymentPeriod.setDate(dateFormat.parse(period.get("paydate").toString()));
                    }

                    if (period.get("amount") != null && !period.get("amount").toString().isEmpty()) {
                        paymentPeriod.setAmount(Double.parseDouble(period.get("amount").toString()));
                    }

                    if (period.get("paymentMethod") != null) {
                        paymentPeriod.setPaymentMethod(period.get("paymentMethod").toString());
                        System.out.println("paymentMethodis: " + period.get("paymentMethod").toString() + " 用于期间 " + paymentPeriod.getPeriod());
                    }
                   // paymentPeriod.setTerms(period.get("terms") != null ? period.get("terms").toString() : "");
                    paymentPeriods.add(paymentPeriod);
                }
            }
            contract.setPaymentPeriods(paymentPeriods);

            // Save contract data
            ContractDAO contractDAO = new ContractDAO();
            boolean success = false;

            try {
                if (isUpdate) {
                    contractDAO.updateContract(contract);
                    success = true;
                } else {
                    contractDAO.insertContract(contract);
                    success = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                success = false;
            }

            if (success) {
                // Generate or update invoices from payment periods
                boolean invoicesGenerated = synchronizeInvoices(contract.getContractId(), paymentPeriods);

                result.put("success", true);
                result.put("contractId", contract.getContractId());
                result.put("message", isUpdate ? "Contract updated successfully" : "Contract created successfully");
                if (invoicesGenerated) {
                    result.put("invoicesGenerated", true);
                }
            } else {
                result.put("success", false);
                result.put("error", "Failed to save contract data");
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Error processing contract data: " + e.getMessage());
        }

        out.println(gson.toJson(result));
    }

    /**
     * Synchronize invoice records with payment periods
     * 
     * @param contractId     The contract ID
     * @param paymentPeriods List of payment periods
     * @return boolean - success/failure
     */
    private boolean synchronizeInvoices(String contractId, List<PaymentPeriod> paymentPeriods) {
        System.out.println("===== Synchronizing invoices =====");
        System.out.println("Contract ID: " + contractId);
        System.out.println("Number of payment periods: " + (paymentPeriods != null ? paymentPeriods.size() : 0));

        if (paymentPeriods == null || paymentPeriods.isEmpty()) {
            System.out.println("No payment periods provided, skipping invoice processing");
            return true; // No periods is not a failure
        }

        try {
            InvoiceDAO invoiceDAO = new InvoiceDAO();

            // 1. Get existing invoices
            List<Invoice> existingInvoices = invoiceDAO.getInvoicesByContractID(contractId);
            System.out.println(
                    "Existing invoices: " + (existingInvoices != null ? existingInvoices.size() : 0) + " found");

            // 2. Create a map of period number to invoice
            Map<Integer, Invoice> existingInvoiceMap = new HashMap<>();

            // Use position-based mapping when counts match but periods might not
            if (existingInvoices != null && !existingInvoices.isEmpty() &&
                    existingInvoices.size() == paymentPeriods.size()) {

                System.out.println("Using position-based invoice mapping");
                // Sort payment periods by period number
                List<PaymentPeriod> sortedPeriods = new ArrayList<>(paymentPeriods);
                sortedPeriods.sort((p1, p2) -> Integer.compare(p1.getPeriod(), p2.getPeriod()));

                // Simple positional mapping - match invoices to periods by position
                for (int i = 0; i < existingInvoices.size() && i < sortedPeriods.size(); i++) {
                    Invoice inv = existingInvoices.get(i);
                    int periodNum = sortedPeriods.get(i).getPeriod();
                    System.out.println("Position mapping: invoice " + inv.getInvoiceID() + " -> period " + periodNum);
                    existingInvoiceMap.put(periodNum, inv);
                }
            } else {
                // Standard mapping by period number
                if (existingInvoices != null) {
                    for (Invoice inv : existingInvoices) {
                        System.out.println("DEBUG RAW INVOICE: ID=" + inv.getInvoiceID()
                                + ", Period=" + inv.getPayPeriod()
                                + ", ContractID=" + inv.getContractID()
                                + ", Amount=" + inv.getAmount());

                        existingInvoiceMap.put(inv.getPayPeriod(), inv);
                    }
                }
            }

            // 3. Track which periods were processed
            List<Integer> processedPeriods = new ArrayList<>();
            boolean allSuccess = true;

            // 4. For each payment period, update or create invoice
            for (PaymentPeriod period : paymentPeriods) {
                int periodNum = period.getPeriod();
                processedPeriods.add(periodNum);

                System.out.println("Processing period " + periodNum +
                        ", Date: " + period.getDate() +
                        ", Amount: " + period.getAmount() +
                        ", Terms: " + period.getTerms());

                if (period.getDate() == null || period.getAmount() <= 0) {
                    System.out.println("Skipping invalid period " + periodNum);
                    continue;
                }

                // Create invoice object from payment period
                Invoice newInvoice = new Invoice();
                newInvoice.setContractID(contractId);
                newInvoice.setAmount(period.getAmount());
                newInvoice.setPayDate(period.getDate());
                newInvoice.setStatus("Pending"); // Default status
                newInvoice.setMemo(period.getTerms());
                newInvoice.setPayPeriod(periodNum);
                newInvoice.setPaymentMethod(period.getPaymentMethod() );
                        

                // Check if invoice for this period already exists
                Invoice existingInvoice = existingInvoiceMap.get(periodNum);
                boolean success = false;

                if (existingInvoice != null) {
                    // Always update with current values from the form
                    System.out.println("Updating existing invoice ID=" + existingInvoice.getInvoiceID() +
                            " for period " + periodNum);

                    // Print values for verification
                    System.out.println("  - Form date: " + period.getDate());
                    System.out.println("  - Form amount: " + period.getAmount());
                    System.out.println("  - Form terms: " + period.getTerms());
                    System.out.println("  - Form paymentMethod: " + period.getPaymentMethod());
                    // Keep the same invoice ID, update all other fields
                    newInvoice.setInvoiceID(existingInvoice.getInvoiceID());

                    // Always update regardless of whether values changed
                    success = invoiceDAO.updateInvoice(newInvoice);
                    System.out.println("Updated invoice for period " + periodNum + ": " +
                            (success ? "SUCCESS" : "FAILED"));
                } else {
                    // Create new invoice
                    newInvoice.setInvoiceID(invoiceDAO.generateInvoiceID());
                    System.out.println(
                            "Creating new invoice ID: " + newInvoice.getInvoiceID() + " for period " + periodNum);
                    success = invoiceDAO.createInvoice(newInvoice);
                    System.out.println("Created invoice for period " + periodNum + ": " +
                            (success ? "SUCCESS" : "FAILED"));
                }

                if (!success) {
                    System.err.println("Failed to process invoice for period " + periodNum);
                    allSuccess = false;
                    break;
                }
            }

            // 5. Delete invoices for periods that are no longer in the contract
            if (allSuccess && existingInvoices != null) {
                for (Invoice oldInvoice : existingInvoices) {
                    if (oldInvoice != null &&
                            !processedPeriods.contains(oldInvoice.getPayPeriod())) {

                        System.out.println("Deleting obsolete invoice ID=" + oldInvoice.getInvoiceID() +
                                " for period " + oldInvoice.getPayPeriod());
                        boolean deleteSuccess = invoiceDAO.deleteInvoice(oldInvoice.getInvoiceID());

                        if (!deleteSuccess) {
                            System.err.println("Failed to delete invoice ID=" + oldInvoice.getInvoiceID());
                            allSuccess = false;
                            break;
                        }
                    }
                }
            }

            System.out.println("Invoice synchronization completed with " + (allSuccess ? "SUCCESS" : "ERRORS"));
            return allSuccess;

        } catch (Exception e) {
            System.err.println("Error synchronizing invoices: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}