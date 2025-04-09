/autoPayInvoice.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AutoPay Invoice - Supply Chain Finance</title>
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

            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-weight: 500;
                display: inline-block;
            }

            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }

            .status-approved {
                background-color: #d4edda;
                color: #155724;
            }

            .status-paid {
                background-color: #cce5ff;
                color: #004085;
            }

            .status-rejected {
                background-color: #f8d7da;
                color: #721c24;
            }

            .autopay-section {
                background-color: #f0f8ff;
                border-left: 4px solid #007bff;
                padding: 15px;
                margin-top: 20px;
                margin-bottom: 20px;
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

                <!-- CTT menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="cttDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false"> CTT
                    </a>
                    <div class="dropdown-menu" aria-labelledby="cttDropdown">
                        <a class="dropdown-item" href="signSC.jsp">Sign SC</a>
                        <a class="dropdown-item" href="TGE.jsp">TGE</a>
                        <a class="dropdown-item" href="CTTinfo.jsp">Detail</a>
                        <a class="dropdown-item" href="autoPayInvoice.jsp">AutoPay Invoice</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Invoice Detail Section -->
            <div class="row">
                <div class="col-12">
                    <div class="detail-panel">
                        <!-- Page Title -->
                        <div class="mb-4">
                            <h3 id="panelTitle">SC AutoPay Invoice Details</h3>
                        </div>

                        <!-- View Mode Section -->
                        <div class="view-mode">
                            <!-- AutoPay Information -->
                            <div class="autopay-section">
                                <h4>AutoPay Information</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Payment Status:</strong></label>
                                            <p><span class="status-badge" id="autoPayStatus">Pending</span></p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Scheduled Date:</strong></label>
                                            <p id="scheduleDate">-</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>SC Transaction ID:</strong></label>
                                            <p id="transactionId">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>SC Gas Fee:</strong></label>
                                            <p id="gasFee">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Wallet Connection - Styled to match page -->
                            <div class="form-section">
                                <h4>Wallet Connection</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Connection Status:</strong></label>
                                            <p>
                                                <span id="walletStatus" class="status-badge status-pending">Not
                                                    Connected</span>
                                                <button id="connectWalletBtn"
                                                    class="btn btn-sm btn-primary ml-2">Connect Wallet</button>
                                            </p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Wallet Address:</strong></label>
                                            <p id="walletAddress" class="text-monospace">Not connected</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Wallet Balance:</strong></label>
                                            <p id="walletBalance">0 POL</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Network:</strong></label>
                                            <p id="networkInfo">Polygon Testnet</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Basic Information -->
                            <div class="form-section">
                                <h4>Invoice Information</h4>
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

                            </div>


                            <!-- Account Information - NEW SECTION -->
                            <div class="form-section">
                                <h4>Account Information</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Payer Name:</strong></label>
                                            <p id="payerName">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Payer Wallet Address:</strong></label>
                                            <p id="payerWallet" class="text-monospace">-</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label><strong>Receiver Name:</strong></label>
                                            <p id="receiverName">-</p>
                                        </div>
                                        <div class="form-group">
                                            <label><strong>Receiver Wallet Address:</strong></label>
                                            <p id="receiverWallet" class="text-monospace">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="button-group">
                                <button class="btn btn-primary" onclick="enableSCAutoPay">SC AutoPay</button>
                                <button class="btn btn-secondary" onclick="goToInvoiceList()">Back to Invoice
                                    List</button>
                            </div>
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
        <script src="https://cdn.jsdelivr.net/npm/web3@1.6.0/dist/web3.min.js"></script>

        <script>
            // Initialize page when document is ready
            $(document).ready(function () {
                console.log("AutoPay Invoice page loading");

                // Get URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                const invoiceId = urlParams.get('invoiceId') || urlParams.get('id');

                // Check if we have an invoice ID
                if (invoiceId) {
                    // Load invoice details
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
            });

            // 全局变量
            let web3;
            let contract;
            let userAddress;

            document.addEventListener('DOMContentLoaded', () => {
                // 连接钱包按钮
                document.getElementById('connectWalletBtn').addEventListener('click', connectWallet);
              
                // 处理表单提交
                document.getElementById('mintForm').addEventListener('submit', async function (e) {
                    e.preventDefault();

                    const recipientAddress = document.getElementById('recipientAddress').value;
                    const amount = document.getElementById('amount').value;

                    // 验证输入
                    if (!web3 || !web3.utils.isAddress(recipientAddress)) {
                        showStatus("Invalid Ethereum address format", true);
                        return;
                    }

                    if (amount <= 0) {
                        showStatus("Amount must be greater than 0", true);
                        return;
                    }

                    // 调用铸币函数
                    // await mintToken(recipientAddress, amount);


                });

                // 自动连接钱包 (如果已授权)
                if (window.ethereum) {
                    window.ethereum.request({ method: 'eth_accounts' })
                        .then(accounts => {
                            if (accounts.length > 0) {
                                connectWallet();
                            }
                        });
                }
            });

            // 监听钱包账户变化
            if (window.ethereum) {
                window.ethereum.on('accountsChanged', function (accounts) {
                    connectWallet();
                });

                window.ethereum.on('chainChanged', function (chainId) {
                    window.location.reload();
                });
            }

            async function connectWallet() {
                if (typeof window.ethereum !== 'undefined') {
                    try {
                        const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
                        const walletAddress = accounts[0];

                        // Update wallet address display
                        document.getElementById('walletAddress').innerText = walletAddress;

                        // Get and update balance
                        const balanceHex = await ethereum.request({
                            method: 'eth_getBalance',
                            params: [walletAddress, 'latest']
                        });
                        const balance = parseFloat(parseInt(balanceHex, 16) / Math.pow(10, 18)).toFixed(4);
                        document.getElementById('walletBalance').innerText = balance + " POL";

                        // Update connection status
                        document.getElementById('walletStatus').innerText = "Connected";
                        document.getElementById('walletStatus').style.color = "green";

                        // Update button to show connected state
                        const connectButton = document.getElementById('connectWalletBtn');
                        connectButton.innerText = "Wallet Connected";
                        connectButton.classList.remove('btn-primary');
                        connectButton.classList.add('btn-success');

                        // Initialize Web3 and save address
                        web3 = new Web3(window.ethereum);
                        userAddress = walletAddress;
                      
                    } catch (error) {
                        console.error("Failed to connect wallet:", error);
                        alert("Failed to connect wallet: " + error.message);
                    }
                } else {
                    alert("MetaMask is not installed. Please install it to use this feature.");
                }
            }

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
                            $('#invoiceStatus').text(invoice.status || '-');
                            $('#paymentMethod').text(invoice.paymentMethod || '-');

                            // Set AutoPay information (this would come from a separate API in a real implementation)
                            setMockAutoPayInfo(invoice);

                            // Load contract details
                            loadContractDetails(invoice.contractID);

                            // Update page title with invoice ID
                            document.title = `AutoPay Invoice: ${invoice.invoiceID} - Supply Chain Finance`;
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

            // Function to load contract details
            function loadContractDetails(contractId) {
                $.ajax({
                    url: "getContractDetails",
                    type: "GET",
                    data: {
                        contractId: contractId
                    },
                    dataType: "json",
                    success: function (contract) {
                        $('#contractRealNo').text(contract.contractName || '-');
                        $('#contractAmount').text('$' + contract.amount.toLocaleString('en-US',
                            { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
                        $('#contractStatus').text(contract.status || '-');

                        // Load account information after contract details are loaded
                        loadAccountInfoInContract(contractId);
                        
                    },
                    error: function () {
                        $('#contractRealNo').text('Not found');
                        $('#contractStatus').text('Not found');
                    }
                });
            }

            function loadAccountInfoInContract(contractId) {
                $.ajax({
                    url: "getContractParties",
                    type: "GET",
                    data: {
                        contractId: contractId
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data) {
                            // Update payer information
                            $('#payerName').text(data.payerName || '-');
                            $('#payerWallet').text(data.payerWalletAddr || '-');

                            // Update receiver information
                            $('#receiverName').text(data.receiverName || '-');
                            $('#receiverWallet').text(data.receiverWalletAddr || '-');
                        } else {
                            // No data found
                            $('#payerName').text('Not found');
                            $('#payerWallet').text('Not found');
                            $('#receiverName').text('Not found');
                            $('#receiverWallet').text('Not found');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error loading account information:", error);
                        $('#payerName').text('Error');
                        $('#payerWallet').text('Error');
                        $('#receiverName').text('Error');
                        $('#receiverWallet').text('Error');
                    }
                });
            }

            // Set mock AutoPay information for display purposes
            function setMockAutoPayInfo(invoice) {
                // This would be replaced by real data from your backend
                const today = new Date();
                const nextWeek = new Date(today.getTime() + 7 * 24 * 60 * 60 * 1000);

                $('#scheduleDate').text(formatDate(nextWeek));
                $('#transactionId').text('0x' + Math.random().toString(16).substr(2, 40));
                $('#gasFee').text('$' + (Math.random() * 0.05).toFixed(4));

                // Set status based on invoice status
                let status = 'Pending';
                let statusClass = 'status-pending';

                if (invoice.status === 'Paid') {
                    status = 'Completed';
                    statusClass = 'status-approved';
                } else if (invoice.status === 'Rejected') {
                    status = 'Failed';
                    statusClass = 'status-rejected';
                }

                $('#autoPayStatus').text(status);
                $('#autoPayStatus').removeClass().addClass('status-badge ' + statusClass);
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
                    setTimeout(function () {
                        $('.alert').alert('close');
                    }, 5000);
                }
            }


            function enableSCAutoPay() {

                const invoiceId = $('#invoiceId').text();

                if (confirm('Are you sure you want to enable SC AutoPay for this invoice?')) {
                    // Show loading message
                    showAlert('Processing SC AutoPay request...', 'info');

                    // This would be an AJAX call to your backend in a production system
                    setTimeout(() => {
                        // Simulate successful processing
                        showAlert('SC AutoPay successfully enabled for invoice ' + invoiceId, 'success');

                        // Update status to reflect the change
                        $('#autoPayStatus').text('Scheduled');
                        $('#autoPayStatus').removeClass().addClass('status-badge status-pending');
                    }, 1500);
                }
            }

        </script>
    </body>

    </html>