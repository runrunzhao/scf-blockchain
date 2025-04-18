<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contract Details - Supply Chain Finance</title>
        <!-- Bootstrap CSS for responsive layout and styling -->
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
                margin-bottom: 30px;
            }

            .form-section {
                margin-bottom: 30px;
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

            /* Make the dropdown visible */
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

            /* Fix inline display */
            .dropdown.d-inline-block {
                vertical-align: middle;
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

                <!-- Enterprise dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Enterprise
                    </a>
                    <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                        <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                        <a class="dropdown-item" href="enterpriseDetail.jsp?mode=add">Add New Enterprise</a>
                    </div>
                </div>

                <!-- Contract dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="contractDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Contract
                    </a>
                    <div class="dropdown-menu" aria-labelledby="contractDropdown">
                        <a class="dropdown-item" href="contract.jsp">Search Contracts</a>
                        <a class="dropdown-item" href="contractDetail.jsp?mode=add">Add New Contract</a>
                    </div>
                </div>

                <!-- Invoice dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="invoiceDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Invoice
                    </a>
                    <div class="dropdown-menu" aria-labelledby="invoiceDropdown">
                        <a class="dropdown-item" href="invoice.jsp">Search Invoices</a>
                        <a class="dropdown-item" href="invoiceDetail.jsp?mode=add">Add New Invoice</a>
                    </div>
                </div>

            </div>
        </div>

        <div class="container">
            <!-- Contract Details Panel -->
            <div class="row">
                <div class="col-12">
                    <div class="detail-panel">
                        <h3 class="mb-4" id="panelTitle">Add New Contract</h3>

                        <!-- Form for adding or editing a contract -->
                        <form id="contractForm">
                            <div class="form-section">
                                <h4>Basic Information</h4>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="contractId">Contract ID</label>
                                        <input type="text" class="form-control" id="contractId"
                                            placeholder="Auto-generated" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="contractName">Real NO</label>
                                        <input type="text" class="form-control" id="contractName"
                                            placeholder="Enter real Contract NO">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="contractType">Contract Type</label>
                                        <select class="form-control" id="contractType">
                                            <option value="Purchase">Purchase</option>
                                            <option value="Sales">Sales</option>
                                            <option value="Service">Service</option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="contractStatus">Status</label>
                                        <select class="form-control" id="contractStatus">
                                            <option value="Draft">Draft</option>
                                            <option value="Pending">Pending</option>
                                            <option value="Active">Active</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-section">
                                <h4>Enterprise Information</h4>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="fromEnterpriseId">From Enterprise</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="fromEnterpriseId"
                                                placeholder="Enterprise ID" readonly>
                                            <input type="text" class="form-control" id="fromEnterpriseName"
                                                placeholder="Enterprise Name" readonly>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button"
                                                    onclick="selectFromEnterprise()">Select</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="toEnterpriseId">To Enterprise</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="toEnterpriseId"
                                                placeholder="Enterprise ID" readonly>
                                            <input type="text" class="form-control" id="toEnterpriseName"
                                                placeholder="Enterprise Name" readonly>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button"
                                                    onclick="selectToEnterprise()">Select</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-section">
                                <h4>Financial Information</h4>
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label for="amount">Total Amount</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">$</span>
                                                    </div>
                                                    <input type="number" class="form-control" id="amount"
                                                        placeholder="0.00" step="0.01">
                                                </div>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="signDate">Sign Date</label>
                                                <input type="date" class="form-control" id="signDate">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="effectiveDate">Effective Date</label>
                                                <input type="date" class="form-control" id="effectiveDate">
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label for="expiryDate">Expiry Date</label>
                                                <input type="date" class="form-control" id="expiryDate">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Payment Terms Card -->
                                <div class="card">
                                    <div class="card-header bg-light">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h5 class="mb-0">Payment Schedule</h5>
                                            <select class="form-control form-control-sm w-auto" id="paymentPeriods"
                                                onchange="updatePaymentFields()">
                                                <option value="1">1 Payment Period</option>
                                                <option value="2">2 Payment Periods</option>
                                                <option value="3">3 Payment Periods</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div id="paymentPeriodsContainer" class="mt-2">
                                            <!-- Payment period fields will be generated here -->
                                        </div>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h4>Additional Information</h4>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" id="description" rows="3"
                                            placeholder="Enter contract description"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="remarks">Remarks</label>
                                        <textarea class="form-control" id="remarks" rows="2"
                                            placeholder="Any additional notes"></textarea>
                                    </div>
                                </div>

                                <div class="form-row mt-4">
                                    <div class="col-md-6 mb-2">
                                        <button type="button" id="saveButton" class="btn btn-primary btn-block"
                                            onclick="saveContract()">Save Contract</button>
                                    </div>
                                    <div class="col-md-6 mb-2">
                                        <button type="button" class="btn btn-secondary btn-block"
                                            onclick="goBack()">Cancel</button>
                                    </div>
                                </div>
                        </form>
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
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

        <script>
            // Variable to track the current mode (add or view/edit)
            let isAddMode = true;

            // Function to initialize the page based on parameters
            function initPage() {
                const urlParams = new URLSearchParams(window.location.search);
                const id = urlParams.get('id');
                const mode = urlParams.get('mode');

                if (mode === 'add') {
                    isAddMode = true;
                    document.getElementById('panelTitle').innerText = 'Add New Contract';
                    // Set today's date as the default sign date
                    document.getElementById('signDate').valueAsDate = new Date();
                } else if (id) {
                    isAddMode = false;
                    document.getElementById('panelTitle').innerText = 'Contract Details';
                    loadContractDetails(id);
                } else {
                    alert('Invalid parameters. Redirecting to contract search.');
                    window.location.href = 'contract.jsp';
                }
            }

            // Global variable to store current target fields
            let currentTargetFields = {
                idField: '',
                nameField: ''
            };

            // Function to select from enterprise
            function selectFromEnterprise() {
                // Set the target fields for the selection
                currentTargetFields = {
                    idField: 'fromEnterpriseId',
                    nameField: 'fromEnterpriseName'
                };

                // Clear previous search results
                document.getElementById('searchEnterpriseId').value = '';
                document.getElementById('searchEnterpriseName').value = '';
                document.getElementById('enterpriseResultBody').innerHTML = '';
                document.getElementById('enterpriseSearchMessage').innerText = 'Enter search criteria and click Search';

                // Open the enterprise selection modal
                $('#enterpriseSearchModal').modal('show');
            }

            // Function to select to enterprise
            function selectToEnterprise() {
                // Set the target fields for the selection
                currentTargetFields = {
                    idField: 'toEnterpriseId',
                    nameField: 'toEnterpriseName'
                };

                // Clear previous search results
                document.getElementById('searchEnterpriseId').value = '';
                document.getElementById('searchEnterpriseName').value = '';
                document.getElementById('enterpriseResultBody').innerHTML = '';
                document.getElementById('enterpriseSearchMessage').innerText = 'Enter search criteria and click Search';

                // Open the enterprise selection modal
                $('#enterpriseSearchModal').modal('show');
            }

            // Function to search for enterprises
            function searchEnterprises() {
                const enterpriseId = document.getElementById('searchEnterpriseId').value;
                const enterpriseName = document.getElementById('searchEnterpriseName').value;

                if (!enterpriseId && !enterpriseName) {
                    document.getElementById('enterpriseSearchMessage').innerHTML =
                        '<div class="alert alert-warning">Please enter at least one search criteria</div>';
                    return;
                }

                document.getElementById('enterpriseSearchMessage').innerHTML =
                    '<div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div>';

                // 创建搜索参数，与enterprise.jsp中的方式保持一致
                const searchParams = new URLSearchParams();
                if (enterpriseId) searchParams.append('id', enterpriseId);
                if (enterpriseName) searchParams.append('name', enterpriseName);
                // 添加一个空的type参数，保持一致性
                searchParams.append('type', '');

                console.log('Search URL: searchEnterprises?' + searchParams.toString());

                // 使用与enterprise.jsp相同的URL和参数调用方式
                $.ajax({
                    url: 'searchEnterprises?' + searchParams.toString(),  // 使用正确的Servlet名称
                    type: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        console.log("Enterprise search result:", data);
                        displayEnterpriseSearchResults(data);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error searching enterprises:", error);
                        console.error("Response status:", xhr.status);
                        console.error("Response text:", xhr.responseText);

                        document.getElementById('enterpriseSearchMessage').innerHTML =
                            '<div class="alert alert-danger">Error searching enterprises: ' + error + '</div>';
                    }
                });
            }

            // Function to display enterprise search results - 修改为与 enterprise.jsp 一致
            function displayEnterpriseSearchResults(enterprises) {
                const tableBody = document.getElementById('enterpriseResultBody');
                tableBody.innerHTML = '';

                console.log("Displaying enterprises:", enterprises);

                if (enterprises && enterprises.length > 0) {
                    enterprises.forEach(function (enterprise) {
                        // 创建表格行
                        const row = document.createElement('tr');
                        row.style.cursor = 'pointer';

                        // 存储企业 ID 和名称用于选择
                        row.setAttribute('data-enterprise-id', enterprise.enterpriseID);
                        row.setAttribute('data-enterprise-name', enterprise.enterpriseName);

                        // 企业 ID 列
                        const idCell = document.createElement('td');
                        idCell.textContent = enterprise.enterpriseID;
                        row.appendChild(idCell);

                        // 名称列
                        const nameCell = document.createElement('td');
                        nameCell.textContent = enterprise.enterpriseName;
                        row.appendChild(nameCell);

                        // 类型列
                        const typeCell = document.createElement('td');
                        typeCell.textContent = enterprise.role || '';
                        row.appendChild(typeCell);

                        // 电话列 - 改为显示电话而非层级
                        const phoneCell = document.createElement('td');
                        phoneCell.textContent = enterprise.telephone || '';
                        row.appendChild(phoneCell);

                        // 地址列
                        const addressCell = document.createElement('td');
                        addressCell.textContent = enterprise.address || '';
                        row.appendChild(addressCell);

                        // 添加行到表格
                        tableBody.appendChild(row);
                    });

                    document.getElementById('enterpriseSearchMessage').innerHTML =
                        `<div class="alert alert-success">${enterprises.length} enterprises found. Double-click a row to select.</div>`;
                } else {
                    document.getElementById('enterpriseSearchMessage').innerHTML =
                        '<div class="alert alert-info">No enterprises found matching your criteria</div>';
                }
            }

            // Function to select an enterprise from search results
            function selectEnterpriseFromRow(enterpriseId, enterpriseName) {
                if (currentTargetFields.idField && currentTargetFields.nameField) {
                    document.getElementById(currentTargetFields.idField).value = enterpriseId;
                    document.getElementById(currentTargetFields.nameField).value = enterpriseName;
                    $('#enterpriseSearchModal').modal('hide');
                }
            }

            // Replace the current buttons section with this code
            function updateButtonStates(mode) {
                // Create all three buttons
                $('.form-row.mt-4').html(
                    '<div class="col-md-4 mb-2">' +
                    '<button type="button" id="editButton" class="btn btn-primary btn-block">Edit</button>' +
                    '</div>' +
                    '<div class="col-md-4 mb-2">' +
                    '<button type="button" id="saveButton" class="btn btn-success btn-block">Save</button>' +
                    '</div>' +
                    '<div class="col-md-4 mb-2">' +
                    '<button type="button" id="cancelButton" class="btn btn-secondary btn-block">Cancel</button>' +
                    '</div>'
                );

                // Set button states based on mode
                if (mode === 'view') {
                    // View mode: Edit enabled, Save disabled
                    $('#editButton').prop('disabled', false).show();
                    $('#saveButton').prop('disabled', true);
                    $('#cancelButton').prop('disabled', false).click(function () { goBack(); });

                    // Disable form fields in view mode
                    $('#contractForm input, #contractForm select, #contractForm textarea').prop('disabled', true);
                } else {
                    // Edit/add mode: Edit disabled, Save enabled
                    $('#editButton').prop('disabled', true);
                    $('#saveButton').prop('disabled', false).click(function () { saveContract(); });
                    $('#cancelButton').prop('disabled', false).click(function () {
                        const contractId = $('#contractId').val();
                        if (contractId && mode === 'edit') {
                            window.location.href = 'contractDetail.jsp?contractId=' + contractId + '&mode=view';
                        } else {
                            goBack();
                        }
                    });

                    // Enable form fields in edit mode
                    $('#contractForm input, #contractForm select, #contractForm textarea').prop('disabled', false);
                    $('#contractId').prop('readonly', true); // ID field always readonly
                }

                // Add edit button click handler
                $('#editButton').click(function () {
                    const contractId = $('#contractId').val();
                    window.location.href = 'contractDetail.jsp?contractId=' + contractId + '&mode=edit';
                });
            }


            function updatePaymentFields() {
                const periods = parseInt($('#paymentPeriods').val());
                const container = $('#paymentPeriodsContainer');

                // Debug log
                // console.log("Creating fields for " + periods + " payment periods");

                container.empty();

                // Calculate default amounts
                const totalAmount = parseFloat($('#amount').val() || 0);
                const defaultAmount = totalAmount > 0 ? (totalAmount / periods).toFixed(2) : '';

                // Create a card for payment periods
                const paymentCard = $('<div class="payment-periods-table"></div>');

                // Add header row
                const headerRow = $(
                    '<div class="row payment-period-header border-bottom pb-2 mb-3">' +
                    '<div class="col-md-2"><strong>Period</strong></div>' +
                    '<div class="col-md-3"><strong>Date</strong></div>' +
                    '<div class="col-md-3"><strong>Amount ($)</strong></div>' +
                    '<div class="col-md-4"><strong>Payment Method</strong></div>' +
                    '</div>'
                );
                paymentCard.append(headerRow);

                // Create fields for each payment period
                for (let i = 1; i <= periods; i++) {
                    const periodRow = $(
                        '<div class="row mb-3 payment-period" data-period="' + i + '">' +
                        '<div class="col-md-2 d-flex align-items-center">' +
                        '<span class="badge badge-primary">' + i + '</span>' +
                        '</div>' +
                        '<div class="col-md-3">' +
                        '<input type="date" class="form-control payment-date" ' +
                        'id="paymentDate' + i + '" placeholder="Date">' +
                        '</div>' +
                        '<div class="col-md-3">' +
                        '<div class="input-group">' +
                        '<div class="input-group-prepend">' +
                        '<span class="input-group-text">$</span>' +
                        '</div>' +
                        '<input type="number" class="form-control payment-amount" ' +
                        'id="paymentAmount' + i + '" placeholder="Amount" value="' + defaultAmount + '" step="0.01">' +
                        '</div>' +
                        '</div>' +
                        '<div class="col-md-4">' +
                        '<select class="form-control payment-method" id="PaymentMethod' + i + '">' +
                        '<option value="">Select Payment Method</option>' +
                        '<option value="CTT">CTT</option>' +
                        '<option value="Transfer">Transfer</option>' +
                        '<option value="Check">Check</option>' +
                        '<option value="Card">Card</option>' +
                        '</select>' +
                        '</div>' +
                        '</div>'
                    );
                    paymentCard.append(periodRow);

                    // Debug: verify field was created
                    // console.log("Created period " + i + " fields with IDs: paymentDate" + i + ", paymentAmount" + i + ", PaymentMethod" + i);
                }

                // Add total row
                const totalRow = $(
                    '<div class="row mt-3 pt-2 border-top">' +
                    '<div class="col-md-5 text-right">' +
                    '<strong>Total:</strong>' +
                    '</div>' +
                    '<div class="col-md-3">' +
                    '<div class="input-group">' +
                    '<div class="input-group-prepend">' +
                    '<span class="input-group-text">$</span>' +
                    '</div>' +
                    '<input type="text" class="form-control" ' +
                    'id="totalPaymentAmount" value="' + totalAmount.toFixed(2) + '" readonly>' +
                    '</div>' +
                    '</div>' +
                    '<div class="col-md-4"></div>' +
                    '</div>'
                );
                paymentCard.append(totalRow);

                container.append(paymentCard);

                // Add event listeners
                $('.payment-amount').on('input', function () {
                    updateTotalPaymentAmount();
                });

                // Debug: list all created fields
                console.log("Payment fields after creation:",
                    $('#paymentPeriodsContainer input, #paymentPeriodsContainer select').map(function () {
                        return this.id;
                    }).get().join(", ")
                );
            }



            // Function to update the total payment amountCASH
            function updateTotalPaymentAmount() {
                let total = 0;
                $('.payment-amount').each(function () {
                    const amount = parseFloat($(this).val()) || 0;
                    total += amount;
                });
                $('#totalPaymentAmount').val(total.toFixed(2));

                // Highlight if total doesn't match contract amount
                const contractAmount = parseFloat($('#amount').val()) || 0;
                if (Math.abs(total - contractAmount) > 0.01) {
                    $('#totalPaymentAmount').addClass('border-warning');
                } else {
                    $('#totalPaymentAmount').removeClass('border-warning');
                }
            }


            // Function to save contract
            function saveContract() {
                // Validate form
                if (!validateForm()) {
                    return;
                }

                console.log("Selected contract type:", $("#contractType").val());
                const paymentPeriods = [];
                const periodCount = parseInt($('#paymentPeriods').val());

                // Ensure payment fields exist before proceeding
                let allFieldsExist = true;
                for (let i = 1; i <= periodCount; i++) {
                    const dateField = document.getElementById('paymentDate' + i);
                    const amountField = document.getElementById('paymentAmount' + i);

                    if (!dateField) {
                        console.error("Missing date field: paymentDate" + i);
                        allFieldsExist = false;
                    }
                    if (!amountField) {
                        console.error("Missing amount field: paymentAmount" + i);
                        allFieldsExist = false;
                    }
                }

                if (!allFieldsExist) {
                    showAlert("Some payment fields are missing. Please try refreshing the page.", 'danger');
                    // Force recreate fields
                    updatePaymentFields();
                    return;
                }

                for (let i = 1; i <= periodCount; i++) {

                    const dateFieldId = 'paymentDate' + i;
                    const amountFieldId = 'paymentAmount' + i;
                    const methodFieldId = 'PaymentMethod' + i;

                    const dateField = document.getElementById(dateFieldId);
                    const amountField = document.getElementById(amountFieldId);
                    const methodField = document.getElementById(methodFieldId);
                    // Check if elements exist
                    if (!dateField) {
                        console.error(`Error: Field ${dateFieldId} not found`);
                        showAlert(`Error: Payment field for period ${i} not found. Please refresh the page.`, 'danger');
                        return;
                    }

                    if (!amountField) {
                        console.error(`Error: Field ${amountFieldId} not found`);
                        showAlert(`Error: Amount field for period ${i} not found. Please refresh the page.`, 'danger');
                        return;
                    }

                    const date = dateField.value;
                    const amount = amountField.value;
                    const method = methodField.value;

                    paymentPeriods.push({
                        period: parseInt(i),
                        paydate: date,
                        amount: amount,
                        paymentMethod: method
                    });
                }
                console.log("准备发送的付款期数据:", JSON.stringify(paymentPeriods));
                // Get form data
                const contract = {
                    contractId: $('#contractId').val(),
                    contractName: $('#contractName').val(),
                    contractType: $('#contractType').val(),
                    status: $('#contractStatus').val(),
                    fromEnterpriseId: $('#fromEnterpriseId').val(),
                    fromEnterpriseName: $('#fromEnterpriseName').val(),
                    toEnterpriseId: $('#toEnterpriseId').val(),
                    toEnterpriseName: $('#toEnterpriseName').val(),
                    amount: $('#amount').val(),
                    signDate: $('#signDate').val(),
                    effectiveDate: $('#effectiveDate').val(),
                    expiryDate: $('#expiryDate').val(),
                    paymentPeriods: paymentPeriods,
                    description: $('#description').val(),
                    remarks: $('#remarks').val()
                };

                console.log('Saving contract data:', contract);

                // Show saving indicator
                $('#saveButton').prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...');

                $.ajax({
                    url: 'saveContract',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(contract),
                    success: function (response) {
                        // Restore button
                        $('#saveButton').prop('disabled', false).html('Save Contract');
                        console.log('Save response:', response);

                        if (response && response.success) {
                            // Show success message
                            showAlert('Contract saved successfully! Invoices have been generated.', 'success');

                            // Get current mode
                            const urlParams = new URLSearchParams(window.location.search);
                            const mode = urlParams.get('mode');

                            // If in add mode, update URL and show contract ID
                            if (mode === 'add') {
                                // Update URL without refreshing
                                const newContractId = response.contractId;
                                console.log('New contract ID:', newContractId);
                                history.pushState(null, '', `contractDetail.jsp?contractId=${newContractId}&mode=edit`);

                                // Update contract ID field
                                $('#contractId').val(newContractId);

                                // Update page title
                                document.getElementById('panelTitle').innerText = 'Edit Contract';

                                // Change mode flag
                                isAddMode = false;
                                $('#saveButton').html('Save');
                            }
                        } else {
                            // Show error message
                            const errorMessage = response && response.error ? response.error : 'Unknown error occurred';
                            showAlert('Error: ' + errorMessage, 'danger');
                        }
                    },
                    error: function (xhr, status, error) {
                        // Restore button
                        $('#saveButton').prop('disabled', false).html('Save Contract');
                        console.error('Error saving contract:', error);
                        console.error('Response:', xhr.responseText);

                        // Show error message
                        let errorMessage = 'Error saving contract';
                        try {
                            const response = JSON.parse(xhr.responseText);
                            if (response && response.error) {
                                errorMessage += ': ' + response.error;
                            }
                        } catch (e) {
                            errorMessage += ': ' + error;
                        }

                        showAlert(errorMessage, 'danger');
                    }
                });
            }

            // Helper function to show alerts
            function showAlert(message, type) {
                // 修改后：
                const alertDiv = $(
                    '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                    message +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                    '<span aria-hidden="true">&times;</span>' +
                    '</button>' +
                    '</div>'
                );

                // Remove existing alerts
                $('.alert').remove();

                // Add new alert to page
                $('.detail-panel h3').after(alertDiv);

                // Auto-hide after 5 seconds
                setTimeout(function () {
                    alertDiv.alert('close');
                }, 5000);
            }

            // Function to validate the form
            function validateForm() {
                // Add your validation logic here
                const contractName = document.getElementById('contractName').value;
                if (!contractName) {
                    alert('Please enter a real contract NO');
                    return false;
                }

                return true;
            }

            // Function to go back to the previous page
            function goBack() {
                window.location.href = 'contract.jsp';
            }

            // Function to load contract details (for edit mode)
            function loadContractDetails(id) {
                // Make AJAX call to get contract details
                $.ajax({
                    url: "getContract",
                    type: "GET",
                    data: {
                        contractId: id
                    },
                    dataType: "json",
                    success: function (contract) {
                        if (contract) {
                            document.getElementById('contractId').value = contract.contractId;
                            document.getElementById('contractName').value = contract.contractName;
                            document.getElementById('contractType').value = contract.contractType;
                            document.getElementById('contractStatus').value = contract.status;
                            document.getElementById('fromEnterpriseId').value = contract.fromEnterpriseId;
                            document.getElementById('fromEnterpriseName').value = contract.fromEnterpriseName;
                            document.getElementById('toEnterpriseId').value = contract.toEnterpriseId;
                            document.getElementById('toEnterpriseName').value = contract.toEnterpriseName;
                            document.getElementById('amount').value = contract.amount;

                            // Set dates if available
                            if (contract.signDate) {
                                document.getElementById('signDate').value = contract.signDate;
                            }
                            if (contract.effectiveDate) {
                                document.getElementById('effectiveDate').value = contract.effectiveDate;
                            }
                            if (contract.expiryDate) {
                                document.getElementById('expiryDate').value = contract.expiryDate;
                            }

                            document.getElementById('description').value = contract.description || '';
                            document.getElementById('remarks').value = contract.remarks || '';

                            // 在loadContractDetails函数中找到这段代码
                            if (contract.paymentPeriods && contract.paymentPeriods.length > 0) {
                                $('#paymentPeriods').val(contract.paymentPeriods.length);

                                // Call updatePaymentFields first to create the fields
                                updatePaymentFields();

                                console.log("Payment periods from server:", contract.paymentPeriods);

                                // 增加延迟时间并使用正确的属性名
                                setTimeout(function () {
                                    console.log("Setting payment period values now...");

                                    for (let i = 0; i < contract.paymentPeriods.length; i++) {
                                        const period = contract.paymentPeriods[i];
                                        const periodNum = period.period;

                                        // 使用jQuery连接字符串而非模板字符串
                                        console.log("Setting data for period " + periodNum +
                                            ": date=" + period.date +
                                            ", amount=" + period.amount);

                                        // 使用正确的属性名称
                                        $('#paymentDate' + periodNum).val(period.date);
                                        $('#paymentAmount' + periodNum).val(period.amount);
                                        $('#PaymentMethod' + periodNum).val(period.paymentMethod);

                                        // 验证值是否设置成功
                                        console.log("After setting - date value: " +
                                            $('#paymentDate' + periodNum).val());
                                    }

                                    // 重新计算总金额
                                    updateTotalPaymentAmount();
                                }, 1000); // 增加到1秒以确保DOM已更新

                            } else {
                                // Default to 1 payment period
                                $('#paymentPeriods').val(1);
                                updatePaymentFields();
                            }
                        } else {
                            alert('Contract not found');
                            window.location.href = 'contract.jsp';
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("Error loading contract: " + error);
                        window.location.href = 'contract.jsp';
                    }
                });
            }

            // Helper function to get URL parameters
            function getUrlParameter(name) {
                name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
                var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
                var results = regex.exec(location.search);
                return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
            }

            // Document ready function
            $(document).ready(function () {
                // Get URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                const contractId = urlParams.get('contractId');
                const mode = urlParams.get('mode');
                updateButtonStates(mode || 'view');
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

                // Add event listener for enterprise search table rows
                $(document).on('click', '#enterpriseResultTable tbody tr', function () {
                    // Highlight the selected row
                    $(this).addClass('table-primary').siblings().removeClass('table-primary');
                });

                // Add double-click event for quick selection
                $(document).on('dblclick', '#enterpriseResultTable tbody tr', function () {
                    const enterpriseId = $(this).attr('data-enterprise-id');
                    const enterpriseName = $(this).attr('data-enterprise-name');
                    selectEnterpriseFromRow(enterpriseId, enterpriseName);
                });

                if (mode === 'add') {
                    // Setup for add mode
                    isAddMode = true;
                    document.getElementById('panelTitle').innerText = 'Add New Contract';
                    // Set Contract ID field as read-only
                    $('#contractId').prop('readonly', true).attr('placeholder', 'Auto-generated');
                    // Set today's date as the default sign date
                    document.getElementById('signDate').valueAsDate = new Date();


                    // Initialize payment period fields with default selection (1 period)
                    updatePaymentFields();
                    // 确保显示正确的按钮
                    $('#saveButton').show().html('Save Contract');

                } else if (contractId) {
                    // Setup for edit/view mode with a contract ID
                    isAddMode = false;
                    loadContractDetails(contractId);

                    if (mode === 'view') {
                        // 视图模式
                        document.getElementById('panelTitle').innerText = 'View Contract';

                        // 禁用所有输入字段
                        $('#contractForm input, #contractForm select, #contractForm textarea').prop('disabled', true);

                        /*
                        $('.form-row.mt-4').html(
                            '<div class="col-md-6 mb-2">' +
                            '<button type="button" class="btn btn-primary btn-block" ' +
                            'onclick="location.href=\'contractDetail.jsp?contractId=' + contractId + '&mode=edit\'">' +
                            'Edit Contract' +
                            '</button>' +
                            '</div>' +
                            '<div class="col-md-6 mb-2">' +
                            '<button type="button" class="btn btn-secondary btn-block" ' +
                            'onclick="goBack()">Back to List</button>' +
                            '</div>'
                        );*/
                        
                    } else {
                        // 编辑模式
                        document.getElementById('panelTitle').innerText = 'Edit Contract';

                        // 确保表单可编辑
                        $('#contractForm input, #contractForm select, #contractForm textarea').prop('disabled', false);
                        $('#contractId').prop('readonly', true); // ID 字段始终只读

                        // 确保显示保存按钮
                        $('#saveButton').show().html('Save');
                    }
                } else if (mode === 'edit' || mode === 'view') {
                    // Handle edit/view mode without a contract ID
                    alert('Contract ID is required for edit/view mode');
                    window.location.href = 'contract.jsp';
                } else {
                    updatePaymentFields();

                }
                // Update payment fields when amount changes
                $('#amount').on('change', function () {
                    updatePaymentFields();
                });
            });

        </script>

        <!-- Enterprise Search Modal -->
        <div class="modal fade" id="enterpriseSearchModal" tabindex="-1" role="dialog"
            aria-labelledby="enterpriseSearchModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="enterpriseSearchModalLabel">Search Enterprise</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Search Form -->
                        <div class="form-row mb-3">
                            <div class="form-group col-md-5">
                                <label for="searchEnterpriseId">Enterprise ID</label>
                                <input type="text" class="form-control" id="searchEnterpriseId"
                                    placeholder="Enter Enterprise ID">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="searchEnterpriseName">Enterprise Name</label>
                                <input type="text" class="form-control" id="searchEnterpriseName"
                                    placeholder="Enter Enterprise Name">
                            </div>
                            <div class="form-group col-md-2 d-flex align-items-end">
                                <button type="button" class="btn btn-primary w-100"
                                    onclick="searchEnterprises()">Search</button>
                            </div>
                        </div>

                        <!-- Search Results Table -->
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover" id="enterpriseResultTable">
                                <thead class="thead-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Role</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                    </tr>
                                </thead>
                                <tbody id="enterpriseResultBody">
                                    <!-- Results will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div id="enterpriseSearchMessage" class="mt-2 text-center">
                            Enter search criteria and click Search
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

    </body>

    </html>