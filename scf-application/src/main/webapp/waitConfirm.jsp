<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>TGE - Token Generation Event</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
        <!-- 添加 Web3.js -->
        <script src="https://cdn.jsdelivr.net/npm/web3@1.8.0/dist/web3.min.js"></script>
        <style>
            /* Basic page styling */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fa;
            }

            .container {
                margin-top: 30px;
            }

            /* Card styling */
            .card {
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .card-header {
                font-weight: bold;
                background-color: #007bff;
                color: white;
            }

            .btn-generate {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }

            .btn-generate:hover {
                background-color: #0056b3;
            }

            /* Status message styling */
            #status {
                padding: 15px;
                margin: 15px 0;
                border-radius: 5px;
                display: none;
            }

            .status-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .status-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .wallet-section {
                margin-bottom: 20px;
            }

            /* Contract address display styling */
            #contractAddressDisplay {
                color: #dc3545;
                font-weight: bold;
            }

            /* ------ Header and Menu Styling (from index.jsp) ------ */
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
                position: relative;
            }

            /* Footer styling */
            .footer {
                text-align: center;
                margin-top: 50px;
                font-size: 14px;
                color: #aaa;
            }

            /* Dropdown menu styling */
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

            .dropdown-menu.show {
                display: block !important;
            }

            .dropdown-menu {
                z-index: 1050 !important;
            }

            /* User status styling */
            .user-status {
                position: absolute;
                top: 15px;
                right: 20px;
                font-size: 16px;
            }

            .user-status .dropdown-toggle {
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
            }

            .user-status .dropdown-toggle:hover {
                text-decoration: underline;
            }

            .user-status .fas {
                font-size: 18px;
                margin-right: 5px;
            }

            .login-register a:hover {
                text-decoration: underline;
            }

            /* Nav menu styling - ensuring proper display */
            .navbar {
                padding: 0;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .navbar-nav .nav-link {
                padding: 1rem;
            }

            .navbar-nav .dropdown-menu {
                margin-top: 0;
                border-radius: 0;
                border-top: none;
            }

            /* Responsive header */
            @media (max-width: 768px) {
                .header h1 {
                    font-size: 1.5rem;
                }

                .menu a {
                    font-size: 16px;
                    margin: 0 10px;
                }

                .user-status {
                    position: relative;
                    top: 0;
                    right: 0;
                    margin-top: 10px;
                    text-align: center;
                }
            }
        </style>
    </head>

    <body>
        <!-- 直接硬编码页头，而不是使用include -->
        <div class="header">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="mb-0">Supply Chain Finance Platform</h1>

                <!-- User Status - 显示在右上角 -->
                <div class="user-status">
                    <% if(session !=null && session.getAttribute("isLoggedIn") !=null &&
                        (Boolean)session.getAttribute("isLoggedIn")) { String
                        username=(String)session.getAttribute("username"); %>
                        <div class="dropdown">
                            <a class="dropdown-toggle text-white" href="#" role="button" id="userStatusDropdown"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-user-circle mr-1"></i>
                                <%= username %>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userStatusDropdown">
                                <a class="dropdown-item" href="profile.jsp"><i
                                        class="fas fa-id-card mr-2"></i>Profile</a>
                                <a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog mr-2"></i>Settings</a>
                                <a class="dropdown-item" href="myWallet.jsp"><i class="fas fa-wallet mr-2"></i>My
                                    Wallet</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="logout"><i
                                        class="fas fa-sign-out-alt mr-2"></i>Logout</a>
                            </div>
                        </div>
                        <% } else { %>
                            <div class="login-register">
                                <a href="login.jsp" class="text-white mr-3"><i class="fas fa-sign-in-alt mr-1"></i>
                                    Login</a>
                                <a href="register.jsp" class="text-white"><i class="fas fa-user-plus mr-1"></i>
                                    Register</a>
                            </div>
                            <% } %>
                </div>
            </div>

            <div class="menu">
                <a href="index.jsp">Home</a>

                <!-- User dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        User
                    </a>
                    <div class="dropdown-menu" aria-labelledby="userDropdown">
                        <% if(session !=null && session.getAttribute("isLoggedIn") !=null &&
                            (Boolean)session.getAttribute("isLoggedIn")) { %>
                            <a class="dropdown-item" href="profile.jsp">My Profile</a>
                            <a class="dropdown-item" href="settings.jsp">Account Settings</a>
                            <% } else { %>
                                <a class="dropdown-item" href="login.jsp">Login</a>
                                <a class="dropdown-item" href="register.jsp">Register</a>
                                <% } %>
                    </div>
                </div>

                <!-- Enterprise dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Enterprise
                    </a>
                    <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                        <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                        <a class="dropdown-item" href="singleEnterprise.jsp?mode=add">Add New Enterprise</a>
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

                <!-- CTT menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="cttDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        CTT
                    </a>
                    <div class="dropdown-menu" aria-labelledby="cttDropdown">
                        <a class="dropdown-item" href="signSC.jsp">Sign SC</a>
                        <a class="dropdown-item" href="TGE.jsp">TGE</a>
                        <a class="dropdown-item" href="CTTinfo.jsp">Detail</a>
                    </div>
                </div>

            </div>
        </div>

        <div class="container">
            <div class="card wallet-section">
                <div class="card-header">
                    <i class="fas fa-wallet mr-2"></i> Wallet Connection
                </div>
                <div class="card-body">
                    <div class="connected-account-info mb-3 p-2 border rounded bg-light">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <span id="connectionStatus" class="badge badge-warning mr-2">Not Connected</span>
                                <span id="connectedWallet" class="text-primary">No account detected</span>
                            </div>
                            <button type="button" id="connectWalletBtn" class="btn btn-primary btn-sm"
                                onclick="connectMetaMask()">
                                <i class="fas fa-plug mr-1"></i> Connect Wallet
                            </button>
                        </div>
                    </div>
                    <div class="wallet-info">
                        <div class="mb-1"><strong>Address:</strong> <span id="walletAddress">Not connected</span></div>
                        <div class="mb-2"><strong>Balance:</strong> <span id="walletBalance">0 POL</span></div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-info-circle mr-2"></i> Limit Information
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <p><strong>Bank Name:</strong> ABC Bank</p>
                        </div>
                        <div class="col-md-4">
                            <p><strong>Limit:</strong> $1,000,000</p>
                        </div>
                        <div class="col-md-4">
                            <p><strong>Invalid Date:</strong> Dec 31, 2027</p>
                        </div>
                    </div>
                </div>
            </div>


            <div class="card">
                <div class="card-header">
                    <i class="fas fa-edit mr-2"></i> Generate Token
                </div>
                <div class="card-body">
                    <form id="mintForm">
                        <div class="form-group">
                            <label for="recipientAddress">Recipient Address:</label>
                            <input type="text" class="form-control" id="recipientAddress" name="recipientAddress"
                                placeholder="Enter Ethereum Address (0x...)" required readonly>

                            <label for="contractAddressDisplay"><strong>SCTrans Address:</strong></label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="contractAddressDisplay" readonly>
                            </div>
                            <label for="connScMultiAddress"><strong>SCMulti Address:</strong></label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="connScMultiAddress" readonly>
                            </div>
                        </div>


                        <!-- Token Name and Symbol on the same row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="tokenName">Token Name:</label>
                                <input type="text" class="form-control" id="tokenName" name="tokenName"
                                    placeholder="Enter Token Name" required readonly>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="tokenSymbol">Token Symbol:</label>
                                <input type="text" class="form-control" id="tokenSymbol" name="tokenSymbol"
                                    placeholder="Symbol (e.g. CTT)" required readonly>
                            </div>
                        </div>
                        <input type="hidden" id="tokenID" name="tokenID">
                        <!-- Amount and Invalid Date on the same row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="invalidDate">Invalid Date:</label>
                                <input type="date" class="form-control" id="invalidDate" name="invalidDate" readonly>
                            </div>
                            <div class="form-group col-md-6" id="creationTimeContainer" style="display:none">
                                <label for="creationTime">Creation Time:</label>
                                <input type="text" class="form-control" id="creationTime" name="creationTime" readonly>
                            </div>

                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="amount">Token Amount: <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="amount" name="amount"
                                    placeholder="Enter Token Amount" readonly>
                            </div>
                        </div>

                        <!-- Two buttons side by side -->
                        <div class="form-row justify-content-center">
                            <div class="col-md-4">
                                <button type="button" id="searchSCTransButton" class="btn btn-info btn-block">
                                    <i class="fas fa-search mr-1"></i> Search Latest SC
                                </button>
                            </div>
                           
                        </div>
                    </form>
                </div>
            </div>
            <!-- Pending Transactions Card -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fas fa-list-alt mr-2"></i> Pending Transactions & Multi-Sig Actions
                </div>
                <div class="card-body">
                    <!-- Row 1: Search Multi Address and Display -->
                    <div class="form-row mb-3 align-items-center">
                        <div class="col-md-4">
                            <button type="button" id="SearchMultiSigAddressBtn" class="btn btn-primary btn-block">
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
                            <button id="loadTxsButton" class="btn btn-info btn-block">
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

                    <!-- Row 4: Transaction Actions -->
                    <div class="form-row align-items-end">
                        <div class="form-group col-md-4">
                            <label for="txIndexInput">Transaction Index:</label>
                            <input type="number" class="form-control" id="txIndexInput" placeholder="Enter Index #">
                        </div>
                        <div class="form-group col-md-8">
                            <label>&nbsp;</label> <!-- Spacer label for alignment -->
                            <div class="d-flex">
                                <button id="confirmTxButton" class="btn btn-success flex-grow-1 mr-2">
                                    <i class="fas fa-check mr-1"></i> Confirm Tx
                                </button>

                            </div>
                        </div>
                    </div>
                </div> <!-- End card-body -->
            </div> <!-- End card -->

            <!-- 引入脚本 -->
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

            <!-- 改为内联定义 -->
            <script>
                const customTokenTransferABI = [
                    {
                        "inputs": [
                            {
                                "internalType": "string",
                                "name": "name",
                                "type": "string"
                            },
                            {
                                "internalType": "string",
                                "name": "symbol",
                                "type": "string"
                            },
                            {
                                "internalType": "uint256",
                                "name": "_expirationDate",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "constructor"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "spender",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "allowance",
                                "type": "uint256"
                            },
                            {
                                "internalType": "uint256",
                                "name": "needed",
                                "type": "uint256"
                            }
                        ],
                        "name": "ERC20InsufficientAllowance",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "sender",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "balance",
                                "type": "uint256"
                            },
                            {
                                "internalType": "uint256",
                                "name": "needed",
                                "type": "uint256"
                            }
                        ],
                        "name": "ERC20InsufficientBalance",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "approver",
                                "type": "address"
                            }
                        ],
                        "name": "ERC20InvalidApprover",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "receiver",
                                "type": "address"
                            }
                        ],
                        "name": "ERC20InvalidReceiver",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "sender",
                                "type": "address"
                            }
                        ],
                        "name": "ERC20InvalidSender",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "spender",
                                "type": "address"
                            }
                        ],
                        "name": "ERC20InvalidSpender",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "owner",
                                "type": "address"
                            }
                        ],
                        "name": "OwnableInvalidOwner",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "account",
                                "type": "address"
                            }
                        ],
                        "name": "OwnableUnauthorizedAccount",
                        "type": "error"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "owner",
                                "type": "address"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "spender",
                                "type": "address"
                            },
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "value",
                                "type": "uint256"
                            }
                        ],
                        "name": "Approval",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "oldMultiSigAddress",
                                "type": "address"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "newMultiSigAddress",
                                "type": "address"
                            }
                        ],
                        "name": "MultiSigContractSet",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "previousOwner",
                                "type": "address"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "newOwner",
                                "type": "address"
                            }
                        ],
                        "name": "OwnershipTransferred",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "from",
                                "type": "address"
                            },
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "TokensBurned",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "TokensMinted",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "from",
                                "type": "address"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "value",
                                "type": "uint256"
                            }
                        ],
                        "name": "Transfer",
                        "type": "event"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "owner",
                                "type": "address"
                            },
                            {
                                "internalType": "address",
                                "name": "spender",
                                "type": "address"
                            }
                        ],
                        "name": "allowance",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "spender",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "value",
                                "type": "uint256"
                            }
                        ],
                        "name": "approve",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "account",
                                "type": "address"
                            }
                        ],
                        "name": "balanceOf",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "from",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "burnByMultiSig",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "decimals",
                        "outputs": [
                            {
                                "internalType": "uint8",
                                "name": "",
                                "type": "uint8"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "expirationDate",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "getExpirationStatus",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "expiryTime",
                                "type": "uint256"
                            },
                            {
                                "internalType": "bool",
                                "name": "isExpired",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "mintByMultiSig",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "multiSigContract",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "name",
                        "outputs": [
                            {
                                "internalType": "string",
                                "name": "",
                                "type": "string"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "owner",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "renounceOwnership",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "_multiSigContract",
                                "type": "address"
                            }
                        ],
                        "name": "setMultiSigContract",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "symbol",
                        "outputs": [
                            {
                                "internalType": "string",
                                "name": "",
                                "type": "string"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "totalSupply",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "transfer",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "from",
                                "type": "address"
                            },
                            {
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "transferFrom",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "newOwner",
                                "type": "address"
                            }
                        ],
                        "name": "transferOwnership",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    }
                ]

                const customTokenTransferBytecode = "608060405234801561000f575f80fd5b506040516126da3803806126da8339818101604052810190610031919061036a565b338383816003908161004391906105f6565b50806004908161005391906105f6565b5050505f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036100c6575f6040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081526004016100bd9190610704565b60405180910390fd5b6100d58161012760201b60201c565b50428111610118576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161010f9061079d565b60405180910390fd5b806006819055505050506107bb565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160055f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f604051905090565b5f80fd5b5f80fd5b5f80fd5b5f80fd5b5f601f19601f8301169050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b61024982610203565b810181811067ffffffffffffffff8211171561026857610267610213565b5b80604052505050565b5f61027a6101ea565b90506102868282610240565b919050565b5f67ffffffffffffffff8211156102a5576102a4610213565b5b6102ae82610203565b9050602081019050919050565b8281835e5f83830152505050565b5f6102db6102d68461028b565b610271565b9050828152602081018484840111156102f7576102f66101ff565b5b6103028482856102bb565b509392505050565b5f82601f83011261031e5761031d6101fb565b5b815161032e8482602086016102c9565b91505092915050565b5f819050919050565b61034981610337565b8114610353575f80fd5b50565b5f8151905061036481610340565b92915050565b5f805f60608486031215610381576103806101f3565b5b5f84015167ffffffffffffffff81111561039e5761039d6101f7565b5b6103aa8682870161030a565b935050602084015167ffffffffffffffff8111156103cb576103ca6101f7565b5b6103d78682870161030a565b92505060406103e886828701610356565b9150509250925092565b5f81519050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f600282049050600182168061044057607f821691505b602082108103610453576104526103fc565b5b50919050565b5f819050815f5260205f209050919050565b5f6020601f8301049050919050565b5f82821b905092915050565b5f600883026104b57fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8261047a565b6104bf868361047a565b95508019841693508086168417925050509392505050565b5f819050919050565b5f6104fa6104f56104f084610337565b6104d7565b610337565b9050919050565b5f819050919050565b610513836104e0565b61052761051f82610501565b848454610486565b825550505050565b5f90565b61053b61052f565b61054681848461050a565b505050565b5b818110156105695761055e5f82610533565b60018101905061054c565b5050565b601f8211156105ae5761057f81610459565b6105888461046b565b81016020851015610597578190505b6105ab6105a38561046b565b83018261054b565b50505b505050565b5f82821c905092915050565b5f6105ce5f19846008026105b3565b1980831691505092915050565b5f6105e683836105bf565b9150826002028217905092915050565b6105ff826103f2565b67ffffffffffffffff81111561061857610617610213565b5b6106228254610429565b61062d82828561056d565b5f60209050601f83116001811461065e575f841561064c578287015190505b61065685826105db565b8655506106bd565b601f19841661066c86610459565b5f5b828110156106935784890151825560018201915060208501945060208101905061066e565b868310156106b057848901516106ac601f8916826105bf565b8355505b6001600288020188555050505b505050505050565b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f6106ee826106c5565b9050919050565b6106fe816106e4565b82525050565b5f6020820190506107175f8301846106f5565b92915050565b5f82825260208201905092915050565b7f45787069726174696f6e2064617465206d75737420626520696e2074686520665f8201527f7574757265000000000000000000000000000000000000000000000000000000602082015250565b5f61078760258361071d565b91506107928261072d565b604082019050919050565b5f6020820190508181035f8301526107b48161077b565b9050919050565b611f12806107c85f395ff3fe608060405234801561000f575f80fd5b5060043610610114575f3560e01c80638da5cb5b116100a0578063a9059cbb1161006f578063a9059cbb146102bc578063cd13d3df146102ec578063dd62ed3e14610308578063f2fde38b14610338578063f7cbc2f11461035457610114565b80638da5cb5b146102445780638f620487146102625780638faaefc81461028057806395d89b411461029e57610114565b80632b3b8499116100e75780632b3b8499146101b4578063313ce567146101d057806334c6d8b5146101ee57806370a082311461020a578063715018a61461023a57610114565b806306fdde0314610118578063095ea7b31461013657806318160ddd1461016657806323b872dd14610184575b5f80fd5b610120610373565b60405161012d919061172e565b60405180910390f35b610150600480360381019061014b91906117df565b610403565b60405161015d9190611837565b60405180910390f35b61016e610425565b60405161017b919061185f565b60405180910390f35b61019e60048036038101906101999190611878565b61042e565b6040516101ab9190611837565b60405180910390f35b6101ce60048036038101906101c991906117df565b610564565b005b6101d86107d3565b6040516101e591906118e3565b60405180910390f35b610208600480360381019061020391906118fc565b6107db565b005b610224600480360381019061021f91906118fc565b610914565b604051610231919061185f565b60405180910390f35b610242610959565b005b61024c61096c565b6040516102599190611936565b60405180910390f35b61026a610994565b604051610277919061185f565b60405180910390f35b61028861099a565b6040516102959190611936565b60405180910390f35b6102a66109bf565b6040516102b3919061172e565b60405180910390f35b6102d660048036038101906102d191906117df565b610a4f565b6040516102e39190611837565b60405180910390f35b610306600480360381019061030191906117df565b610b15565b005b610322600480360381019061031d919061194f565b610d8a565b60405161032f919061185f565b60405180910390f35b610352600480360381019061034d91906118fc565b610e0c565b005b61035c610e90565b60405161036a92919061198d565b60405180910390f35b606060038054610382906119e1565b80601f01602080910402602001604051908101604052809291908181526020018280546103ae906119e1565b80156103f95780601f106103d0576101008083540402835291602001916103f9565b820191905f5260205f20905b8154815290600101906020018083116103dc57829003601f168201915b5050505050905090565b5f8061040d610ea2565b905061041a818585610ea9565b600191505092915050565b5f600254905090565b5f600654421115610474576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161046b90611a5b565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff16036104e2576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016104d990611ae9565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610550576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161054790611b51565b60405180910390fd5b61055b848484610ebb565b90509392505050565b60075f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146105f3576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016105ea90611bb9565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff1660075f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1603610682576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161067990611c21565b60405180910390fd5b6006544211156106c7576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016106be90611a5b565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610735576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161072c90611c89565b60405180910390fd5b5f8111610777576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161076e90611cf1565b60405180910390fd5b6107818282610ee9565b8173ffffffffffffffffffffffffffffffffffffffff167f3f2c9d57c068687834f0de942a9babb9e5acab57d516d3480a3c16ee165a4273826040516107c7919061185f565b60405180910390a25050565b5f6012905090565b6107e3610f68565b5f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff1603610851576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161084890611d59565b60405180910390fd5b5f60075f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160075f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f6fa2f13c21adcb8d4c7e53e4349c02d5648af6531b7f168d838157b72d57c87660405160405180910390a35050565b5f805f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20549050919050565b610961610f68565b61096a5f610fef565b565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b60065481565b60075f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6060600480546109ce906119e1565b80601f01602080910402602001604051908101604052809291908181526020018280546109fa906119e1565b8015610a455780601f10610a1c57610100808354040283529160200191610a45565b820191905f5260205f20905b815481529060010190602001808311610a2857829003601f168201915b5050505050905090565b5f600654421115610a95576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610a8c90611a5b565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610b03576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610afa90611b51565b60405180910390fd5b610b0d83836110b2565b905092915050565b60075f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614610ba4576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610b9b90611bb9565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff1660075f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1603610c33576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610c2a90611c21565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610ca1576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610c9890611dc1565b60405180910390fd5b5f8111610ce3576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610cda90611cf1565b60405180910390fd5b80610ced83610914565b1015610d2e576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610d2590611e29565b60405180910390fd5b610d3882826110d4565b8173ffffffffffffffffffffffffffffffffffffffff167ffd38818f5291bf0bb3a2a48aadc06ba8757865d1dabd804585338aab3009dcb682604051610d7e919061185f565b60405180910390a25050565b5f60015f8473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2054905092915050565b610e14610f68565b5f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff1603610e84575f6040517f1e4fbdf7000000000000000000000000000000000000000000000000000000008152600401610e7b9190611936565b60405180910390fd5b610e8d81610fef565b50565b5f806006549150600654421190509091565b5f33905090565b610eb68383836001611153565b505050565b5f80610ec5610ea2565b9050610ed2858285611322565b610edd8585856113b5565b60019150509392505050565b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610f59575f6040517fec442f05000000000000000000000000000000000000000000000000000000008152600401610f509190611936565b60405180910390fd5b610f645f83836114a5565b5050565b610f70610ea2565b73ffffffffffffffffffffffffffffffffffffffff16610f8e61096c565b73ffffffffffffffffffffffffffffffffffffffff1614610fed57610fb1610ea2565b6040517f118cdaa7000000000000000000000000000000000000000000000000000000008152600401610fe49190611936565b60405180910390fd5b565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160055f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f806110bc610ea2565b90506110c98185856113b5565b600191505092915050565b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603611144575f6040517f96c6fd1e00000000000000000000000000000000000000000000000000000000815260040161113b9190611936565b60405180910390fd5b61114f825f836114a5565b5050565b5f73ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff16036111c3575f6040517fe602df050000000000000000000000000000000000000000000000000000000081526004016111ba9190611936565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603611233575f6040517f94280d6200000000000000000000000000000000000000000000000000000000815260040161122a9190611936565b60405180910390fd5b8160015f8673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f8573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2081905550801561131c578273ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92584604051611313919061185f565b60405180910390a35b50505050565b5f61132d8484610d8a565b90507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8110156113af57818110156113a0578281836040517ffb8f41b200000000000000000000000000000000000000000000000000000000815260040161139793929190611e47565b60405180910390fd5b6113ae84848484035f611153565b5b50505050565b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603611425575f6040517f96c6fd1e00000000000000000000000000000000000000000000000000000000815260040161141c9190611936565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603611495575f6040517fec442f0500000000000000000000000000000000000000000000000000000000815260040161148c9190611936565b60405180910390fd5b6114a08383836114a5565b505050565b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff16036114f5578060025f8282546114e99190611ea9565b925050819055506115c3565b5f805f8573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205490508181101561157e578381836040517fe450d38c00000000000000000000000000000000000000000000000000000000815260040161157593929190611e47565b60405180910390fd5b8181035f808673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2081905550505b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff160361160a578060025f8282540392505081905550611654565b805f808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f82825401925050819055505b8173ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040516116b1919061185f565b60405180910390a3505050565b5f81519050919050565b5f82825260208201905092915050565b8281835e5f83830152505050565b5f601f19601f8301169050919050565b5f611700826116be565b61170a81856116c8565b935061171a8185602086016116d8565b611723816116e6565b840191505092915050565b5f6020820190508181035f83015261174681846116f6565b905092915050565b5f80fd5b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f61177b82611752565b9050919050565b61178b81611771565b8114611795575f80fd5b50565b5f813590506117a681611782565b92915050565b5f819050919050565b6117be816117ac565b81146117c8575f80fd5b50565b5f813590506117d9816117b5565b92915050565b5f80604083850312156117f5576117f461174e565b5b5f61180285828601611798565b9250506020611813858286016117cb565b9150509250929050565b5f8115159050919050565b6118318161181d565b82525050565b5f60208201905061184a5f830184611828565b92915050565b611859816117ac565b82525050565b5f6020820190506118725f830184611850565b92915050565b5f805f6060848603121561188f5761188e61174e565b5b5f61189c86828701611798565b93505060206118ad86828701611798565b92505060406118be868287016117cb565b9150509250925092565b5f60ff82169050919050565b6118dd816118c8565b82525050565b5f6020820190506118f65f8301846118d4565b92915050565b5f602082840312156119115761191061174e565b5b5f61191e84828501611798565b91505092915050565b61193081611771565b82525050565b5f6020820190506119495f830184611927565b92915050565b5f80604083850312156119655761196461174e565b5b5f61197285828601611798565b925050602061198385828601611798565b9150509250929050565b5f6040820190506119a05f830185611850565b6119ad6020830184611828565b9392505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f60028204905060018216806119f857607f821691505b602082108103611a0b57611a0a6119b4565b5b50919050565b7f546f6b656e2068617320657870697265640000000000000000000000000000005f82015250565b5f611a456011836116c8565b9150611a5082611a11565b602082019050919050565b5f6020820190508181035f830152611a7281611a39565b9050919050565b7f43616e6e6f74207472616e736665722066726f6d207a65726f206164647265735f8201527f7300000000000000000000000000000000000000000000000000000000000000602082015250565b5f611ad36021836116c8565b9150611ade82611a79565b604082019050919050565b5f6020820190508181035f830152611b0081611ac7565b9050919050565b7f43616e6e6f74207472616e7366657220746f207a65726f2061646472657373005f82015250565b5f611b3b601f836116c8565b9150611b4682611b07565b602082019050919050565b5f6020820190508181035f830152611b6881611b2f565b9050919050565b7f4f6e6c79206d756c74692d73696720636f6e74726163742063616e2063616c6c5f82015250565b5f611ba36020836116c8565b9150611bae82611b6f565b602082019050919050565b5f6020820190508181035f830152611bd081611b97565b9050919050565b7f4d756c74692d73696720636f6e7472616374206e6f74207365740000000000005f82015250565b5f611c0b601a836116c8565b9150611c1682611bd7565b602082019050919050565b5f6020820190508181035f830152611c3881611bff565b9050919050565b7f43616e6e6f74206d696e7420746f207a65726f206164647265737300000000005f82015250565b5f611c73601b836116c8565b9150611c7e82611c3f565b602082019050919050565b5f6020820190508181035f830152611ca081611c67565b9050919050565b7f416d6f756e74206d75737420626520706f7369746976650000000000000000005f82015250565b5f611cdb6017836116c8565b9150611ce682611ca7565b602082019050919050565b5f6020820190508181035f830152611d0881611ccf565b9050919050565b7f496e76616c6964206164647265737300000000000000000000000000000000005f82015250565b5f611d43600f836116c8565b9150611d4e82611d0f565b602082019050919050565b5f6020820190508181035f830152611d7081611d37565b9050919050565b7f43616e6e6f74206275726e2066726f6d207a65726f20616464726573730000005f82015250565b5f611dab601d836116c8565b9150611db682611d77565b602082019050919050565b5f6020820190508181035f830152611dd881611d9f565b9050919050565b7f4275726e20616d6f756e7420657863656564732062616c616e636500000000005f82015250565b5f611e13601b836116c8565b9150611e1e82611ddf565b602082019050919050565b5f6020820190508181035f830152611e4081611e07565b9050919050565b5f606082019050611e5a5f830186611927565b611e676020830185611850565b611e746040830184611850565b949350505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f611eb3826117ac565b9150611ebe836117ac565b9250828201905080821115611ed657611ed5611e7c565b5b9291505056fea2646970667358221220223a8455ec071e9137c581db436c800815a745fe1b6fbb86529f1a2c5ecd0f2964736f6c634300081a0033"

                const customTokenMultiABI = [
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "_tokenContract",
                                "type": "address"
                            },
                            {
                                "internalType": "address[]",
                                "name": "_signers",
                                "type": "address[]"
                            },
                            {
                                "internalType": "uint256",
                                "name": "_requiredConfirmations",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "constructor"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "owner",
                                "type": "address"
                            }
                        ],
                        "name": "OwnableInvalidOwner",
                        "type": "error"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "account",
                                "type": "address"
                            }
                        ],
                        "name": "OwnableUnauthorizedAccount",
                        "type": "error"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "previousOwner",
                                "type": "address"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "newOwner",
                                "type": "address"
                            }
                        ],
                        "name": "OwnershipTransferred",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "oldRequired",
                                "type": "uint256"
                            },
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "newRequired",
                                "type": "uint256"
                            }
                        ],
                        "name": "RequiredConfirmationsChanged",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "signer",
                                "type": "address"
                            }
                        ],
                        "name": "SignerAdded",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "signer",
                                "type": "address"
                            }
                        ],
                        "name": "SignerRemoved",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "uint256",
                                "name": "txIndex",
                                "type": "uint256"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "signer",
                                "type": "address"
                            }
                        ],
                        "name": "TransactionConfirmed",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "uint256",
                                "name": "txIndex",
                                "type": "uint256"
                            }
                        ],
                        "name": "TransactionExecuted",
                        "type": "event"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": true,
                                "internalType": "uint256",
                                "name": "txIndex",
                                "type": "uint256"
                            },
                            {
                                "indexed": true,
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            },
                            {
                                "indexed": false,
                                "internalType": "enum CustomTokenMulti.TransactionType",
                                "name": "txType",
                                "type": "uint8"
                            }
                        ],
                        "name": "TransactionSubmitted",
                        "type": "event"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "_signer",
                                "type": "address"
                            }
                        ],
                        "name": "addSigner",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "_requiredConfirmations",
                                "type": "uint256"
                            }
                        ],
                        "name": "changeRequiredConfirmations",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "_txIndex",
                                "type": "uint256"
                            }
                        ],
                        "name": "confirmTransaction",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "_txIndex",
                                "type": "uint256"
                            }
                        ],
                        "name": "executeTransaction",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "getAllSigners",
                        "outputs": [
                            {
                                "internalType": "address[]",
                                "name": "",
                                "type": "address[]"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "getSignerCount",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "_txIndex",
                                "type": "uint256"
                            }
                        ],
                        "name": "getTransaction",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            },
                            {
                                "internalType": "enum CustomTokenMulti.TransactionType",
                                "name": "txType",
                                "type": "uint8"
                            },
                            {
                                "internalType": "bool",
                                "name": "executed",
                                "type": "bool"
                            },
                            {
                                "internalType": "uint256",
                                "name": "numConfirmations",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "getTransactionCount",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            },
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "name": "isConfirmed",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "name": "isSigner",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "_txIndex",
                                "type": "uint256"
                            },
                            {
                                "internalType": "address",
                                "name": "_signer",
                                "type": "address"
                            }
                        ],
                        "name": "isTransactionConfirmedBy",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "",
                                "type": "bool"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "owner",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "_signer",
                                "type": "address"
                            }
                        ],
                        "name": "removeSigner",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "renounceOwnership",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "requiredConfirmations",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "name": "signers",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "from",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "submitBurnTransaction",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "txIndex",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "submitMintTransaction",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "txIndex",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "from",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "submitRedeemTransaction",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "txIndex",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "tokenContract",
                        "outputs": [
                            {
                                "internalType": "contract CustomTokenTransfer",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "name": "transactions",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "to",
                                "type": "address"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            },
                            {
                                "internalType": "enum CustomTokenMulti.TransactionType",
                                "name": "txType",
                                "type": "uint8"
                            },
                            {
                                "internalType": "bool",
                                "name": "executed",
                                "type": "bool"
                            },
                            {
                                "internalType": "uint256",
                                "name": "numConfirmations",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "newOwner",
                                "type": "address"
                            }
                        ],
                        "name": "transferOwnership",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    }
                ]

            </script>

            <script>
                // 全局变量
                window.web3 = undefined;
                window.userAddress = undefined;
                window.scTranscontract = undefined;
                window.scMulticontract = undefined;


                document.addEventListener('DOMContentLoaded', () => {

                    document.getElementById('connectWalletBtn').addEventListener('click', connectMetaMask);
                    // Add event listener for search button
                    document.getElementById('searchSCTransButton').addEventListener('click', searchLatestSCTransFromDB);
                    document.getElementById('SearchMultiSigAddressBtn').addEventListener('click', SearchMultiSigAddressFromDB);
                    // document.getElementById('checkSignersBtn').addEventListener('click', checkMultiSigSigners);
                    document.getElementById('saveTokenInfoButton').addEventListener('click', saveTokenAmount);
                    document.getElementById('mintForm').addEventListener('submit', async function (e) {
                        e.preventDefault();

                        const recipientAddress = document.getElementById('recipientAddress').value;
                        const amount = document.getElementById('amount').value;

                        if (!web3 || !web3.utils.isAddress(recipientAddress)) {
                            showStatus("Invalid Ethereum address format", true);
                            return;
                        }

                        if (amount <= 0) {
                            showStatus("Amount must be greater than 0", true);
                            return;
                        }
                        await mintToken(recipientAddress, amount);

                    });

                    // Add this to your JavaScript
                    document.getElementById('confirmTxButton').addEventListener('click', async function () {
                        const txIndex = document.getElementById('txIndexInput').value;
                        if (!txIndex || isNaN(txIndex)) {
                            showStatus("Please enter a valid transaction index", true);
                            return;
                        }
                        await confirmTransaction(txIndex);
                    });

                    document.getElementById('loadTxsButton').addEventListener('click', loadPendingTransactions);

                    if (window.ethereum) {
                        window.ethereum.request({ method: 'eth_accounts' })
                            .then(accounts => {
                                if (accounts.length > 0) {
                                    connectMetaMask();
                                }
                            });
                    }
                });


                if (window.ethereum) {
                    window.ethereum.on('accountsChanged', function (accounts) {
                        connectMetaMask();
                    });

                    window.ethereum.on('chainChanged', function (chainId) {
                        window.location.reload();
                    });
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

                // Connect to MetaMask
                async function connectMetaMask() {
                    // Check if MetaMask is installed
                    if (typeof window.ethereum === 'undefined') {
                        showStatus("MetaMask is not installed. Please install MetaMask and try again.", true);
                        return;
                    }

                    // Prevent multiple simultaneous connection attempts
                    if (isConnecting) {
                        showStatus("Connection request already in progress. Please wait...", true);
                        return;
                    }

                    try {
                        isConnecting = true;

                        // First check if we're in "connected" state
                        const connectButton = document.getElementById('connectWalletBtn');

                        if (connectButton.innerText === "Wallet Connected") {
                            // Instead of disconnecting, force the account selection dialog
                            console.log("Requesting MetaMask account selection...");

                            // This method ALWAYS shows the account selection dialog
                            await ethereum.request({
                                method: 'wallet_requestPermissions',
                                params: [{ eth_accounts: {} }]
                            });

                            // After getting permissions, get the selected account
                            const accounts = await ethereum.request({ method: 'eth_accounts' });

                            if (accounts && accounts.length > 0) {
                                window.userAddress = accounts[0];
                                window.web3 = new Web3(window.ethereum);
                                updateUIForConnectedWallet(accounts[0]);
                                showStatus("Switched to wallet: " + formatAddress(accounts[0]));
                            } else {
                                resetWalletConnectionUI();
                                showStatus("No accounts selected");
                            }

                            isConnecting = false;
                            return;
                        }

                        console.log("Requesting MetaMask accounts...");

                        // Use eth_requestAccounts for initial connection
                        const accounts = await ethereum.request({
                            method: 'eth_requestAccounts'
                        });

                        console.log("MetaMask accounts after selection:", accounts);

                        if (accounts && accounts.length > 0) {
                            window.userAddress = accounts[0];
                            updateUIForConnectedWallet(accounts[0]);
                            showStatus("Connected to wallet: " + formatAddress(accounts[0]));

                        } else {
                            showStatus("No accounts selected", true);
                            resetWalletConnectionUI();
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

                    // Check owner status and update UI accordingly
                    const isOwner = await checkAddressOwner();
                    if (!isOwner) {
                        document.getElementById('saveTokenInfoButton').disabled = true;
                        document.getElementById('generateTokenButton').disabled = true;
                    }

                    // Update recipient field if it exists
                    const recipientField = document.getElementById('recipientAddress');
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

                async function checkAddressOwner() {
                    try {
                        const walletAddress = window.userAddress;
                        if (!walletAddress) {
                            return false;
                        }

                        const url = 'searchToken?walletAddress=' + encodeURIComponent(walletAddress);
                        const response = await fetch(url);

                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        const data = await response.json();
                        return data.success; // Returns true if owner, false otherwise
                    } catch (error) {
                        console.error('Error checking owner status:', error);
                        showStatus("Failed to check owner status: " + error.message, true);
                        return false; // Default to non-owner on error for security
                    }
                }

                function searchLatestSCTransFromDB(showStatusMsg = true) {
                    // Show loading status
                    showStatus("Searching for latest contract...");

                    // Get wallet address if connected
                    const walletAddress = window.userAddress;

                    // Create URL with query parameter if wallet is connected
                    let url = 'searchToken';
                    if (walletAddress) {
                        url += '?walletAddress=' + encodeURIComponent(walletAddress);
                    }

                    // Fetch the latest contract from server
                    fetch(url)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                console.log("Ower address");
                                // Display the result
                                const token = data.token;

                                document.getElementById('tokenID').value = token.tokenID;
                                document.getElementById('tokenName').value = token.tokenName;
                                document.getElementById('tokenSymbol').value = token.tokenSymbol;
                                document.getElementById('invalidDate').value = token.scexpireDate;
                                document.getElementById('amount').value = token.tokenAmount;
                                // Display creation time if available
                                if (token.sccreateTime) {
                                    document.getElementById('creationTime').value = token.sccreateTime;
                                    // Make the creation time field visible
                                    document.getElementById('creationTimeContainer').style.display = 'block';
                                }

                                // Update contract address if available
                                if (token.genContractAddr) {
                                    document.getElementById('contractAddressDisplay').value = token.genContractAddr;
                                    window.scTranscontract = token.genContractAddr;
                                }
                                searchSCConnectionsFromDB();


                                showStatus("Latest contract loaded successfully");
                            } else {
                                // console.log("Signer address");
                                SearchMultiSigAddressFromDB();
                                // showStatus(data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error searching contract:', error);
                            showStatus("Failed to search contract: " + error.message, true);
                        });
                }


                // Function to search for SC connections from the database
                function searchSCConnectionsFromDB() {
                    // Show loading status
                    showStatus("Searching for latest SC connections...");

                    // Check if we have a contract address to use
                    if (!window.scTranscontract) {
                        showStatus("No contract address available for multi-sig lookup", true);
                        return;
                    }

                    // Search for the latest SCMulti using the contract address
                    fetch('searchScMulti?scTransAddr=' + encodeURIComponent(window.scTranscontract))
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success && data.data) {
                                // Update the SCMulti connection field
                                document.getElementById('connScMultiAddress').value = data.data.genmuliContractAddr || '';

                                showStatus("SC connections loaded successfully");
                            } else {
                                showStatus("No multi-sig contract found for this token", true);
                            }
                        })
                        .catch(error => {
                            console.error('Error searching connections:', error);
                            showStatus("Failed to search connections: " + error.message, true);
                        });
                }

                async function saveTokenAmount() {
                    try {
                        // Get token amount from UI
                        const tokenAmount = document.getElementById('amount').value;

                        // Validate input
                        if (!tokenAmount || isNaN(parseFloat(tokenAmount))) {
                            showStatus("Please enter a valid token amount", true);
                            return;
                        }

                        // Get token ID from UI
                        const tokenID = document.getElementById('tokenID').value;

                        if (!tokenID) {
                            showStatus("Token ID not found. Please search for a token first.", true);
                            return;
                        }

                        showStatus("Saving token amount...");

                        // Call server to update token amount
                        const response = await fetch('updateTokenAmount', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: "tokenID=" + encodeURIComponent(tokenID) + "&tokenAmount=" + encodeURIComponent(tokenAmount)
                        });

                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        const data = await response.json();

                        if (data.success) {
                            showStatus("Token amount saved successfully!");
                        } else {
                            showStatus("Failed to save token amount: " + data.message, true);
                        }

                    } catch (error) {
                        console.error('Error saving token amount:', error);
                        showStatus("Error saving token amount: " + error.message, true);
                    }
                }

                async function mintToken(recipientAddress, amount) {
                    if (!window.web3) {
                        showStatus("Wallet not connected. Please connect wallet first.", true);
                        return false;
                    }

                    // Check token contract address
                    const tokenContractAddress = document.getElementById('contractAddressDisplay').value;
                    if (!tokenContractAddress) {
                        showStatus("Token contract address not found. Please search for a contract first.", true);
                        return false;
                    }

                    // Check multi-sig contract address
                    const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                    if (!multiSigContractAddress) {
                        showStatus("Multi-signature contract address not found. Cannot proceed with minting operation.", true);
                        return false;
                    }

                    try {
                        // Initialize token contract
                        const tokenContract = new web3.eth.Contract(customTokenTransferABI, tokenContractAddress);
                        console.log("Token contract initialized successfully");

                        // Initialize multi-sig contract
                        const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);
                        console.log("Multi-signature contract initialized successfully");

                        // Convert amount to correct format (18 decimal places)
                        // User inputs the actual token amount, we convert to wei for blockchain
                        const amountInWei = web3.utils.toWei(amount.toString(), 'ether');

                        showStatus("Submitting mint request to multi-sig contract, please confirm transaction in your wallet...");

                        // Get current gas price
                        const currentGasPrice = await web3.eth.getGasPrice();
                        console.log("Current gas price:", currentGasPrice);

                        const tx = await multiSigContract.methods.submitMintTransaction(
                            recipientAddress,
                            amountInWei
                        ).send({
                            from: userAddress,
                            gas: 3000000,
                            gasPrice: currentGasPrice
                        });

                        // Get transaction index from receipt
                        const txIndex = tx.events.TransactionSubmitted ?
                            tx.events.TransactionSubmitted.returnValues.txIndex :
                            "Unknown";

                        showStatus(`Mint transaction request submitted! Transaction index: ${txIndex}. Please wait for enough signers to confirm before execution.`);
                        return true;
                    } catch (error) {
                        console.error("Mint transaction request failed:", error);

                        // Detailed error handling
                        if (error.message.includes("execution reverted")) {
                            if (error.message.includes("not a signer")) {
                                showStatus("Error: Your address is not authorized as a signer on the multi-sig contract", true);
                            } else if (error.message.includes("already submitted")) {
                                showStatus("Error: A transaction with the same parameters already exists", true);
                            } else {
                                showStatus("Transaction reverted: " + error.message, true);
                            }
                        } else {
                            showStatus("Mint transaction request error: " + error.message, true);
                        }
                        return false;
                    }
                }


                async function confirmTransaction(txIndex) {
                    if (!window.web3) {
                        showStatus("Wallet not connected. Please connect wallet first.", true);
                        return;
                    }

                    // 格式化索引为整数
                    txIndex = parseInt(txIndex);
                    if (isNaN(txIndex) || txIndex < 0) {
                        showStatus("Invalid transaction index. Please enter a valid number.", true);
                        return;
                    }

                    try {
                        // 获取最新账户以确保使用当前连接的钱包
                        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
                        if (!accounts || accounts.length === 0) {
                            showStatus("Failed to get connected account. Please check MetaMask connection.", true);
                            return;
                        }
                        window.userAddress = accounts[0];

                        const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                        if (!multiSigContractAddress || !window.web3.utils.isAddress(multiSigContractAddress)) {
                            showStatus("Invalid multi-signature contract address.", true);
                            return;
                        }

                        showStatus(`Checking transaction #${txIndex}...`);
                        console.log(`Confirming transaction ${txIndex} on contract ${multiSigContractAddress}`);

                        // 创建合约实例
                        const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);

                        // 检查交易总数
                        const txCount = await multiSigContract.methods.getTransactionCount().call();
                        if (txIndex >= txCount) {
                            showStatus(`Error: Transaction with index ${txIndex} does not exist. Total transactions: ${txCount}`, true);
                            return;
                        }

                        // 获取交易详情
                        const tx = await multiSigContract.methods.getTransaction(txIndex).call();
                        console.log("Transaction details:", tx);

                        // 检查交易是否已执行
                        if (tx.executed) {
                            showStatus(`Transaction #${txIndex} has already been executed and cannot be confirmed again.`, true);
                            return;
                        }

                        // 检查用户是否是授权签名者
                        const isSigner = await multiSigContract.methods.isSigner(window.userAddress).call();
                        if (!isSigner) {
                            showStatus("Error: Your wallet address is not registered as an authorized signer for this contract.", true);
                            return;
                        }

                        // 检查用户是否已经确认过该交易
                        const isAlreadyConfirmed = await multiSigContract.methods.isTransactionConfirmedBy(txIndex, window.userAddress).call();
                        if (isAlreadyConfirmed) {
                            showStatus(`You have already confirmed transaction #${txIndex}.`, true);
                            return;
                        }

                        // 新增: 检查当前钱包地址是否是交易的接收地址
                        const recipient = tx.to;
                        const isRecipient = recipient.toLowerCase() === window.userAddress.toLowerCase();
                        if (isRecipient) {
                            showStatus("Error: You cannot confirm your own transaction. Please switch to another authorized signer address.", true);
                            return;
                        }

                        const networkId = await web3.eth.net.getId();
                        console.log("Current network ID:", networkId);

                        const gasPrice = await web3.eth.getGasPrice();
                        console.log("Current gas price:", gasPrice);

                        let gasEstimate;
                        try {
                            gasEstimate = await multiSigContract.methods.confirmTransaction(txIndex)
                                .estimateGas({ from: window.userAddress });
                            console.log("Estimated gas:", gasEstimate);
                            // 增加 20% 的 gas 限制以确保交易成功
                            gasEstimate = Math.ceil(gasEstimate * 1.2);
                        } catch (gasError) {
                            console.warn("Failed to estimate gas, using default:", gasError);
                            gasEstimate = 300000;
                        }
                        showStatus("Confirming transaction, please approve in your wallet...");

                        const txConfirmation = await multiSigContract.methods.confirmTransaction(txIndex)
                            .send({
                                from: window.userAddress,
                                gas: gasEstimate,
                                gasPrice: gasPrice
                            });

                        console.log("Confirmation transaction result:", txConfirmation);


                        const requiredConfirmations = await multiSigContract.methods.requiredConfirmations().call();
                        const updatedTx = await multiSigContract.methods.getTransaction(txIndex).call();
                        const canExecute = updatedTx.numConfirmations >= requiredConfirmations && !updatedTx.executed;

                        if (canExecute) {
                            showStatus(`Transaction #${txIndex} confirmed successfully! It now has ${updatedTx.numConfirmations}/${requiredConfirmations} confirmations and can be executed.`);
                        } else {
                            showStatus(`Transaction #${txIndex} confirmed successfully! It now has ${updatedTx.numConfirmations}/${requiredConfirmations} confirmations.`);
                        }


                      //  await loadPendingTransactions();

                    } catch (error) {
                        console.error("Error confirming transaction:", error);

                        if (error.code === 4001) {
                            showStatus("Transaction was rejected in your wallet.", true);
                        } else if (error.message && error.message.includes("already confirmed")) {
                            showStatus("You have already confirmed this transaction.", true);
                        } else if (error.message && error.message.includes("gas")) {
                            showStatus("Transaction failed due to gas estimation issues. Try again or increase gas limit manually.", true);
                        } else if (error.message && error.message.includes("nonce")) {
                            showStatus("Transaction failed due to incorrect nonce. Please reset your MetaMask account or try again.", true);
                        } else if (error.message && error.message.toLowerCase().includes("not a signer")) {
                            showStatus("Error: Your wallet address is not registered as a signer for this contract.", true);
                        } else {
                            showStatus("Failed to confirm transaction: " + (error.message || "Unknown error"), true);
                        }
                    }
                }


                async function loadPendingTransactions() {
                    console.log("Loading pending transactions...");

                    // Always show a status message when starting
                    showStatus("Loading pending transactions...");

                    if (!window.web3) {
                        console.error("No web3 instance available");
                        showStatus("Wallet not connected. Please connect wallet first.", true);
                        return;
                    }

                    const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                    console.log("Multi-sig contract address:", multiSigContractAddress);

                    if (!multiSigContractAddress || multiSigContractAddress.trim() === '') {
                        showStatus("Multi-signature contract address not found. Please search for a contract first.", true);
                        return;
                    }

                    try {
                        showStatus("Connecting to multi-signature contract...");

                        const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);

                        showStatus("Fetching transaction count...");
                        const txCount = await multiSigContract.methods.getTransactionCount().call();
                        console.log("Transaction count:", txCount);

                        const pendingTxDiv = document.getElementById('pendingTransactions');
                        pendingTxDiv.innerHTML = '';

                        if (txCount == 0) {
                            pendingTxDiv.innerHTML = '<div class="alert alert-info">No transactions found</div>';
                            showStatus("No transactions found on this contract");
                            return;
                        }

                        showStatus("Loading transaction details...");

                        const table = document.createElement('table');
                        table.className = 'table table-striped';
                        table.innerHTML =
                            "<thead>" +
                            "<tr>" +
                            "<th>Index</th>" +
                            "<th>Recipient</th>" +
                            "<th>Amount</th>" +
                            "<th>Type</th>" +
                            "<th>Status</th>" +
                            "<th>Confirmations</th>" +
                            "</tr>" +
                            "</thead>" +
                            "<tbody id=\"txTableBody\"></tbody>";

                        pendingTxDiv.appendChild(table);

                        const tableBody = document.getElementById('txTableBody');

                        showStatus("Fetching required confirmations...");
                        const requiredConfirmations = await multiSigContract.methods.requiredConfirmations().call();
                        console.log("Required confirmations:", requiredConfirmations);

                        let pendingCount = 0;

                        for (let i = 0; i < txCount; i++) {
                            showStatus(`Loading transaction ${i + 1} of ${txCount}...`);
                            console.log(`Fetching transaction ${i}...`);

                            try {
                                const tx = await multiSigContract.methods.getTransaction(i).call();
                                console.log(`Transaction ${i} details:`, tx);

                                // Skip executed transactions
                                if (tx.executed) continue;

                                pendingCount++;
                                const row = document.createElement('tr');

                                // Convert type number to text
                                let typeText = "Unknown";
                                if (tx.txType == 0) typeText = "Mint";
                                else if (tx.txType == 1) typeText = "Burn";
                                else if (tx.txType == 2) typeText = "Redeem";

                                // Format amount from wei
                                const amountInEth = web3.utils.fromWei(tx.amount);

                                // Don't use template literals - use string concatenation instead
                                row.innerHTML =
                                    "<td>" + i + "</td>" +
                                    "<td>" + tx.to.substring(0, 6) + "..." + tx.to.substring(38) + "</td>" +
                                    "<td>" + amountInEth + " tokens</td>" +
                                    "<td>" + typeText + "</td>" +
                                    "<td>" + (tx.executed ? 'Executed' : 'Pending') + "</td>" +
                                    "<td>" + tx.numConfirmations + "/" + requiredConfirmations + "</td>";

                                tableBody.appendChild(row);
                            } catch (txError) {
                                console.error(`Error fetching transaction ${i}:`, txError);
                                // Continue with the next transaction instead of failing completely
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

                async function SearchMultiSigAddressFromDB() {
                    try {
                        // Check if Web3 is available
                        if (!window.web3) {
                            showStatus("Please connect your wallet first", true);
                            return;
                        }

                        // Show searching status
                        showStatus("Searching for multi-signature contracts...");

                        // Check if user has connected wallet
                        if (!window.userAddress) {
                            showStatus("Please connect your wallet first", true);
                            return;
                        }

                        // Call searchBySigner API with proper error handling
                        const response = await fetch('searchBySigner?signerAddress=' + encodeURIComponent(window.userAddress));

                        const contentType = response.headers.get("content-type");
                        // console.log("Response content type:", contentType);

                        if (!response.ok) {
                            throw new Error('Network request failed with status: ' + response.status);
                        }

                        if (!contentType || !contentType.includes('application/json')) {
                            // Getting HTML instead of JSON, dump first 100 chars for debugging
                            const text = await response.text();
                            console.error("Received non-JSON response:", text.substring(0, 100) + "...");
                            throw new Error('Server returned incorrect format. Expected JSON, got: ' +
                                (contentType || 'unknown format'));
                        }

                        // Parse JSON response
                        const data = await response.json();

                        if (data.success) {
                            // Process successful query

                            // 1. Update multi-sig contract info
                            if (data.multi) {
                                const multiAddress = data.multi.genmuliContractAddr;

                                // Update UI display
                                document.getElementById('connScMultiAddress').value = multiAddress || '';
                                document.getElementById('manualMultiSigAddress').value = multiAddress || '';

                                // Update scTransAddr if available
                                const scTransAddr = data.multi.scTransAddr;
                                if (scTransAddr) {
                                    document.getElementById('contractAddressDisplay').value = scTransAddr;
                                }

                                // Create multi-sig contract instance
                                if (window.web3 && multiAddress) {
                                    try {
                                        window.scMulticontract = new window.web3.eth.Contract(
                                            customTokenMultiABI,
                                            multiAddress
                                        );
                                        console.log("Multi-sig contract instance created successfully");
                                    } catch (err) {
                                        console.error("Failed to create multi-sig contract instance:", err);
                                    }
                                }
                            }

                            // 2. Update Token info
                            if (data.token) {
                                document.getElementById('tokenID').value = data.token.tokenID || '';
                                document.getElementById('tokenName').value = data.token.tokenName || '';
                                document.getElementById('tokenSymbol').value = data.token.tokenSymbol || '';
                                document.getElementById('invalidDate').value = data.token.scexpireDate || '';

                                // Show creation time
                                if (data.token.scCreateTime) {
                                    document.getElementById('creationTime').value = data.token.scCreateTime;
                                    document.getElementById('creationTimeContainer').style.display = 'block';
                                }

                                // Update recipient address
                                if (data.token.owerAddr) {
                                    document.getElementById('recipientAddress').value = data.token.owerAddr;
                                }

                                // Create Token contract instance
                                const tokenAddress = data.token.genContractAddr;
                                if (window.web3 && tokenAddress) {
                                    try {
                                        window.scTranscontract = new window.web3.eth.Contract(
                                            customTokenTransferABI,
                                            tokenAddress
                                        );
                                        console.log("Token contract instance created successfully");
                                    } catch (err) {
                                        console.error("Failed to create Token contract instance:", err);
                                    }
                                }
                            } else if (data.multi && data.multi.scTransAddr) {
                                document.getElementById('contractAddressDisplay').value = data.multi.scTransAddr || '';
                            }

                            showStatus("Contract information loaded successfully");

                            // 3. Load pending transactions
                            if (data.multi && data.multi.genmuliContractAddr) {
                                try {
                                    await loadPendingTransactions();
                                } catch (txError) {
                                    console.error("Error loading transactions:", txError);
                                }
                            }
                        } else {
                            // No contract information found
                            showStatus(data.message || "No multi-signature contracts found where you are a signer", true);
                        }
                    } catch (error) {
                        console.error('Error searching contracts:', error);
                        showStatus("Search failed: " + error.message, true);
                    }
                }


                async function checkMultiSigTokenAddress() {
                    try {
                        const multiSigAddress = document.getElementById('connScMultiAddress').value;
                        if (!multiSigAddress) {
                            showStatus("Multi-sig contract address not found.", true);
                            return;
                        }
                        const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigAddress);

                        showStatus("Checking token address stored in multi-sig contract...");
                        const storedTokenAddr = await multiSigContract.methods.tokenContract().call();

                        const expectedTokenAddr = document.getElementById('contractAddressDisplay').value;

                        console.log("Address stored in Multi-Sig Contract (tokenContract):", storedTokenAddr);
                        console.log("Expected Token Contract Address:", expectedTokenAddr);

                        if (!expectedTokenAddr) {
                            showStatus("Expected Token Contract address is missing in the UI.", true);
                            return;
                        }

                        if (storedTokenAddr.toLowerCase() === expectedTokenAddr.toLowerCase()) {
                            showStatus("Multi-sig contract has the correct token contract address set.", false);
                        } else if (storedTokenAddr === "0x0000000000000000000000000000000000000000") {
                            showStatus("ERROR: Token contract address is NOT SET in the multi-sig contract!", true);
                        } else {
                            showStatus("ERROR: Multi-sig contract has the WRONG token contract address set!", true);
                            showStatus("Expected: " + expectedTokenAddr + "<br>Got: " + storedTokenAddr, true, true);
                        }
                    } catch (error) {
                        console.error("Error checking multi-sig's token address:", error);
                        showStatus("Failed to check multi-sig's token address: " + error.message, true);
                    }
                }

                async function checkMultiSigSettings() {
                    const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                    const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);

                    const requiredConfirmations = await multiSigContract.methods.requiredConfirmations().call();
                    console.log("Required confirmations:", requiredConfirmations);

                    const signerCount = await multiSigContract.methods.getSignerCount().call();
                    console.log("Total signers:", signerCount);

                    showStatus(`Multi-sig contract requires ${requiredConfirmations} of ${signerCount} confirmations`);
                }

                async function changeRequiredConfirmations(newValue) {
                    const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                    const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);

                    await multiSigContract.methods.changeRequiredConfirmations(newValue).send({
                        from: userAddress
                    });

                    showStatus(`Required confirmations changed to ${newValue}`);
                }

                async function checkMultiSigSigners() {
                    if (!window.web3) {
                        showStatus("Web3 not initialized. Please connect your wallet first.", true);
                        return;
                    }

                    const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                    if (!multiSigContractAddress || !window.web3.utils.isAddress(multiSigContractAddress)) {
                        showStatus("Invalid multi-signature contract address", true);
                        return;
                    }

                    try {
                        const multiSigContract = new window.web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);

                        // Get all authorized signers
                        const signers = await multiSigContract.methods.getAllSigners().call();
                        console.log("Authorized signers:", signers);

                        // Get required confirmations
                        const required = await multiSigContract.methods.requiredConfirmations().call();

                        // Use string concatenation instead of template literals
                        let signerList = '';
                        for (let i = 0; i < signers.length; i++) {
                            const addr = signers[i];
                            const isCurrentUser = addr.toLowerCase() === window.userAddress.toLowerCase();
                            signerList += (i + 1) + '. ' + addr + ' ' + (isCurrentUser ? '(You)' : '') + '<br>';
                        }

                        showStatus('<strong>Multi-Signature Contract Signers (' + required + ' of ' + signers.length + ' required)</strong>:<br>' + signerList, false, true);

                        // Check if current user is a signer
                        let isCurrentUserSigner = false;
                        for (let i = 0; i < signers.length; i++) {
                            if (signers[i].toLowerCase() === window.userAddress.toLowerCase()) {
                                isCurrentUserSigner = true;
                                break;
                            }
                        }

                        if (!isCurrentUserSigner) {
                            showStatus("Warning: Your current wallet address is NOT authorized as a signer on this contract", true);
                        }

                        return signers;
                    } catch (error) {
                        console.error("Error fetching signers:", error);
                        showStatus("Failed to retrieve signers: " + error.message, true);
                        return [];
                    }
                }
                // Update the showStatus function to accept HTML content
                function showStatus(message, isError = false, isHTML = false) {
                    let statusDiv = document.getElementById('status');
                    if (!statusDiv) {
                        statusDiv = document.createElement('div');
                        statusDiv.id = 'status';
                        const container = document.querySelector('.container');
                        if (container) {
                            container.insertBefore(statusDiv, container.firstChild);
                        } else {
                            document.body.appendChild(statusDiv);
                        }
                    }

                    if (isHTML) {
                        statusDiv.innerHTML = message;
                    } else {
                        statusDiv.textContent = message;
                    }

                    statusDiv.style.display = 'block';
                    statusDiv.className = isError ? 'status-error' : 'status-success';

                    // Don't auto-hide for signer list
                    if (!isHTML) {
                        setTimeout(() => {
                            statusDiv.style.display = 'none';
                        }, 5000);
                    }
                }


                async function executeTransaction(txIndex) {
                    if (!window.web3) {
                        showStatus("Wallet not connected. Please connect wallet first.", true);
                        return;
                    }

                    const multiSigContractAddress = document.getElementById('connScMultiAddress').value;
                    if (!multiSigContractAddress) {
                        showStatus("Multi-signature contract address not found.", true);
                        return;
                    }

                    try {
                        const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigContractAddress);

                        showStatus("Executing transaction, please confirm in your wallet...");

                        const tx = await multiSigContract.methods.executeTransaction(txIndex).send({
                            from: userAddress,
                            gas: 500000,
                            gasPrice: await web3.eth.getGasPrice()
                        });

                        showStatus(`Transaction ${txIndex} executed successfully!`);
                        await loadPendingTransactions(); // Refresh the list
                    } catch (error) {
                        console.error("Error executing transaction:", error);
                        showStatus("Failed to execute transaction: " + error.message, true);
                    }
                }

                async function checkTokenExpiration() {
                    const tokenContract = new web3.eth.Contract(
                        customTokenTransferABI,
                        document.getElementById('contractAddressDisplay').value
                    );

                    const expiryInfo = await tokenContract.methods.getExpirationStatus().call();
                    console.log("Expiration date:", new Date(expiryInfo.expiryTime * 1000).toLocaleString());
                    console.log("Is expired:", expiryInfo.isExpired);

                    showStatus('Token expiration date: ' + new Date(expiryInfo.expiryTime * 1000).toLocaleString() + '<br>Is expired: ' + (expiryInfo.isExpired ? "Yes" : "No"), false, true);
                }


                async function checkTokenMultiSigAddress() {
                    try {
                        const tokenAddress = document.getElementById('contractAddressDisplay').value;
                        if (!tokenAddress) {
                            showStatus("Token contract address not found.", true);
                            return;
                        }
                        const tokenContract = new web3.eth.Contract(customTokenTransferABI, tokenAddress);
                        const storedMultiSigAddr = await tokenContract.methods.multiSigContract().call();

                        const expectedMultiSigAddr = document.getElementById('connScMultiAddress').value;

                        console.log("Address stored in Token Contract (multiSigContract):", storedMultiSigAddr);
                        console.log("Expected Multi-Sig Contract Address:", expectedMultiSigAddr);

                        if (storedMultiSigAddr.toLowerCase() === expectedMultiSigAddr.toLowerCase()) {
                            showStatus("Token contract has the correct multi-sig address set.", false);
                        } else if (storedMultiSigAddr === "0x0000000000000000000000000000000000000000") {
                            showStatus("ERROR: Multi-sig address is NOT SET in the token contract!", true);
                        } else {
                            showStatus("ERROR: Token contract has the WRONG multi-sig address set!", true);
                            showStatus("Expected: " + expectedMultiSigAddr + "<br>Got: " + storedMultiSigAddr, true, true);
                        }
                    } catch (error) {
                        console.error("Error checking token's multi-sig address:", error);
                        showStatus("Failed to check token's multi-sig address: " + error.message, true);
                    }
                }

                async function checkTokenTotalSupply() {
                    try {
                        const tokenAddress = document.getElementById('contractAddressDisplay').value;
                        if (!tokenAddress) {
                            showStatus("Token contract address not found.", true);
                            return;
                        }
                        const tokenContract = new web3.eth.Contract(customTokenTransferABI, tokenAddress);

                        showStatus("Checking current total supply...");
                        const currentSupplyWei = await tokenContract.methods.totalSupply().call();

                        // Display in Wei and Ether for clarity
                        console.log("Current Total Supply (Wei):", currentSupplyWei.toString());

                        let currentSupplyEther;
                        try {
                            currentSupplyEther = web3.utils.fromWei(currentSupplyWei.toString(), 'ether');
                        } catch (e) {
                            // Handle potential errors with very large numbers if fromWei fails
                            currentSupplyEther = "Too large to display as Ether";
                            console.error("Could not convert total supply to Ether:", e);
                        }

                        console.log("Current Total Supply (Ether):", currentSupplyEther);

                        // Also log the maximum uint256 value for comparison
                        const maxUint256 = BigInt('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
                        console.log("Max uint256:", maxUint256.toString());

                        showStatus("Current token total supply (Wei): " + currentSupplyWei.toString() + "<br>Equivalent approx: " + currentSupplyEther + " tokens", false, true);

                    } catch (error) {
                        console.error("Error checking total supply:", error);
                        showStatus("Failed to check total supply: " + error.message, true);
                    }
                }

                async function checkRecipientBalance() {
                    try {
                        const tokenAddress = document.getElementById('contractAddressDisplay').value;
                        // Assuming the recipient address is correctly populated from the transaction data
                        // If you are testing with a specific transaction index (e.g., 0), get it directly
                        const txIndex = document.getElementById('txIndexInput').value || 0; // Default to 0 if empty
                        const multiSigAddress = document.getElementById('connScMultiAddress').value;

                        if (!tokenAddress || !multiSigAddress) {
                            showStatus("Token or Multi-sig address missing.", true);
                            return;
                        }

                        const multiSigContract = new web3.eth.Contract(customTokenMultiABI, multiSigAddress);
                        const tx = await multiSigContract.methods.getTransaction(txIndex).call();
                        const recipient = tx.to; // Get recipient from the transaction data

                        if (!recipient || recipient === "0x0000000000000000000000000000000000000000") {
                            showStatus("Recipient address not found in transaction data.", true);
                            return;
                        }

                        console.log("Checking balance for recipient:", recipient);
                        showStatus("Checking balance for recipient: " + recipient);

                        const tokenContract = new web3.eth.Contract(customTokenTransferABI, tokenAddress);
                        const balanceWei = await tokenContract.methods.balanceOf(recipient).call();

                        console.log(`Recipient (${recipient}) Balance (Wei):`, balanceWei.toString());

                        let balanceEther;
                        try {
                            balanceEther = web3.utils.fromWei(balanceWei.toString(), 'ether');
                        } catch (e) {
                            balanceEther = "Too large to display as Ether";
                        }

                        console.log(`Recipient (${recipient}) Balance (Ether):`, balanceEther);

                        showStatus(`Recipient (${recipient}) balance (Wei): ${balanceWei.toString()}<br>Equivalent approx: ${balanceEther} tokens`, false, true);

                    } catch (error) {
                        console.error("Error checking recipient balance:", error);
                        showStatus("Failed to check recipient balance: " + error.message, true);
                    }
                }

            </script>



            <!-- Footer -->
            <div class="footer">
                <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
            </div>
    </body>

    </html>