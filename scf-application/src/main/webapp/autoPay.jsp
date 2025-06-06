<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AutoPay Invoice - Supply Chain Finance</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
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

            .status-indicator {
                display: inline-block;
                width: 12px;
                height: 12px;
                border-radius: 50%;
                margin-right: 6px;
            }

            .status-completed {
                background-color: #28a745;
            }

            .status-failed {
                background-color: #dc3545;
            }

            .wallet-section {
                margin-bottom: 20px;
            }

            .connected-account-info {
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 0.25rem;
            }

            .badge-warning {
                color: #856404;
                background-color: #fff3cd;
            }

            .badge-success {
                color: #155724;
                background-color: #d4edda;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/ethers@5.7.2/dist/ethers.umd.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/qrcode/build/qrcode.min.js"></script>
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
                        <a class="dropdown-item" href="autoPay.jsp">AutoPay Invoice</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Invoice Information Card -->
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Invoice Details</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Invoice ID:</label>
                                <p id="invoiceId" class="font-weight-bold"></p>
                            </div>
                            <div class="form-group">
                                <label>Invoice Amount:</label>
                                <p id="invoiceAmount" class="font-weight-bold"></p>
                            </div>
                            <div class="form-group">
                                <label>Payment Method:</label>
                                <p id="paymentMethod"></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>From Enterprise:</label>
                                <p id="fromEnterprise"></p>
                            </div>
                            <div class="form-group">
                                <label>To Enterprise:</label>
                                <p id="toEnterprise"></p>
                            </div>
                            <div class="form-group">
                                <label>Payment Due:</label>
                                <p id="payDate" class="text-danger font-weight-bold"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Wallet Connection Section -->
            <div class="card wallet-section">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Wallet Connection</h5>
                </div>
                <div class="card-body">
                    <div class="connected-account-info mb-3 p-2 border rounded bg-light">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <span id="connectionStatus" class="badge badge-warning mr-2">Not Connected</span>
                                <span id="connectedWallet" class="text-primary">No account detected</span>
                            </div>
                            <button type="button" id="connectWalletBtn" class="btn btn-primary btn-sm">
                                <i class="fas fa-plug mr-1"></i> Connect Wallet
                            </button>
                        </div>
                    </div>
                    <div class="wallet-info">
                        <div class="mb-1"><strong>Address:</strong> <span id="walletAddress">Not connected</span></div>
                        <div class="mb-2"><strong>Gas Balance:</strong> <span id="walletBalance">0 POL</span></div>
                    </div>
                </div>
            </div>

            <!-- Schedule Auto Payment Card -->
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">Schedule Automatic Payment</h5>
                </div>
                <div class="card-body">
                    <form id="schedulePaymentForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="fromAddress">Your Wallet Address:</label>
                                    <input type="text" class="form-control" id="fromAddress" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="tokenBalance">Your CTT Balance: </label>
                                    <button type="button" class="btn btn-success btn-action"
                                        onclick="showTokenBalance()">Query CTT</button>
                                    <input type="text" class="form-control" id="tokenBalance" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="toAddress">Payment Recipient Address:</label>
                                    <input type="text" class="form-control" id="toAddress" required>
                                    <small class="form-text text-muted">This is the blockchain address that will receive
                                        the payment.</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="amount">Payment Amount:</label>
                                    <input type="number" step="0.000001" class="form-control" id="amount" required>
                                    <small class="form-text text-muted">The amount of tokens to transfer.</small>
                                </div>
                                <div class="form-group">
                                    <label for="scheduledDate">Scheduled Payment Date:</label>
                                    <input type="datetime-local" class="form-control" id="scheduledDate" required>
                                    <small class="form-text text-muted">When the payment should be executed.</small>
                                </div>
                            </div>
                        </div>

                        <div class="form-group text-center mt-4">
                            <button type="submit" class="btn btn-success btn-action" id="saveBtn">
                                <i class="fas fa-calendar-check mr-3"></i>Schedule Payment
                            </button>
                            <a href="invoice.jsp" class="btn btn-secondary btn-action ml-4">
                                <i class="fas fa-arrow-left mr-3"></i>Back to Invoices
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Scheduled Payments List -->
            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Your Scheduled Payments</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive" id="scheduledPaymentsTable">
                        <!-- Table will be loaded here -->
                    </div>
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-primary" id="searchPaymentsBtn">
                            <i class="fas fa-search mr-2"></i>Search
                        </button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/web3@1.3.0/dist/web3.min.js"></script>

        <script>
            // Global variables
            window.web3 = undefined;
            window.userAddress = undefined;
            let invoiceDetails = {};
            let currentContractAddress = null;

            document.addEventListener('DOMContentLoaded', () => {
                if (window.ethereum) {
                    window.ethereum.on('accountsChanged', (accounts) => {
                        if (accounts.length > 0) {
                            updateUIForConnectedWallet(accounts[0]);
                        } else {
                            resetWalletConnectionUI();
                        }
                    });
                    window.ethereum.on('chainChanged', () => window.location.reload());
                    window.ethereum.on('disconnect', () => resetWalletConnectionUI());
                }
                document.getElementById('connectWalletBtn').addEventListener('click', connectMetaMask);
                document.getElementById('searchPaymentsBtn').addEventListener('click', searchPayments);
                currentContractAddress = getLatestScTransAddr();
                if (currentContractAddress) {
                    console.log("Initialized contract address:", currentContractAddress);
                } else {
                    console.error("Failed to initialize contract address");
                }
            });

            function showStatus(message, isError = false) {
                // Check if status element exists, if not create it
                let statusDiv = document.getElementById('status');
                if (!statusDiv) {
                    // Create a new status div
                    statusDiv = document.createElement('div');
                    statusDiv.id = 'status';
                    // Insert it at the top of the container
                    const container = document.querySelector('.container');
                    if (container) {
                        container.insertBefore(statusDiv, container.firstChild);
                    } else {
                        // If can't find container, add to body
                        document.body.appendChild(statusDiv);
                    }
                }

                // Now set the text content and display properties
                statusDiv.textContent = message;
                statusDiv.style.display = 'block';

                if (isError) {
                    statusDiv.className = 'status-error';
                } else {
                    statusDiv.className = 'status-success';
                }
            }

            async function getLatestScTransAddr() {
                try {
                    const response = await fetch('/api/contract/latest-address');
                    const data = await response.json();
                    if (data.success) {
                        return data.scTransAddr;
                    } else {
                        console.error("Error getting contract address:", data.message);
                        return null;
                    }
                } catch (error) {
                    console.error("Failed to get contract address:", error);
                    return null;
                }
            }

            // Global connection flag to prevent multiple simultaneous connection attempts
            let isConnecting = false;

            async function connectMetaMask() {
                // 检查 MetaMask 是否安装
                if (typeof window.ethereum === 'undefined') {
                    showStatus("MetaMask is not installed. Please install MetaMask and try again.", true);
                    return;
                }

                // 防止重复连接
                if (isConnecting) {
                    showStatus("Connection request already in progress. Please wait...", true);
                    return;
                }

                try {
                    isConnecting = true;

                    // 强制弹出账户选择界面
                    await ethereum.request({
                        method: 'wallet_requestPermissions',
                        params: [{ eth_accounts: {} }]
                    });

                    // 获取账户
                    const accounts = await ethereum.request({ method: 'eth_accounts' });

                    if (accounts && accounts.length > 0) {
                        window.userAddress = accounts[0];
                        window.web3 = new Web3(window.ethereum);
                        updateUIForConnectedWallet(accounts[0]);
                        showStatus("Connected to wallet: " + formatAddress(accounts[0]));
                    } else {
                        resetWalletConnectionUI();
                        showStatus("No accounts selected", true);
                    }
                } catch (error) {
                    console.error("Error connecting to MetaMask:", error);
                    if (error.code === 4001) {
                        showStatus("You rejected the connection request.", true);
                    } else if (error.message.includes('already pending')) {
                        showStatus("A connection request is already pending. Please check MetaMask popup.", true);
                    } else {
                        showStatus("Connection failed: " + error.message, true);
                    }
                    resetWalletConnectionUI();
                } finally {
                    isConnecting = false;
                }
            }


            // Update UI for connected wallet
            async function updateUIForConnectedWallet(address) {
                // Update status indicators
                document.getElementById('connectionStatus').className = 'badge badge-success mr-2';
                document.getElementById('connectionStatus').textContent = 'Connected';
                document.getElementById('connectedWallet').textContent = formatAddress(address);

                // Update wallet address display
                document.getElementById('walletAddress').innerText = address;

                // Update connect button
                const connectButton = document.getElementById('connectWalletBtn');
                connectButton.innerText = "Wallet Connected";
                connectButton.classList.remove('btn-primary');
                connectButton.classList.add('btn-success');

                // Initialize Web3 if not already initialized
                if (!web3) {
                    // web3 = new Web3(window.ethereum);
                    window.web3 = new Web3(window.ethereum);
                }

                // Get and update balance
                getWalletBalance(address);

                // Update recipient field if it exists
                const recipientField = document.getElementById('fromAddress');
                if (recipientField && recipientField.value === "") {
                    recipientField.value = address;
                }

            }

            // Reset UI when wallet is disconnected
            function resetWalletConnectionUI() {
                // Reset state variables
                //  userAddress = null;
                window.userAddress = null;
                // web3 = null;
                window.web3 = null;

                // Reset UI elements
                document.getElementById('connectionStatus').className = 'badge badge-warning mr-2';
                document.getElementById('connectionStatus').textContent = 'Not Connected';
                document.getElementById('connectedWallet').textContent = 'No account detected';
                document.getElementById('walletAddress').innerText = "Not connected";
                document.getElementById('walletBalance').innerText = "0 POL";

                // Reset connect button
                const connectButton = document.getElementById('connectWalletBtn');
                connectButton.innerText = "Connect Wallet";
                connectButton.classList.remove('btn-success');
                connectButton.classList.add('btn-primary');
            }

            // Format address to shorter display format
            function formatAddress(address) {
                if (!address) return "Not connected";
                return address.substring(0, 6) + '...' + address.substring(address.length - 4);
            }

            // Get wallet balance
            async function getWalletBalance(address) {
                if (!address) return;

                try {
                    const balanceHex = await ethereum.request({
                        method: 'eth_getBalance',
                        params: [address, 'latest']
                    });
                    const balance = parseFloat(parseInt(balanceHex, 16) / Math.pow(10, 18)).toFixed(4);
                    document.getElementById('walletBalance').innerText = balance + " POL";
                } catch (error) {
                    console.error("Error getting wallet balance:", error);
                    document.getElementById('walletBalance').innerText = "Error";
                }
            }


            async function showTokenBalance() {
                const tokenAddress = currentContractAddress; 
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                const signer = provider.getSigner();
                const userAddress = await signer.getAddress();
                console.log("User Address: ", userAddress);
                if (!window.ethereum) {
                    alert("Please install MetaMask to use this feature.");
                    return;
                }

                if (!userAddress) {
                    alert("Please connect your wallet first.");
                    return;
                }
                const tokenABI = [
                    "function balanceOf(address owner) view returns (uint256)",
                    "function decimals() view returns (uint8)"
                ];
                const tokenContract = new ethers.Contract(tokenAddress, tokenABI, provider);
                const rawBalance = await tokenContract.balanceOf(userAddress);
                const decimals = await tokenContract.decimals();
                const formattedBalance = parseFloat(ethers.utils.formatUnits(rawBalance, decimals)).toFixed(4);
                console.log("CTT Balance: ", formattedBalance);
                document.getElementById('tokenBalance').value = formattedBalance + " CTT "; // Changed from value to innerText
            }


            // Load invoice details
            function loadInvoiceDetails() {
                const urlParams = new URLSearchParams(window.location.search);
                const invoiceId = urlParams.get('invoiceId');

                if (!invoiceId) {
                    alert("No invoice ID provided");
                    window.location.href = "invoice.jsp";
                    return;
                }

                $.ajax({
                    url: 'getSingleInvoice?invoiceId=' + invoiceId,
                    method: 'GET',
                    success: function (data) {
                        if (data) {
                            invoiceDetails = data;

                            // Update invoice details section
                            document.getElementById('invoiceId').textContent = invoiceDetails.invoiceID;
                            document.getElementById('invoiceAmount').textContent = invoiceDetails.amount + ' ' + (invoiceDetails.currency || 'USD');
                            document.getElementById('paymentMethod').textContent = invoiceDetails.paymentMethod;

                            // For enterprise names, get enterprise names if they're not included
                            if (invoiceDetails.fromEnterpriseID) {
                                getEnterpriseName(invoiceDetails.fromEnterpriseID, 'fromEnterprise');
                            }
                            if (invoiceDetails.toEnterpriseID) {
                                getEnterpriseName(invoiceDetails.toEnterpriseID, 'toEnterprise');
                            }

                            document.getElementById('payDate').textContent = formatDate(invoiceDetails.payDate);

                            // Pre-fill payment details
                            document.getElementById('amount').value = invoiceDetails.amount;
                            document.getElementById('toAddress').value = invoiceDetails.recipientAddress || '';
                            getContractDetails(invoiceDetails.contractID);

                            // Set default scheduled date to payment due date
                            if (invoiceDetails.payDate) {
                                const dueDate = new Date(invoiceDetails.payDate);
                                document.getElementById('scheduledDate').value = formatDateTimeLocal(dueDate);
                            }
                        } else {
                            alert("Failed to load invoice details");
                            window.location.href = "invoice.jsp";
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error loading invoice:", error);
                        alert("Error loading invoice details");
                        window.location.href = "invoice.jsp";
                    }
                });
            }

            function getContractDetails(contractID) {
                $.ajax({
                    url: 'getContract?contractId=' + contractID,
                    method: 'GET',
                    success: function (contract) {
                        if (contract) {
                            // Get enterprise names from contract details
                            const fromEnterpriseId = contract.fromEnterpriseId;
                            const toEnterpriseId = contract.toEnterpriseId;

                            if (fromEnterpriseId) {
                                getEnterpriseName(fromEnterpriseId, 'fromEnterprise');
                            } else {
                                document.getElementById('fromEnterprise').textContent = 'N/A';
                            }

                            if (toEnterpriseId) {
                                getEnterpriseName(toEnterpriseId, 'toEnterprise');
                            } else {
                                document.getElementById('toEnterprise').textContent = 'N/A';
                            }
                        } else {
                            console.warn("Failed to load contract details for contract ID: " + contractID);
                            document.getElementById('fromEnterprise').textContent = 'N/A';
                            document.getElementById('toEnterprise').textContent = 'N/A';
                        }
                    },
                    error: function () {
                        console.error("Error loading contract details for contract ID: " + contractID);
                        document.getElementById('fromEnterprise').textContent = 'N/A';
                        document.getElementById('toEnterprise').textContent = 'N/A';
                    }
                });
            }

            // Helper function to get enterprise names if needed
            function getEnterpriseName(enterpriseID, elementId) {
                $.ajax({
                    url: 'getEnterprise?id=' + enterpriseID,
                    method: 'GET',
                    success: function (data) {
                        if (data && data.enterpriseName) {
                            document.getElementById(elementId).textContent = data.enterpriseName;
                        } else {
                            document.getElementById(elementId).textContent = enterpriseID;
                        }
                    },
                    error: function () {
                        document.getElementById(elementId).textContent = enterpriseID;
                    }
                });
            }

            function searchPayments() {
                const fromAddress = document.getElementById('fromAddress').value;
                const toAddress = document.getElementById('toAddress').value;
                // Validate inputs
                if (!fromAddress || !web3.utils.isAddress(fromAddress)) {
                    alert("Invalid from address. Please connect your wallet first.");
                    return;
                }

                userAddress = fromAddress;

                // Load scheduled payments
                loadScheduledPayments();
            }

            function loadScheduledPayments() {
                if (!userAddress) return;

                $.ajax({
                    url: 'getScheduledTransfers?address=' + userAddress,
                    method: 'GET',
                    success: function (data) {
                        let tableHtml = '';

                        if (data && data.success && data.transfers && data.transfers.length > 0) {
                            tableHtml = "<table class=\"table table-striped\">" +
                                "<thead>" +
                                "<tr>" +
                                "<th>To Address</th>" +
                                "<th>Amount</th>" +
                                "<th>Scheduled Date</th>" +
                                "<th>Status</th>" +
                                "<th>Actions</th>" +
                                "</tr>" +
                                "</thead>" +
                                "<tbody>";

                            data.transfers.forEach(function (transfer) {
                                let statusClass = '';
                                let statusIcon = '';

                                switch (transfer.status) {
                                    case 'COMPLETED':
                                        statusClass = 'status-completed';
                                        statusIcon = 'fa-check-circle';
                                        break;
                                    case 'FAILED':
                                        statusClass = 'status-failed';
                                        statusIcon = 'fa-times-circle';
                                        break;
                                    default:
                                        statusClass = 'status-pending';
                                        statusIcon = 'fa-clock';
                                        break;
                                }

                                tableHtml += "<tr>" +
                                    "<td>" + shortenAddress(transfer.toAddress) + "</td>" +
                                    "<td>" + transfer.amount + "</td>" +
                                    "<td>" + formatDateTime(transfer.scheduledTime) + "</td>" +
                                    "<td><span class=\"status-indicator " + statusClass + "\"></span> " +
                                    transfer.status + " <i class=\"fas " + statusIcon + " ml-1\"></i></td>" +
                                    "<td>" +
                                    "<a class=\"btn btn-primary btn-sm\" href=\"sendMoney.jsp?toAddress=" + transfer.toAddress + "&amount=" + transfer.amount + "&scheduledTime=" + transfer.scheduledTime + "\">" +
                                    "<i class=\"fas fa-paper-plane mr-1\"></i>Send</a>" +
                                    "</td>" +
                                    "</tr>";
                            });

                            tableHtml += "</tbody></table>";
                        } else {
                            tableHtml = '<div class="alert alert-info">No scheduled payments found</div>';
                        }

                        document.getElementById('scheduledPaymentsTable').innerHTML = tableHtml;
                    },
                    error: function (xhr, status, error) {
                        console.error("Error loading scheduled payments:", error);
                        document.getElementById('scheduledPaymentsTable').innerHTML =
                            '<div class="alert alert-danger">Failed to load scheduled payments</div>';
                    }
                });
            }



            // Submit form handler
            $('#schedulePaymentForm').submit(function (e) {
                e.preventDefault();

                const fromAddress = document.getElementById('fromAddress').value;
                const toAddress = document.getElementById('toAddress').value;
                const amount = document.getElementById('amount').value;
                const scheduledDate = document.getElementById('scheduledDate').value;

                // Validate inputs
                if (!fromAddress || !web3.utils.isAddress(fromAddress)) {
                    alert("Invalid from address. Please connect your wallet first.");
                    return;
                }

                if (!toAddress || !web3.utils.isAddress(toAddress)) {
                    alert("Invalid recipient address. Please check the address and try again.");
                    return;
                }

                if (!amount || isNaN(amount) || parseFloat(amount) <= 0) {
                    alert("Please enter a valid amount greater than 0.");
                    return;
                }

                if (!scheduledDate) {
                    alert("Please select a scheduled payment date.");
                    return;
                }

                const scheduledTime = new Date(scheduledDate).getTime();
                if (scheduledTime <= Date.now()) {
                    alert("Scheduled date must be in the future.");
                    return;
                }

                // Submit the data
                $.ajax({
                    url: 'scheduleTransfer',
                    method: 'POST',
                    data: {
                        fromAddress: fromAddress,
                        toAddress: toAddress,
                        amount: amount,
                        scheduledTime: scheduledDate,
                        invoiceId: invoiceDetails.invoiceID || ''
                    },
                    success: function (response) {
                        if (response && response.success) {
                            alert("Payment scheduled successfully!");
                            loadScheduledPayments();
                        } else {
                            alert("Failed to schedule payment: " + (response.message || "Unknown error"));
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error scheduling payment:", error);
                        alert("Error scheduling payment. Please try again later.");
                    }
                });
            });

            // Helper function to format date
            function formatDate(dateStr) {
                if (!dateStr) return '-';
                const date = new Date(dateStr);
                return date.toLocaleDateString();
            }

            // Helper function to format datetime
            function formatDateTime(dateStr) {
                if (!dateStr) return '-';
                const date = new Date(dateStr);
                return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            }

            // Format date for datetime-local input - FIXED VERSION with no template literals
            function formatDateTimeLocal(date) {
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                const hours = String(date.getHours()).padStart(2, '0');
                const minutes = String(date.getMinutes()).padStart(2, '0');

                return year + "-" + month + "-" + day + "T" + hours + ":" + minutes;
            }

            // Helper function to shorten blockchain address
            function shortenAddress(address) {
                if (!address) return '-';
                return address.substring(0, 6) + '...' + address.substring(address.length - 4);
            }

            // Initialize when document is ready
            $(document).ready(function () {
                loadInvoiceDetails();
                //connectWallet(); // Prevent auto-connect
            });


        </script>
    </body>

    </html>