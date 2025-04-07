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

            .view-mode,
            .add-mode {
                display: none;
                /* Hide both by default and show based on mode */
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

            .form-section {
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
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

                        <!-- View Mode Section -->
                        <div class="view-mode">
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
                                            <p><small><a href="#" id="viewContractLink">View associated
                                                        contract</a></small></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Contract Real No:</strong></label>
                                            <p id="contractRealNo">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Contract Status:</strong></label>
                                            <p id="contractStatus">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Contract Amount:</strong></label>
                                            <p id="contractAmount">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Payment Details -->
                            <div class="form-section">
                                <h4>Payment Details</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Invoice Date:</strong></label>
                                            <p id="invoiceDate">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Payment Method:</strong></label>
                                            <p id="paymentMethod">-</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Invoice Amount:</strong></label>
                                            <p id="invoiceAmount">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Status:</strong></label>
                                            <p id="invoiceStatus">-</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label><strong>Memo:</strong></label>
                                            <p id="memo">-</p>
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

                        <!-- Add Mode Section -->
                        <div class="add-mode">
                            <form id="addInvoiceForm">
                                <!-- Basic Information -->
                                <div class="form-section">
                                    <h4>Basic Information</h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="add_contractId">Contract ID</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="add_contractId"
                                                        name="contractId" required readonly>
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-secondary" type="button"
                                                            onclick="openContractSelector()">
                                                            Select Contract
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="add_realNo">Contract Real No</label>
                                                <input type="text" class="form-control" id="add_realNo" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Contract Status:</label>
                                                <p id="add_contractStatus" class="form-control-plaintext">-</p>
                                            </div>
                                            <div class="form-group">
                                                <label>Contract Amount:</label>
                                                <p id="add_contractAmount" class="form-control-plaintext">-</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Payment Details -->
                                <div class="form-section">
                                    <h4>Payment Details</h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="add_invoiceDate">Invoice Date</label>
                                                <input type="date" class="form-control" id="add_invoiceDate"
                                                    name="invoiceDate" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="add_amount">Invoice Amount</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">$</span>
                                                    </div>
                                                    <input type="number" class="form-control" id="add_amount"
                                                        name="amount" step="0.01" min="0" required>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="add_paymentMethod">Payment Method</label>
                                                <select class="form-control" id="add_paymentMethod"
                                                    name="paymentMethod">
                                                    <option value="">Select method</option>
                                                    <option value="Bank Transfer">Bank Transfer</option>
                                                    <option value="Credit Card">Credit Card</option>
                                                    <option value="Check">Check</option>
                                                    <option value="CTT">CTT</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="add_status">Status</label>
                                                <select class="form-control" id="add_status" name="status" required>
                                                    <option value="">Select status</option>
                                                    <option value="Draft">Draft</option>
                                                    <option value="Pending">Pending</option>
                                                    <option value="End">End</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="add_memo">Memo</label>
                                                <textarea class="form-control" id="add_memo" name="memo"
                                                    rows="3"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="button-group">
                                    <button type="button" class="btn btn-secondary"
                                        onclick="goToInvoiceList()">Cancel</button>
                                    <button type="button" class="btn btn-primary" onclick="saveInvoice()">Save
                                        Invoice</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contract Selector Modal -->
        <div class="modal fade" id="contractSelectorModal" tabindex="-1" aria-labelledby="contractSelectorModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="contractSelectorModalLabel">Select Contract</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="input-group mb-3">
                            <input type="text" id="contractSearchInput" class="form-control"
                                placeholder="Search contracts...">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="button" onclick="searchContracts()">
                                    Search
                                </button>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Contract ID</th>
                                        <th>Real No</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="contractTableBody">
                                    <!-- Contracts will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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

                // Get URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                const invoiceId = urlParams.get('id');
                const mode = urlParams.get('mode');

                // Determine which mode to display
                if (mode === 'add') {
                    // Set page to add mode
                    $('#panelTitle').text('Add New Invoice');
                    $('.add-mode').show();
                    $('.view-mode').hide();

                    // Set default values for date fields
                    const today = new Date();
                    $('#add_invoiceDate').val(formatDateForInput(today));
                } else if (invoiceId) {
                    // Set page to view mode and load invoice details
                    $('#panelTitle').text('Invoice Details');
                    $('.view-mode').show();
                    $('.add-mode').hide();
                    loadInvoiceDetails(invoiceId);
                } else {
                    // No valid parameters, redirect to invoice list
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

                $("#contractSearchInput").on("keypress", function (event) {
                    if (event.key === "Enter") {
                        event.preventDefault();
                        searchContracts();
                    }
                });
            });

            // Function to load invoice details for view mode
            function loadInvoiceDetails(invoiceId) {
                // Make AJAX call to get invoice details
                $.ajax({
                    url: "getSingleInvoice",
                    type: "GET",
                    data: {
                        invoiceId: invoiceId
                    },
                    dataType: "json",
                    success: function (invoice) {
                        if (invoice) {
                            // Populate basic information
                            $('#invoiceId').text(invoice.invoiceID);
                            $('#contractId').text(invoice.contractID);

                            // Set up view contract link
                            $('#viewContractLink').attr('href', 'contractDetail.jsp?contractId=' + invoice.contractID);

                            // Populate payment details
                            $('#invoiceDate').text(formatDate(invoice.payDate));
                            $('#memo').text(invoice.memo || '-');
                            $('#invoiceAmount').text('$' + invoice.amount.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
                            // Add these lines to display status and payment method
                            $('#invoiceStatus').text(invoice.status || '-');

                            // Add this line for payment method
                            $('#paymentMethod').text(invoice.paymentMethod || '-');
                            console.log("Payment method in response:", invoice.paymentMethod);

                            // Load contract details
                            $.ajax({
                                url: "getContractDetails",
                                type: "GET",
                                data: {
                                    contractId: invoice.contractID
                                },
                                dataType: "json",
                                success: function (contract) {
                                    $('#contractRealNo').text(contract.realNo || '-');
                                    $('#contractAmount').text('$' + contract.amount.toLocaleString('en-US',
                                        { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
                                    $('#contractStatus').text(contract.status || '-');
                                },
                                error: function () {
                                    $('#contractRealNo').text('Not found');
                                    $('#contractAmount').text('Not found');
                                    $('#contractStatus').text('Not found');
                                }
                            });

                            // Update page title with invoice ID
                            document.title = `Invoice Details: ${invoice.invoiceID} - Supply Chain Finance`;
                        } else {
                            showAlert('Invoice not found', 'danger');
                            setTimeout(() => {
                                window.location.href = 'invoice.jsp';
                            }, 2000);
                        }
                    },
                    error: function (xhr, status, error) {
                        showAlert('Error loading invoice details: ' + error, 'danger');
                        console.error('Error response:', xhr.responseText);
                    }
                });
            }

            // Function to open contract selector modal
            function openContractSelector() {
                $('#contractSelectorModal').modal('show');
                searchContracts();
            }

            function searchContracts() {
                const searchTerm = $('#contractSearchInput').val();

                // Show loading indicator
                $('#contractTableBody').html('<tr><td colspan="5" class="text-center">Loading contracts...</td></tr>');

                // Make AJAX call to get contracts
                $.ajax({
                    url: "getContract",
                    type: "GET",
                    data: {
                        keyword: searchTerm,
                        contractId: searchTerm,
                    },
                    dataType: "json",
                    success: function (response) {
                        console.log("Contracts loaded:", response);

                        if (response) {
                            renderContractsTable(response);
                        } else {
                            $('#contractTableBody').html('<tr><td colspan="5" class="text-center">No contracts found</td></tr>');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error with contract search endpoint:", error);
                        $('#contractTableBody').html('<tr><td colspan="5" class="text-center">Error loading contracts</td></tr>');
                    }
                });
            }


            function renderContractsTable(contracts) {
                try {
                    console.log("renderContractsTable called with:", contracts);

                    // Convert single object to array if needed
                    if (contracts && !Array.isArray(contracts)) {
                        contracts = [contracts]; // Convert single object to array
                    }

                    // Now process as array
                    if (contracts && contracts.length > 0) {
                        let html = '';
                        contracts.forEach(function (contract) {
                            // Safely format amount with null/undefined check
                            let formattedAmount = 'N/A';
                            if (contract.amount != null) {
                                try {
                                    formattedAmount = '$' + parseFloat(contract.amount).toLocaleString('en-US',
                                        { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                                } catch (e) {
                                    formattedAmount = '$' + contract.amount;
                                }
                            }

                            html += '<tr>' +
                                '<td>' + (contract.contractId || '') + '</td>' +
                                '<td>' + (contract.realNo || contract.contractName || '') + '</td>' +
                                '<td>' + formattedAmount + '</td>' +
                                '<td>' + (contract.status || '') + '</td>' +
                                '<td><button class="btn btn-sm btn-primary" onclick="selectContract(\'' +
                                (contract.contractId || '') + '\', \'' + (contract.realNo || contract.contractName || '') + '\', ' +
                                (contract.amount || 0) + ', \'' + (contract.status || '') + '\')">Select</button></td>' +
                                '</tr>';
                        }); // FIXED: Proper closure of the forEach loop

                        $('#contractTableBody').html(html); // FIXED: This now runs after the loop completes
                    } else {
                        $('#contractTableBody').html('<tr><td colspan="5" class="text-center">No contracts found</td></tr>');
                    }
                } catch (error) {
                    console.error("Error in renderContractsTable:", error);
                    $('#contractTableBody').html('<tr><td colspan="5" class="text-center">Error rendering contracts</td></tr>');
                }
            }

            // Mock data function
            function loadMockContracts() {
                const mockContracts = [
                    {
                        contractId: "CRT001",
                        realNo: "SCF-2025-001",
                        amount: 50000,
                        status: "Active"
                    }
                ];

                renderContractsTable(mockContracts);
                console.log("Loaded mock contract data");
            }

            // Function to select a contract from the modal
            function selectContract(contractId, realNo, amount, status) {
                $('#add_contractId').val(contractId);
                $('#add_realNo').val(realNo);
                $('#add_contractStatus').text(status);
                $('#add_contractAmount').text('$' + amount.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
                $('#contractSelectorModal').modal('hide');
            }

            function saveInvoice() {
                // Validate form
                if (!validateInvoiceForm()) {
                    return;
                }


                // Get form data
                const invoiceData = {
                    contractID: $('#add_contractId').val(),
                    amount: $('#add_amount').val(),
                    payDate: $('#add_invoiceDate').val(),
                    paymentMethod: $('#add_paymentMethod').val(),
                    status: $('#add_status').val(),
                    memo: $('#add_memo').val()
                };

                // Make AJAX call to save invoice
                $.ajax({
                    url: "addInvoice",
                    type: "POST",
                    data: invoiceData,
                    success: function (response) {
                        if (response.success) {
                            showAlert('Invoice saved successfully', 'success');

                            // Switch to view mode using the newly created invoice ID
                            if (response.invoiceId) {
                                // Change URL without refreshing page
                                window.history.replaceState({}, '', 'invoiceDetail.jsp?id=' + response.invoiceId);

                                // Switch UI to view mode
                                $('#panelTitle').text('Invoice Details');
                                $('.add-mode').hide();
                                $('.view-mode').show();

                                // Load the new invoice details
                                loadInvoiceDetails(response.invoiceId);
                            } else {
                                // Fallback if no invoice ID is returned
                                setTimeout(() => {
                                    window.location.href = 'invoice.jsp';
                                }, 2000);
                            }
                        } else {
                            showAlert('Failed to save invoice: ' + response.message, 'danger');
                        }
                    },
                    error: function (xhr, status, error) {
                        showAlert('Error saving invoice: ' + error, 'danger');
                        console.error('Error response:', xhr.responseText);
                    }
                });
            }


            // Function to validate invoice form
            function validateInvoiceForm() {
                let isValid = true;

                // Check contract ID
                if (!$('#add_contractId').val()) {
                    showAlert('Please select a contract', 'warning');
                    isValid = false;
                }

                // Check amount
                const amount = $('#add_amount').val();
                if (!amount || parseFloat(amount) <= 0) {
                    showAlert('Please enter a valid amount', 'warning');
                    isValid = false;
                }

                // Check invoice date
                if (!$('#add_invoiceDate').val()) {
                    showAlert('Please select an invoice date', 'warning');
                    isValid = false;
                }

                // Check status
                if (!$('#add_status').val()) {
                    showAlert('Please select an invoice status', 'warning');
                    isValid = false;
                }

                return isValid;
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

            // Function to format date for input fields (YYYY-MM-DD)
            function formatDateForInput(date) {
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
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
                    setTimeout(function () {
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