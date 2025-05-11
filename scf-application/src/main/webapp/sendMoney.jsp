<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Send CTT - Supply Chain Finance</title>
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

            /* Custom styles */
            .horizontal-balance {
                display: flex;
                align-items: center;
            }

            .horizontal-balance>label {
                margin-right: 5px;
            }

            .horizontal-balance>input {
                width: 100px;
                margin-right: 5px;
            }

            .horizontal-balance>button {
                margin-right: 5px;
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
                        <div class="form-group horizontal-balance">
                            <label for="tokenBalance">CTT Balance:</label>
                            <input type="text" class="form-control" id="tokenBalance" readonly>
                            <button type="button" class="btn btn-success btn-action" onclick="showTokenBalance()">Query
                                CTT</button>

                        </div>
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
                                    <label for="fromAddress">From Address:</label>
                                    <input type="text" class="form-control" id="fromAddress" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="toAddress">To Address:</label>
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
                            <button type="button" class="btn btn-success btn-action" id="sendMoneyBtn">
                                <i class="fas fa-calendar-check mr-3"></i>Send
                            </button>
                            <a href="invoice.jsp" class="btn btn-secondary btn-action ml-4">
                                <i class="fas fa-arrow-left mr-3"></i>Back to Invoices
                            </a>
                        </div>
                    </form>
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

            // ABI
            const TOKEN_ABI = [
                {
                    "inputs": [
                        { "internalType": "address", "name": "to", "type": "address" },
                        { "internalType": "uint256", "name": "amount", "type": "uint256" }
                    ],
                    "name": "transfer",
                    "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }],
                    "stateMutability": "nonpayable",
                    "type": "function"
                },
                {
                    "inputs": [
                        { "internalType": "address", "name": "owner", "type": "address" }
                    ],
                    "name": "balanceOf",
                    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [],
                    "name": "decimals",
                    "outputs": [{ "internalType": "uint8", "name": "", "type": "uint8" }],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [],
                    "name": "expirationDate",
                    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
                    "stateMutability": "view",
                    "type": "function"
                }
            ];

            $(document).ready(function () {
                // Function to extract parameters from the URL
                function getParameterByName(name, url = window.location.href) {
                    name = name.replace(/[\[\]]/g, '\\$&');
                    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                        results = regex.exec(url);
                    if (!results) return null;
                    if (!results[2]) return '';
                    return decodeURIComponent(results[2].replace(/\+/g, ' '));
                }

                // Get parameters from the URL
                var toAddress = getParameterByName('toAddress');
                var amount = getParameterByName('amount');
                var scheduledTime = getParameterByName('scheduledTime');



                // Fill the form fields with the extracted values
                if (toAddress) {
                    $('#toAddress').val(toAddress);
                }
                if (amount) {
                    $('#amount').val(amount);
                }
                if (scheduledTime) {
                    $('#scheduledDate').val(scheduledTime);
                }
            });

            document.addEventListener('DOMContentLoaded', async () => {
                currentContractAddress = await getLatestScTransAddr();
                console.log("Current contract address:", currentContractAddress);
                if (currentContractAddress) {
                    console.log("Initialized contract address:", currentContractAddress);
                } else {
                    console.error("Failed to initialize contract address");
                }

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
                document.getElementById('sendMoneyBtn').addEventListener('click', sendMoney); // Updated to call sendMoney function
            });

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

            async function sendMoney() {
                const fromAddress = window.userAddress;
                const toAddress = document.getElementById('toAddress').value;
                const amount = document.getElementById('amount').value;

                // Validate inputs
                if (!fromAddress) {
                    alert("Invalid from address. Please connect your wallet first.");
                    return;
                }
                if (!toAddress) {
                    alert("Invalid to address.");
                    return;
                }
                if (!amount || isNaN(amount) || parseFloat(amount) <= 0) {
                    alert("Invalid amount.");
                    return;
                }

                try {
                    const tokenAddress = currentContractAddress; // 使用与showTokenBalance相同的地址
                    if (!tokenAddress) {
                        alert("Contract address not available. Please try again later.");
                        return;
                    }
                    const provider = new ethers.providers.Web3Provider(window.ethereum);
                    const signer = provider.getSigner();

                    const tokenContract = new ethers.Contract(tokenAddress, TOKEN_ABI, signer);

                    // 获取代币精度
                    const decimals = await tokenContract.decimals();
                    console.log("Token decimals:", decimals);

                    // 将金额转换为代币最小单位
                    const amountInSmallestUnit = ethers.utils.parseUnits(amount.toString(), decimals);
                    console.log("Amount in smallest unit:", amountInSmallestUnit.toString());

                    // 发送交易
                    const tx = await tokenContract.transfer(toAddress, amountInSmallestUnit);
                    console.log("Transaction sent:", tx.hash);
                    alert(`Transaction sent! Hash: ${tx.hash}`);

                    // 等待交易确认
                    await tx.wait();
                    console.log("Transaction confirmed!");

                    // 刷新余额
                    showTokenBalance();
                } catch (error) {
                    console.error("Error sending transaction:", error);
                    if (error.data && error.data.message) {
                        alert("Transaction failed: " + error.data.message);
                    } else if (error.reason) {
                        alert("Transaction failed: " + error.reason);
                    } else {
                        alert("Transaction failed: " + error.message);
                    }
                }
            }


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
                const tokenAddress = currentContractAddress; // 替换为实际代币地址
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
                    "function decimals() view returns (uint8)",
                    "function expirationDate() view returns (uint256)"
                ];
                const tokenContract = new ethers.Contract(tokenAddress, tokenABI, provider);
                const expiry = await tokenContract.expirationDate();
                console.log("Token expirationDate:", expiry, "当前时间:", Math.floor(Date.now() / 1000));
                const rawBalance = await tokenContract.balanceOf(userAddress);
                const decimals = await tokenContract.decimals();
                const formattedBalance = parseFloat(ethers.utils.formatUnits(rawBalance, decimals)).toFixed(4);
                console.log("CTT Balance: ", formattedBalance);
                document.getElementById('tokenBalance').value = formattedBalance; // Changed from value to innerText
            }

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



            // Helper function to shorten blockchain address
            function shortenAddress(address) {
                if (!address) return '-';
                return address.substring(0, 6) + '...' + address.substring(address.length - 4);
            }




        </script>
    </body>

    </html>