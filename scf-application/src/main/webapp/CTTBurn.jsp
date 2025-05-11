<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CTT Burn- Supply Chain Finance</title>
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
                                  <!-- Loan menu -->
                        <div class="dropdown d-inline-block">
                            <a class="dropdown-toggle" href="#" role="button" id="loanDropdown" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                Loan
                            </a>
                            <div class="dropdown-menu" aria-labelledby="loanDropdown">
                                <a class="dropdown-item" href="CTTLoanSearch.jsp">Search Loan</a>
                                <a class="dropdown-item" href="issueLoan.jsp">Issue Loan</a>                             
                        
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
                    <h5 class="mb-0">CTT Burn Info</h5>
                </div>
                <input type="hidden" id="recordId" name="recordId">
                <div class="card-body">
                    <form id="CTTBurnInfoForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="fromAddress">From Address:</label>
                                    <input type="text" class="form-control" id="fromAddress" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="toAddress">To Address:</label>
                                    <input type="text" class="form-control" id="toAddress"
                                        value="0x0000000000000000000000000000000000000000" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="settlementAmount">CTT Amount:</label>
                                    <input type="number" step="0.000001" class="form-control" id="settlementAmount"
                                        required>
                                    <small class="form-text text-muted">The amount of tokens to burn.</small>
                                </div>
                                <div class="form-group">
                                    <label for="correspondpingTX">Correspondping TX:</label>
                                    <input type="text" class="form-control" id="correspondpingTX" required>
                                    <small class="form-text text-muted">Transaction details for the corresponding
                                        payment.</small>
                                </div>
                            </div>
                        </div>

                        <div class="form-group text-center mt-4">
                            <button type="button" class="btn btn-success btn-action" id="burnCTTBtn">
                                <i class="fas fa-calendar-check mr-3"></i>Burn
                            </button>
                            <a href="invoice.jsp" class="btn btn-secondary btn-action ml-4">
                                <i class="fas fa-arrow-left mr-3"></i>Back to Invoices
                            </a>
                        </div>
                        <!-- 在表单下方添加这个新的卡片 -->
                        <div class="card mt-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">Pending Transactions & Multi-Sig Actions</h5>
                            </div>
                            <!-- Pending Transactions Card -->
                            <div class="card-body">
                                <!-- Row 1: Search Multi Address and Display -->
                                <div class="form-row mb-3 align-items-center">
                                    <div class="col-md-4">
                                        <button type="button" id="SearchMultiSigAddressBtn"
                                            class="btn btn-primary btn-block">
                                            <i class="fas fa-search mr-1"></i> Search Multi Address
                                        </button>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" id="manualMultiSigAddress"
                                            placeholder="Search for Multi-Sig Address (0x...)" rea>
                                    </div>
                                </div>

                                <!-- Row 2: Load Transactions Button -->
                                <div class="form-row mb-3">
                                    <div class="col-12">
                                        <button type="button" id="loadTxsButton" class="btn btn-info btn-block">
                                            <i class="fas fa-sync-alt mr-1"></i> Load Pending Transactions
                                        </button>
                                    </div>
                                </div>

                                <!-- Row 3: Pending Transactions Display Area -->
                                <div id="pendingTransactions" class="mb-3"
                                    style="min-height: 100px; border: 1px solid #eee; padding: 10px; border-radius: 5px; background-color: #f8f9fa;">
                                    <!-- Transactions table will be loaded here by JavaScript -->
                                    <small class="text-muted">Click "Load Pending Transactions" to view.</small>
                                </div>


                            </div> <!-- End card-body -->
                        </div> <!-- End card -->

                </div>
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
         <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/web3@1.3.0/dist/web3.min.js"></script>

        <script>
            // Global variables
            window.web3 = undefined;
            window.userAddress = undefined;
            let invoiceDetails = {};
            let currentContractAddress = null;
            let multiSigContractAddress = null;

            // 添加在MULTI_SIG_ABI常量之前
            const TOKEN_ABI = [
                "function balanceOf(address owner) view returns (uint256)",
                "function decimals() view returns (uint8)",
                "function symbol() view returns (string)"
            ];


            const MULTI_SIG_ABI = [
                // 交易提交函数
                "function submitMintTransaction(address to, uint256 amount) returns (uint256)",
                "function submitBurnTransaction(address from, uint256 amount) returns (uint256)",
                "function submitRedeemTransaction(address from, uint256 amount) returns (uint256)",

                // 交易查询函数 - 修正为5个参数
                "function getTransaction(uint256 txIndex) view returns (address to, uint256 amount, uint8 txType, bool executed, uint256 numConfirmations)",
                "function getTransactionCount() view returns (uint256)",

                // 确认功能
                "function confirmTransaction(uint256 txIndex) returns (bool)",
                "function executeTransaction(uint256 txIndex) returns (bool)",
                "function getConfirmationCount(uint256 txIndex) view returns (uint256)",
                "function isTransactionConfirmedBy(uint256 txIndex, address signer) view returns (bool)",

                // 管理功能
                "function getRequiredConfirmations() view returns (uint256)",
                "function requiredConfirmations() view returns (uint256)",  // 增加这个函数，某些合约使用这个命名
                "function isSigner(address account) view returns (bool)",
                "function getSignerCount() view returns (uint256)",

                // 事件
                "event TransactionSubmitted(uint256 indexed txIndex, address indexed to, uint256 amount, uint8 txType)",
                //  "event TransactionSubmitted(uint256 indexed txIndex, address indexed creator, address to, uint256 amount, uint8 txType)",
                "event TransactionConfirmed(uint256 indexed txIndex, address indexed signer)",
                "event TransactionExecuted(uint256 indexed txIndex, address indexed executor)"
            ];

            function getParameterByName(name, url = window.location.href) {
                name = name.replace(/[\[\]]/g, '\\$&');
                var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, ' '));
            }

            $(document).ready(function () {

                const recordId = getParameterByName('recordId');
             //   document.getElementById('correspondpingTX').value="0x02a24ce162667280cd1ad24290be472862de0eb62eb11214f24cf382a0ecee8b" ;
              //  recordBurnOperation("400", "0x02a24ce162667280cd1ad24290be472862de0eb62eb11214f24cf382a00000");
                document.getElementById('recordId').value = recordId;
                if (recordId) {
                    fetchFinancingDetails(recordId);
                }

            });

            async function fetchFinancingDetails(recordId) {
                try {

                    const url = new URL('/getFinancingRecordById', window.location.origin); // Updated URL
                    const params = new URLSearchParams({ recordId: recordId });
                    url.search = params.toString();
                    const response = await fetch(url);

                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    const data = await response.json();

                    if (data.success) {
                        //console.log('Financing details:', data.record);
                        $('#settlementAmount').val(data.record.cttAmount);
                        $('#fromAddress').val(data.record.userAddress); // Updated to access fromAddress correctly
                        $('#toAddress').val(data.record.bankAddress); // Updated to access toAddress correctly
                        $('#acceptableDate').val(data.record.dueDate); // Updated to access dueDate correctly
                        $('#settlementAmount').val(data.record.settlementAmount); // Updated to access settlementAmount correctly

                    } else {
                        alert('Failed to fetch financing details');
                    }
                } catch (error) {
                    console.error('Error fetching financing details:', error);
                    alert('Error loading financing details');
                }
            }


            document.addEventListener('DOMContentLoaded', async () => {
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

                currentContractAddress = await getLatestScTransAddr();
                if (currentContractAddress) {
                    console.log("Initialized contract address:", currentContractAddress);
                } else {
                    console.error("Failed to initialize contract address");
                }

                document.getElementById('connectWalletBtn').addEventListener('click', connectMetaMask);
                document.getElementById('burnCTTBtn').addEventListener('click', burnCTT);


                multiSigContractAddress = await getMultiSigContractAddress();
                if (multiSigContractAddress) {
                    console.log("Initialized multi-sig contract address:", multiSigContractAddress);
                } else {
                    console.error("Failed to initialize multi-sig contract address");
                }
                SearchMultiSigAddressBtn
                document.getElementById('SearchMultiSigAddressBtn').addEventListener('click', SearchMultiSigAddress);
                document.getElementById('loadTxsButton').addEventListener('click', loadPendingTransactions);
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




            async function getMultiSigContractAddress() {
                try {
                    const response = await fetch('/api/contract/multisig-address');
                    const data = await response.json();
                    if (data.success) {
                        return data.scMultiAddress;
                    } else {
                        console.error("Error getting multi-sig contract address:", data.message);
                        return null;
                    }
                } catch (error) {
                    console.error("Failed to get multi-sig contract address:", error);
                    return null;
                }
            }

            function SearchMultiSigAddress() {
                document.getElementById('manualMultiSigAddress').value = multiSigContractAddress;
            }


            async function burnCTT() {
                const fromAddress = document.getElementById('fromAddress').value;
                const amountStr = document.getElementById('settlementAmount').value;
                const correspondpingTX = document.getElementById('correspondpingTX').value;
                const connectAddr = window.userAddress;

                document.getElementById('correspondpingTX').value

                // 验证输入
                if (!fromAddress) {
                    alert("Invalid from address. Please connect your wallet first.");
                    return;
                }
                if (connectAddr !== fromAddress) {
                    alert("Please connect your own address.");
                    return;
                }

                try {
                    const provider = new ethers.providers.Web3Provider(window.ethereum);
                    const signer = provider.getSigner();

                    // 检查当前用户是否是签名者
                    const multiSigContract = new ethers.Contract(multiSigContractAddress, MULTI_SIG_ABI, signer);
                    const isSignerResult = await multiSigContract.isSigner(connectAddr);
                    if (!isSignerResult) {
                        alert("Your address is not authorized to submit burn proposals. Only designated signers can submit proposals.");
                        return;
                    }

                    // 获取代币精度
                    const tokenContract = new ethers.Contract(currentContractAddress, TOKEN_ABI, signer);
                    const decimals = await tokenContract.decimals();

                    const amount = Number(amountStr);
                    if (isNaN(amount) || amount <= 0) {
                        alert("Invalid burn amount. Please enter a positive number.");
                        return;
                    }

                    // 将金额转换为代币最小单位
                    const amountInSmallestUnit = ethers.utils.parseUnits(amount.toString(), decimals);

                    // 确认弹窗
                    if (!confirm(`Are you sure you want to submit a proposal to burn ${amount} CTT tokens from ${fromAddress}? This will require multi-signature approval.`)) {
                        return;
                    }

                    // 提交销毁提案
                    console.log("Submitting burn proposal to multi-sig contract:", multiSigContractAddress);
                    console.log("From address:", fromAddress, "Amount:", amountInSmallestUnit.toString());

                    const feeData = await provider.getFeeData();
                    const increasedPriorityFee = feeData.maxPriorityFeePerGas ? feeData.maxPriorityFeePerGas.mul(150).div(100) : undefined;
                    const maxFee = feeData.maxFeePerGas;

                    const overrides = {
                        gasLimit: 800000, // Explicitly set a high limit (e.g., 800k, adjust if needed)
                        maxPriorityFeePerGas: increasedPriorityFee,
                        maxFeePerGas: maxFee
                    };

                    const tx = await multiSigContract.submitBurnTransaction(
                        fromAddress,
                        amountInSmallestUnit,
                        overrides
                    );
                    console.log("Proposal transaction sent:", tx.hash);

                    // 显示交易信息
                    alert(`Burn proposal submitted! Transaction hash: ${tx.hash}\n\nPlease wait for other signers to confirm the proposal.`);

                    // 等待交易确认
                    const receipt = await tx.wait();
                    console.log("Proposal transaction confirmed:", receipt);

                    // 从交易日志中提取提案ID (如果可能)
                    let txIndex = null;
                    if (receipt && receipt.events) {
                        for (let event of receipt.events) {
                            if (event.event === "TransactionSubmitted") {
                                txIndex = event.args.txIndex.toString();
                                break;
                            }
                        }
                    }

                    if (txIndex !== null) {
                        // 记录提案到数据库
                        console.log(amountStr + ":::", tx.hash);


                        await recordBurnOperation(amountStr, tx.hash);

                        // 先获取所需确认数
                        const requiredConfirmations = await multiSigContract.getRequiredConfirmations();

                        // 显示提案ID (分离 await 操作)
                        alert(`Burn proposal #${txIndex} has been created successfully. Required signatures: ${requiredConfirmations}`);


                    }

                } catch (error) {
                    console.error("Error submitting burn proposal:", error);
                    alert("Failed to submit burn proposal: " + error.message);
                }


            }

            async function recordBurnOperation(amountStr, txHash) {
                const correspondpingTX = document.getElementById('correspondpingTX').value;

                if (!correspondpingTX || correspondpingTX.trim() === '') {
                    console.error("Cannot record burn operation: 'Correspondping TX' field is empty.");
                    return; 
                }

                try {

                    const searchUrl = new URL('/searchCTTBurnRecord', window.location.origin);
                    searchUrl.searchParams.append('correspondpingTX', correspondpingTX); // Use the input value for search

                    console.log("Searching for existing burn record with correspondpingTX:" + correspondpingTX);
                    const searchResponse = await fetch(searchUrl);
                    const searchData = await searchResponse.json();

                    if (searchResponse.ok && searchData.success && searchData.record) {

                        const burnID = searchData.record.burnID;console.log("Found existing record with burnID: " + burnID + ". Updating...");

                        const updateResponse = await fetch('/updateCTTBurnRecord', {
                            method: 'PUT', 
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                burnID: burnID,
                                execTX: txHash,
                                operationDate: new Date().toISOString().split('T')[0]
                            })
                        });

                        const updateData = await updateResponse.json();
                        if (updateData.success) {
                            console.log(`Burn record (ID: ${burnID}) updated successfully with proposal hash.`);
                        } else {
                            console.error(`Failed to update burn record (ID: ${burnID}):`, updateData.message);
                        }

                    } else {

                        const response = await fetch('/createCTTBurnRecord', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                amount: amountStr,
                                correspondpingTX: correspondpingTX,
                                txHash: txHash,
                                operationDate: new Date().toISOString().split('T')[0]  
                            })
                        });

                        const data = await response.json();
                        if (data.success) {
                            console.log("Burn operation recorded successfully");
                        } else {
                            console.error("Failed to record burn operation:", data.message);
                        }
                    }
                } catch (error) {
                    console.error("Error recording burn operation:", error);
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
                window.userAddress = address;
                document.getElementById('fromAddress').value = address; // Fixed the ID here


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
                    "function decimals() view returns (uint8)"
                ];
                const tokenContract = new ethers.Contract(tokenAddress, tokenABI, provider);
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

            async function loadPendingTransactions() {
                console.log("Loading pending transactions...");
                showStatus("Loading pending transactions...");

                // 检查钱包连接
                if (!window.ethereum) {
                    console.error("No wallet provider available");
                    showStatus("Wallet not connected. Please connect wallet first.", true);
                    return;
                }

                // 获取多签合约地址
                const multiSigAddr = document.getElementById('manualMultiSigAddress').value;
                console.log("Multi-sig contract address:", multiSigAddr);

                if (!multiSigAddr || multiSigAddr.trim() === '') {
                    showStatus("Multi-signature contract address not found. Please search for a contract first.", true);
                    return;
                }

                try {


                    showStatus("Connecting to multi-signature contract...");
                    const provider = new ethers.providers.Web3Provider(window.ethereum);
                    const multiSigContract = new ethers.Contract(multiSigAddr, MULTI_SIG_ABI, provider);

                    // 获取交易数量
                    showStatus("Fetching transaction count...");
                    const txCount = await multiSigContract.getTransactionCount();
                    console.log("Transaction count:", txCount.toString());

                    const requiredConfirmations = await multiSigContract.requiredConfirmations();
                    console.log("Required confirmations:", requiredConfirmations.toString());

                    const pendingTxDiv = document.getElementById('pendingTransactions');
                    pendingTxDiv.innerHTML = '';

                    // 如果没有交易，显示提示信息
                    if (txCount.eq(0)) {
                        pendingTxDiv.innerHTML = '<div class="alert alert-info">No transactions found</div>';
                        showStatus("No transactions found on this contract");
                        return;
                    }

                    // 创建表格
                    showStatus("Loading transaction details...");
                    const table = document.createElement('table');
                    table.className = 'table table-striped';
                    table.innerHTML = `
            <thead>
                <tr>
                    <th>Index</th>
                    <th>Recipient</th>
                    <th>Amount</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Confirmations</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="txTableBody"></tbody>
        `;
                    pendingTxDiv.appendChild(table);
                    const tableBody = document.getElementById('txTableBody');

                    let pendingCount = 0;
                    const tokenContract = new ethers.Contract(currentContractAddress, TOKEN_ABI, provider);
                    const decimals = await tokenContract.decimals();
                    const userAddress = await provider.getSigner().getAddress();

                    // 循环获取每个交易的详细信息
                    for (let i = 0; i < txCount.toNumber(); i++) {
                        showStatus(`Loading transaction ${i + 1} of ${txCount}...`);

                        try {
                            const tx = await multiSigContract.getTransaction(i);
                            // console.log(`Transaction ${i} details:`, tx);

                            // 跳过已执行的交易
                            if (tx.executed) continue;

                            pendingCount++;
                            const row = document.createElement('tr');

                            // 交易类型转换
                            let typeText;
                            switch (tx.txType) {
                                case 0: typeText = "Mint"; break;
                                case 1: typeText = "Burn"; break;
                                case 2: typeText = "Redeem"; break;
                                default: typeText = "Unknown";
                            }

                            // 格式化金额
                            const amountFormatted = ethers.utils.formatUnits(tx.amount, decimals);


                            let isConfirmed = false;
                            try {
                                // Log before checking signer status
                                console.log(`[Tx ${i}] Checking signer status for user ${userAddress}...`);
                                const isSigner = await multiSigContract.isSigner(userAddress);
                                // Log the result of the signer check
                                console.log(`[Tx ${i}] Is user ${userAddress} a signer? ${isSigner}`);

                                if (isSigner) {
                                    //         console.log(`[Tx ${i}] User is signer. Attempting isConfirmedByAddress(${i}, ${userAddress})...`);
                                    // Call the function
                                    isConfirmed = await multiSigContract.isTransactionConfirmedBy(i, userAddress);
                                    // Log the result if successful
                                    //console.log(`[Tx ${i}] Confirmation status checked successfully: ${isConfirmed}`);
                                } else {
                                    console.log(`[Tx ${i}] User ${userAddress} is not a signer, skipping confirmation check.`);
                                    isConfirmed = false; // Explicitly set to false
                                }
                            } catch (confirmError) {

                                console.error(`[Tx ${i}] Error calling isConfirmedByAddress(${i}, ${userAddress}):`, confirmError);
                                isConfirmed = false;
                            }


                            // 创建操作按钮
                            let actionButton = '';
                            if (!tx.executed && !isConfirmed) {
                                const buttonId = 'confirmBtn-' + i;
                                actionButton = '<button type="button" class="btn btn-sm btn-primary" onclick="confirmSpecificTx(' + i + ')">Confirm</button>';
                            } else if (!tx.executed && isConfirmed) {
                                actionButton = `<span class="badge badge-success">Confirmed</span>`;
                            } else {
                                actionButton = `<span class="badge badge-secondary">Executed</span>`;
                            }

                            row.innerHTML =
                                "<td>" + i + "</td>" +
                                "<td>" + shortenAddress(tx.to) + "</td>" +
                                "<td>" + amountFormatted + " CTT</td>" +
                                "<td>" + typeText + "</td>" +
                                "<td>" + (tx.executed ? '<span class="badge badge-success">Executed</span>' : '<span class="badge badge-warning">Pending</span>') + "</td>" +
                                "<td>" + tx.numConfirmations + "/" + requiredConfirmations + "</td>" +
                                "<td>" + actionButton + "</td>";

                            tableBody.appendChild(row);
                        } catch (txError) {
                            console.error(`Error fetching transaction ${i}:`, txError);
                            // 继续处理下一笔交易
                        }
                    }

                    if (pendingCount === 0) {
                        pendingTxDiv.innerHTML = '<div class="alert alert-info">No pending transactions found</div>';
                    }

                    showStatus(`Loaded ${pendingCount} pending transactions successfully`);

                } catch (error) {
                    console.error("Error loading transactions:", error);
                    showStatus("Failed to load transactions: " + (error.message || "Unknown error"), true);
                }
            }

            // 为表格中的确认按钮添加功能
            async function confirmSpecificTx(txIndex) {

                const buttonId = `confirmBtn-${txIndex}`; // ID format
                const confirmButton = document.getElementById(buttonId); // Tries to find button by ID

                try {
                    // Disable button immediately
                    if (confirmButton) { // Only runs if button is found
                        confirmButton.disabled = true;
                        confirmButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Confirming...';
                    } else {
                        // Add a log if the button wasn't found - this helps debugging
                        console.warn(`Button with ID ${buttonId} not found for disabling.`);
                    }

                    const provider = new ethers.providers.Web3Provider(window.ethereum);
                    const signer = provider.getSigner();
                    const multiSigAddr = document.getElementById('manualMultiSigAddress').value;
                    const multiSigContract = new ethers.Contract(multiSigAddr, MULTI_SIG_ABI, signer);

                    // 确认提案
                    showStatus("Confirming transaction #" + txIndex + "...");
                    // console.log("Calling confirmTransaction with txIndex: " + txIndex + " (Type: " + typeof txIndex + ")");
                    const tx = await multiSigContract.confirmTransaction(txIndex);
                    // console.log("Confirmation transaction sent:", tx.hash);

                    // 等待交易确认
                    showStatus("Waiting for confirmation of transaction #" + txIndex + "...");
                    await tx.wait();
                    showStatus("Successfully confirmed transaction #" + txIndex + "...");

                    // 重新加载交易列表
                    await loadPendingTransactions();

                } catch (error) {
                    console.error("Error confirming transaction:", error);
                    showStatus("Failed to confirm transaction: " + (error.message || "Unknown error"), true);
                }
            }


        </script>
    </body>

    </html>