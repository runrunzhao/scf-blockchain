.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Details - Supply Chain Finance</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
        }

        .container {
            margin-top: 30px;
        }

        .menu {
            margin-bottom: 30px;
        }

        .menu a {
            color: #fff;
            font-size: 18px;
            margin: 0 15px;
        }

        .menu a:hover {
            text-decoration: underline;
        }

        .header {
            background-color: #007bff;
            padding: 15px;
            color: white;
            text-align: center;
            font-size: 24px;
            border-radius: 10px;
        }

        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #aaa;
        }

        .detail-panel {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .edit-mode {
            display: none;
        }

        /* Updated dropdown menu styling */
        .dropdown-menu {
            background-color: #f8f9fa;
            border-radius: 5px;
            margin-top: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            z-index: 1021;
        }

        .dropdown-item {
            color: #333333 !important;
            font-weight: 500;
            padding: 0.5rem 1.5rem;
        }

        .dropdown-item:hover {
            background-color: #007bff;
            color: white !important;
        }

        .dropdown-toggle {
            cursor: pointer;
        }

        .dropdown-toggle::after {
            display: inline-block;
            margin-left: 0.255em;
            vertical-align: 0.255em;
            content: "";
            border-top: 0.3em solid;
            border-right: 0.3em solid transparent;
            border-bottom: 0;
            border-left: 0.3em solid transparent;
        }

        .dropdown.d-inline-block {
            vertical-align: middle;
        }

        .button-group {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            text-align: center;
        }

        .button-group button {
            margin: 0 10px;
            min-width: 100px;
            font-weight: 500;
        }
    </style>
</head>

<body>
    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            <a href="#user-management">User</a>
            <div class="dropdown d-inline-block">
                <a href="#" class="dropdown-toggle" id="enterpriseDropdown" data-toggle="dropdown" 
                    aria-haspopup="true" aria-expanded="false">
                    Enterprise
                </a>
                <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                    <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                    <a class="dropdown-item" href="singleEnterprise.jsp?mode=add">Add New Enterprise</a>
                </div>
            </div>
            <a href="contract.jsp">Contract</a>
            <a href="invoice.jsp">Invoice</a>
        </div>
    </div>

    <div class="container">
        <!-- Invoice Detail Section -->
        <div class="row">
            <div class="col-12">
                <div class="detail-panel">
                    <!-- Page Title -->
                    <div class="mb-4">
                        <h3 id="panelTitle">Invoice Details</h3>
                    </div>

                    <!-- Basic Information -->
                    <div class="form-section">
                        <h4>Basic Information</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><strong>Invoice ID:</strong></label>
                                    <p id="invoiceId">-</p>
                                </div>
                                <div class="form-group">
                                    <label><strong>Contract ID:</strong></label>
                                    <p id="contractId">-</p>
                                    <p><small><a href="#" id="viewContractLink">View associated contract</a></small></p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><strong>Contract Amount:</strong></label>
                                    <p id="amount">-</p>
                                </div>
                                <div class="form-group">
                                    <label><strong>Status:</strong></label>
                                    <p id="status">-</p>
                                </div>
                            </div>
                        </div>
                    </div>

                                      <!-- Payment Details -->
                                      <div class="form-section">
                                        <h4>Payment Details</h4>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label><strong>Invoice Date:</strong></label>
                                                    <p id="invoiceDate">-</p>
                                                </div>
                                            </div>
                                                                                     <div class="col-md-4">
                                                <div class="form-group">
                                                    <label><strong>Invoice Amount:</strong></label>
                                                    <p id="invoiceAmount">-</p>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label><strong>Memo:</strong></label>
                                                    <p id="dueDate">-</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                    <!-- Action Buttons -->
                    <div class="button-group">
                        <button class="btn btn-primary" onclick="goToInvoiceList()">Back to List</button>
                        <button class="btn btn-secondary" onclick="printInvoice()">Print Invoice</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
    </div>

    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script>
        // Initialize page when document is ready
        $(document).ready(function () {
            console.log("Page loading - initialization");
            
            // Get invoice ID from URL parameter
            const urlParams = new URLSearchParams(window.location.search);
            const invoiceId = urlParams.get('id');

            if (invoiceId) {
                loadInvoiceDetails(invoiceId);
            } else {
                showAlert('No invoice ID provided. Redirecting to invoice search.', 'warning');
                setTimeout(() => {
                    window.location.href = 'invoice.jsp';
                }, 2000);
            }
            
            // Initialize dropdown menu
            $('.dropdown-toggle').dropdown();

            // Add event listener to make dropdown work on hover too
            $('.dropdown').hover(
                function () {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100);
                },
                function () {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100);
                }
            );
        });

        // Function to load invoice details
        function loadInvoiceDetails(invoiceId) {
            // Make AJAX call to get invoice details
            $.ajax({
                url: "getSingleInvoice",
                type: "GET",
                data: {
                    invoiceId: invoiceId
                },
                dataType: "json",
                success: function(invoice) {
                    if (invoice) {
                        // Populate basic information
                        $('#invoiceId').text(invoice.invoiceID);
                        $('#contractId').text(invoice.contractID);
                        $('#amount').text('$' + invoice.amount.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}));
                        $('#status').text(invoice.status);
                        
                        // Set up view contract link
                        $('#viewContractLink').attr('href', 'contractDetail.jsp?contractId=' + invoice.contractID);
                        
                        // Populate payment details
                        $('#invoiceDate').text(formatDate(invoice.payDate));
                        $('#memo').text(formatDate(invoice.memo));
                        $('#invoiceAmount').text('$' + invoice.amount.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}));
                        
                        // Update page title with invoice ID
                        document.title = `Invoice Details: ${invoice.invoiceID} - Supply Chain Finance`;
                    } else {
                        showAlert('Invoice not found', 'danger');
                        setTimeout(() => {
                            window.location.href = 'invoice.jsp';
                        }, 2000);
                    }
                },
                error: function(xhr, status, error) {
                    showAlert('Error loading invoice details: ' + error, 'danger');
                    console.error('Error response:', xhr.responseText);
                }
            });
        }
        
        // Function to format date for display
        function formatDate(dateStr) {
            if (!dateStr) return '-';
            
            // Try to parse the date
            const date = new Date(dateStr);
            if (isNaN(date.getTime())) return dateStr;
            
            // Format the date
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        }
        
        // Function to show alerts
        function showAlert(message, type) {
            // Create alert element
            const alertHtml = '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                message +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                '<span aria-hidden="true">&times;</span>' +
                '</button>' +
                '</div>';
            
            // Add new alert to page
            $('#panelTitle').after(alertHtml);
            
            // Auto-hide after 5 seconds for non-error alerts
            if (type !== 'danger') {
                setTimeout(function() {
                    $('.alert').alert('close');
                }, 5000);
            }
        }
        
        // Function to navigate back to invoice list
        function goToInvoiceList() {
            window.location.href = 'invoice.jsp';
        }
        
        // Function to print invoice
        function printInvoice() {
            window.print();
        }
    </script>
</body>

</html>