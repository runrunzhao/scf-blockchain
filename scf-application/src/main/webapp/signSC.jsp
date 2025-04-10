<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>Create SC - Sign SC Event</title>
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

            /* Responsive styling */
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
                    <div class="d-flex align-items-center mb-2">
                        <div id="walletStatus" class="mr-3"> Connected </div>
                        <button id="connectWalletBtn" class="btn btn-primary">Connect Wallet</button>
                    </div>
                    <div class="mb-1"><strong>Address:</strong> <span id="walletAddress">Not connected</span></div>
                    <div class="mb-2"><strong>Gas:</strong> <span id="walletBalance">0 POL</span></div>

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
                            <p><strong>Invalid Date:</strong> Dec 31, 2026</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-edit mr-2"></i>Step1: Generate Util SC (Transfer Contract)
                </div>
                <div class="card-body">
                    <form id="scTransForm">
                        <div class="form-group">
                            <label for="scTransRecipientAddress">Recipient Address:</label>
                            <input type="text" class="form-control" id="scTransRecipientAddress"
                                name="scTransRecipientAddress" placeholder="Enter Ethereum Address (0x...)" required>
                        </div>

                        <!-- Token Name and Symbol on the same row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="tokenName">Token Name:</label>
                                <input type="text" class="form-control" id="tokenName" name="tokenName"
                                    placeholder="Enter Token Name" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="tokenSymbol">Token Symbol:</label>
                                <input type="text" class="form-control" id="tokenSymbol" name="tokenSymbol"
                                    placeholder="Enter Symbol (e.g. CTT)" required>
                            </div>
                        </div>

                        <!-- Invalid Date and Creation Time on the same row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="invalidDate">Invalid Date:</label>
                                <input type="date" class="form-control" id="invalidDate" name="invalidDate" required>
                            </div>
                            <div class="form-group col-md-6" id="scTransCreationTimeContainer" style="display:none">
                                <label for="scTransCreationTime">Creation Time:</label>
                                <input type="text" class="form-control" id="scTransCreationTime"
                                    name="scTransCreationTime" readonly>
                            </div>
                        </div>

                        <input type="hidden" id="scTransTokenID" name="scTransTokenID">
                        <!-- Three buttons in a single row -->
                        <div class="form-row">
                            <div class="col-md-4">
                                <button type="button" id="searchScTransBtn" class="btn btn-success btn-block">Search
                                    Latest SCTrans</button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="saveScTransBtn" class="btn btn-generate btn-block">Save
                                    SCTrans</button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="signScTransBtn" class="btn btn-warning btn-block">Sign
                                    SCTrans</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="form-group">
                <label for="scTransAddressDisplay"><strong>SCTrans BlockChain:</strong></label>
                <div class="input-group">
                    <input type="text" class="form-control" id="scTransAddressDisplay" readonly>
                    <div class="input-group-append">
                        <button class="btn btn-outline-primary" type="button" onclick="refreshScTransAddress()">
                            <i class="fas fa-sync-alt"></i> Refresh
                        </button>
                        <button class="btn btn-outline-secondary" type="button" onclick="copyScTransAddress()">
                            <i class="fas fa-copy"></i> Copy
                        </button>
                        <button class="btn btn-outline-success" type="button" onclick="saveScTransAddressToDB()">
                            <i class="fas fa-save"></i> Save
                        </button>
                    </div>
                </div>
                <label for="scTransCreateTimeDisplay"><strong>SCTrans CreateTime:</strong></label>
                <div class="input-group">
                    <input type="text" class="form-control" id="scTransCreateTimeDisplay" readonly>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-edit mr-2"></i>Step2: Generate Manage SC (Multi-Sig)
                </div>
                <div class="card-body">
                    <form id="scMultiForm">
                        <div class="form-group">
                            <label for="scMultiTransAddress">SCTrans Address:</label>
                            <input type="text" class="form-control" id="scMultiTransAddress" name="scMultiTransAddress"
                                placeholder="Shower Util SmartContract Address (0x...)" required readonly>
                        </div>

                        <div class="form-group">
                            <label for="multiAddress1">Multi Address1:</label>
                            <input type="text" class="form-control" id="multiAddress1" name="multiAddress1"
                                placeholder="Enter Manage address (0x...)" required>
                        </div>
                        <div class="form-group">
                            <label for="multiAddress2">Multi Address2:</label>
                            <input type="text" class="form-control" id="multiAddress2" name="multiAddress2"
                                placeholder="Enter Manage Address (0x...)" required>
                        </div>

                        <input type="hidden" id="scMultiTokenID" name="scMultiTokenID">
                        <!-- Three buttons in a single row -->
                        <div class="form-row">
                            <div class="col-md-4">
                                <button type="button" id="searchScMultiBtn" class="btn btn-success btn-block">Search
                                    Latest SCMulti</button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="saveScMultiBtn" class="btn btn-generate btn-block">Save
                                    SCMulti</button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="signScMultiBtn" class="btn btn-warning btn-block">Sign
                                    SCMulti</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="form-group">
                <label for="scMultiAddressDisplay"><strong>SCMulti BlockChain:</strong></label>
                <div class="input-group">
                    <input type="text" class="form-control" id="scMultiAddressDisplay" readonly>
                    <div class="input-group-append">
                        <button class="btn btn-outline-primary" type="button" onclick="refreshScMultiAddress()">
                            <i class="fas fa-sync-alt"></i> Refresh
                        </button>
                        <button class="btn btn-outline-secondary" type="button" onclick="copyScMultiAddress()">
                            <i class="fas fa-copy"></i> Copy
                        </button>
                        <button class="btn btn-outline-success" type="button" onclick="saveScMultiAddressToDB()">
                            <i class="fas fa-save"></i> Save
                        </button>
                    </div>
                </div>
                <label for="scMultiCreateTimeDisplay"><strong>SCMulti CreateTime:</strong></label>
                <div class="input-group">
                    <input type="text" class="form-control" id="scMultiCreateTimeDisplay" readonly>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-edit mr-2"></i>Step3: Generate Connections
                </div>
                <div class="card-body">
                    <form id="scConnectionForm">
                        <div class="form-group">
                            <label for="connScTransAddress">SCTrans Address:</label>
                            <input type="text" class="form-control" id="connScTransAddress" name="connScTransAddress"
                                placeholder="Show SCTrans Address (0x...)" required readonly>
                        </div>

                        <div class="form-group">
                            <label for="connScMultiAddress">SCMulti Address:</label>
                            <input type="text" class="form-control" id="connScMultiAddress" name="connScMultiAddress"
                                placeholder="Show SCMulti Address (0x...)" required readonly>
                        </div>

                        <input type="hidden" id="connTokenID" name="connTokenID">
                        <!-- Two buttons in a single row -->
                        <div class="form-row">
                            <div class="col-md-5">
                                <button type="button" id="saveConnectionsBtn" class="btn btn-generate btn-block">Save
                                    Connections
                                </button>
                            </div>
                            <div class="col-md-2">
                                <!-- Empty column for spacing -->
                            </div>
                            <div class="col-md-5">
                                <button type="button" id="signConnectionsBtn" class="btn btn-warning btn-block">Sign
                                    SCConnections</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>


            <!-- 引入脚本 -->
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

            <!-- 改为内联定义 -->
            <script>
                // 定义 CustomToken 合约的 ABI
                const customTokenABI = [
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
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "name": "burn",
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
                        "name": "mint",
                        "outputs": [],
                        "stateMutability": "nonpayable",
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
                                "name": "recipient",
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
                                "name": "sender",
                                "type": "address"
                            },
                            {
                                "internalType": "address",
                                "name": "recipient",
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

                // 定义 CustomToken 合约的字节码
                const customTokenBytecode = "608060405234801561000f575f80fd5b50604051611b60380380611b608339818101604052810190610031919061036a565b338383816003908161004391906105f6565b50806004908161005391906105f6565b5050505f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036100c6575f6040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081526004016100bd9190610704565b60405180910390fd5b6100d58161012760201b60201c565b50428111610118576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161010f9061079d565b60405180910390fd5b806006819055505050506107bb565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160055f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f604051905090565b5f80fd5b5f80fd5b5f80fd5b5f80fd5b5f601f19601f8301169050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b61024982610203565b810181811067ffffffffffffffff8211171561026857610267610213565b5b80604052505050565b5f61027a6101ea565b90506102868282610240565b919050565b5f67ffffffffffffffff8211156102a5576102a4610213565b5b6102ae82610203565b9050602081019050919050565b8281835e5f83830152505050565b5f6102db6102d68461028b565b610271565b9050828152602081018484840111156102f7576102f66101ff565b5b6103028482856102bb565b509392505050565b5f82601f83011261031e5761031d6101fb565b5b815161032e8482602086016102c9565b91505092915050565b5f819050919050565b61034981610337565b8114610353575f80fd5b50565b5f8151905061036481610340565b92915050565b5f805f60608486031215610381576103806101f3565b5b5f84015167ffffffffffffffff81111561039e5761039d6101f7565b5b6103aa8682870161030a565b935050602084015167ffffffffffffffff8111156103cb576103ca6101f7565b5b6103d78682870161030a565b92505060406103e886828701610356565b9150509250925092565b5f81519050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f600282049050600182168061044057607f821691505b602082108103610453576104526103fc565b5b50919050565b5f819050815f5260205f209050919050565b5f6020601f8301049050919050565b5f82821b905092915050565b5f600883026104b57fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8261047a565b6104bf868361047a565b95508019841693508086168417925050509392505050565b5f819050919050565b5f6104fa6104f56104f084610337565b6104d7565b610337565b9050919050565b5f819050919050565b610513836104e0565b61052761051f82610501565b848454610486565b825550505050565b5f90565b61053b61052f565b61054681848461050a565b505050565b5b818110156105695761055e5f82610533565b60018101905061054c565b5050565b601f8211156105ae5761057f81610459565b6105888461046b565b81016020851015610597578190505b6105ab6105a38561046b565b83018261054b565b50505b505050565b5f82821c905092915050565b5f6105ce5f19846008026105b3565b1980831691505092915050565b5f6105e683836105bf565b9150826002028217905092915050565b6105ff826103f2565b67ffffffffffffffff81111561061857610617610213565b5b6106228254610429565b61062d82828561056d565b5f60209050601f83116001811461065e575f841561064c578287015190505b61065685826105db565b8655506106bd565b601f19841661066c86610459565b5f5b828110156106935784890151825560018201915060208501945060208101905061066e565b868310156106b057848901516106ac601f8916826105bf565b8355505b6001600288020188555050505b505050505050565b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f6106ee826106c5565b9050919050565b6106fe816106e4565b82525050565b5f6020820190506107175f8301846106f5565b92915050565b5f82825260208201905092915050565b7f45787069726174696f6e2064617465206d75737420626520696e2074686520665f8201527f7574757265000000000000000000000000000000000000000000000000000000602082015250565b5f61078760258361071d565b91506107928261072d565b604082019050919050565b5f6020820190508181035f8301526107b48161077b565b9050919050565b611398806107c85f395ff3fe608060405234801561000f575f80fd5b50600436106100f3575f3560e01c806370a082311161009557806395d89b411161006457806395d89b411461025f578063a9059cbb1461027d578063dd62ed3e146102ad578063f2fde38b146102dd576100f3565b806370a08231146101e9578063715018a6146102195780638da5cb5b146102235780638f62048714610241576100f3565b806323b872dd116100d157806323b872dd14610163578063313ce5671461019357806340c10f19146101b157806342966c68146101cd576100f3565b806306fdde03146100f7578063095ea7b31461011557806318160ddd14610145575b5f80fd5b6100ff6102f9565b60405161010c9190610f7e565b60405180910390f35b61012f600480360381019061012a919061102f565b610389565b60405161013c9190611087565b60405180910390f35b61014d6103ab565b60405161015a91906110af565b60405180910390f35b61017d600480360381019061017891906110c8565b6103b4565b60405161018a9190611087565b60405180910390f35b61019b61040e565b6040516101a89190611133565b60405180910390f35b6101cb60048036038101906101c6919061102f565b610416565b005b6101e760048036038101906101e2919061114c565b610471565b005b61020360048036038101906101fe9190611177565b61047e565b60405161021091906110af565b60405180910390f35b6102216104c3565b005b61022b6104d6565b60405161023891906111b1565b60405180910390f35b6102496104fe565b60405161025691906110af565b60405180910390f35b610267610504565b6040516102749190610f7e565b60405180910390f35b6102976004803603810190610292919061102f565b610594565b6040516102a49190611087565b60405180910390f35b6102c760048036038101906102c291906111ca565b6105ec565b6040516102d491906110af565b60405180910390f35b6102f760048036038101906102f29190611177565b61066e565b005b60606003805461030890611235565b80601f016020809104026020016040519081016040528092919081815260200182805461033490611235565b801561037f5780601f106103565761010080835404028352916020019161037f565b820191905f5260205f20905b81548152906001019060200180831161036257829003601f168201915b5050505050905090565b5f806103936106f2565b90506103a08185856106f9565b600191505092915050565b5f600254905090565b5f6006544211156103fa576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016103f1906112af565b60405180910390fd5b61040584848461070b565b90509392505050565b5f6012905090565b61041e610739565b600654421115610463576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161045a906112af565b60405180910390fd5b61046d82826107c0565b5050565b61047b338261083f565b50565b5f805f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20549050919050565b6104cb610739565b6104d45f6108be565b565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b60065481565b60606004805461051390611235565b80601f016020809104026020016040519081016040528092919081815260200182805461053f90611235565b801561058a5780601f106105615761010080835404028352916020019161058a565b820191905f5260205f20905b81548152906001019060200180831161056d57829003601f168201915b5050505050905090565b5f6006544211156105da576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016105d1906112af565b60405180910390fd5b6105e48383610981565b905092915050565b5f60015f8473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2054905092915050565b610676610739565b5f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036106e6575f6040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081526004016106dd91906111b1565b60405180910390fd5b6106ef816108be565b50565b5f33905090565b61070683838360016109a3565b505050565b5f806107156106f2565b9050610722858285610b72565b61072d858585610c05565b60019150509392505050565b6107416106f2565b73ffffffffffffffffffffffffffffffffffffffff1661075f6104d6565b73ffffffffffffffffffffffffffffffffffffffff16146107be576107826106f2565b6040517f118cdaa70000000000000000000000000000000000000000000000000000000081526004016107b591906111b1565b60405180910390fd5b565b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610830575f6040517fec442f0500000000000000000000000000000000000000000000000000000000815260040161082791906111b1565b60405180910390fd5b61083b5f8383610cf5565b5050565b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff16036108af575f6040517f96c6fd1e0000000000000000000000000000000000000000000000000000000081526004016108a691906111b1565b60405180910390fd5b6108ba825f83610cf5565b5050565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160055f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f8061098b6106f2565b9050610998818585610c05565b600191505092915050565b5f73ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff1603610a13575f6040517fe602df05000000000000000000000000000000000000000000000000000000008152600401610a0a91906111b1565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610a83575f6040517f94280d62000000000000000000000000000000000000000000000000000000008152600401610a7a91906111b1565b60405180910390fd5b8160015f8673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f8573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20819055508015610b6c578273ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92584604051610b6391906110af565b60405180910390a35b50505050565b5f610b7d84846105ec565b90507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff811015610bff5781811015610bf0578281836040517ffb8f41b2000000000000000000000000000000000000000000000000000000008152600401610be7939291906112cd565b60405180910390fd5b610bfe84848484035f6109a3565b5b50505050565b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610c75575f6040517f96c6fd1e000000000000000000000000000000000000000000000000000000008152600401610c6c91906111b1565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610ce5575f6040517fec442f05000000000000000000000000000000000000000000000000000000008152600401610cdc91906111b1565b60405180910390fd5b610cf0838383610cf5565b505050565b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610d45578060025f828254610d39919061132f565b92505081905550610e13565b5f805f8573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2054905081811015610dce578381836040517fe450d38c000000000000000000000000000000000000000000000000000000008152600401610dc5939291906112cd565b60405180910390fd5b8181035f808673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2081905550505b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610e5a578060025f8282540392505081905550610ea4565b805f808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f82825401925050819055505b8173ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef83604051610f0191906110af565b60405180910390a3505050565b5f81519050919050565b5f82825260208201905092915050565b8281835e5f83830152505050565b5f601f19601f8301169050919050565b5f610f5082610f0e565b610f5a8185610f18565b9350610f6a818560208601610f28565b610f7381610f36565b840191505092915050565b5f6020820190508181035f830152610f968184610f46565b905092915050565b5f80fd5b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f610fcb82610fa2565b9050919050565b610fdb81610fc1565b8114610fe5575f80fd5b50565b5f81359050610ff681610fd2565b92915050565b5f819050919050565b61100e81610ffc565b8114611018575f80fd5b50565b5f8135905061102981611005565b92915050565b5f806040838503121561104557611044610f9e565b5b5f61105285828601610fe8565b92505060206110638582860161101b565b9150509250929050565b5f8115159050919050565b6110818161106d565b82525050565b5f60208201905061109a5f830184611078565b92915050565b6110a981610ffc565b82525050565b5f6020820190506110c25f8301846110a0565b92915050565b5f805f606084860312156110df576110de610f9e565b5b5f6110ec86828701610fe8565b93505060206110fd86828701610fe8565b925050604061110e8682870161101b565b9150509250925092565b5f60ff82169050919050565b61112d81611118565b82525050565b5f6020820190506111465f830184611124565b92915050565b5f6020828403121561116157611160610f9e565b5b5f61116e8482850161101b565b91505092915050565b5f6020828403121561118c5761118b610f9e565b5b5f61119984828501610fe8565b91505092915050565b6111ab81610fc1565b82525050565b5f6020820190506111c45f8301846111a2565b92915050565b5f80604083850312156111e0576111df610f9e565b5b5f6111ed85828601610fe8565b92505060206111fe85828601610fe8565b9150509250929050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f600282049050600182168061124c57607f821691505b60208210810361125f5761125e611208565b5b50919050565b7f546f6b656e2068617320657870697265640000000000000000000000000000005f82015250565b5f611299601183610f18565b91506112a482611265565b602082019050919050565b5f6020820190508181035f8301526112c68161128d565b9050919050565b5f6060820190506112e05f8301866111a2565b6112ed60208301856110a0565b6112fa60408301846110a0565b949350505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61133982610ffc565b915061134483610ffc565b925082820190508082111561135c5761135b611302565b5b9291505056fea2646970667358221220ac3270f8cde7256a31da7573f165e79fda861eae6a37bd8f0fb516deec8938fc64736f6c634300081a0033";

                // 测试 customTokenABI 和 customTokenBytecode 是否可用
                //  console.log("customTokenABI defined:", typeof customTokenABI !== 'undefined');
                //  console.log("customTokenBytecode defined:", typeof customTokenBytecode !== 'undefined');
            </script>

            <!-- Web3 集成脚本 -->
            <script>
                // 全局变量
                let web3;
                let contract;
                let userAddress;

                document.addEventListener('DOMContentLoaded', () => {
                    // 连接钱包按钮
                    document.getElementById('connectWalletBtn').addEventListener('click', connectWallet);
                    // 在 DOMContentLoaded 事件监听器内添加这行代码 
                    document.getElementById('signContractBtn').addEventListener('click', deployCustomTokenContract);
                    document.getElementById('saveContractBtn').addEventListener('click', saveContractToDatabase);
                    document.getElementById('searchSCBtn').addEventListener('click', searchSCFromDB);
                    // Add this line to automatically load the latest token on page load


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
                            document.getElementById('recipientAddress').value = walletAddress;

                        } catch (error) {
                            console.error("Failed to connect wallet:", error);
                            alert("Failed to connect wallet: " + error.message);
                        }
                    } else {
                        alert("MetaMask is not installed. Please install it to use this feature.");
                    }
                }


                function searchSCFromDB() {
                    // Show loading status
                    showStatus("Searching for latest contract...");

                    // Get wallet address if connected
                    const walletAddress = userAddress || '';

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
                                // Display the result
                                const token = data.token;

                                document.getElementById('tokenID').value = token.tokenID;
                                document.getElementById('tokenName').value = token.tokenName;
                                document.getElementById('tokenSymbol').value = token.tokenSymbol;
                                document.getElementById('invalidDate').value = token.scexpireDate;

                                // Display creation time if available
                                if (token.sccreateTime) {
                                    document.getElementById('creationTime').value = token.sccreateTime;
                                    // Make the creation time field visible
                                    const creationTimeContainer = document.getElementById('creationTimeContainer');
                                    if (creationTimeContainer) {
                                        creationTimeContainer.style.display = 'block';
                                    }
                                }

                                // Update contract address if available
                                if (token.genContractAddr) {
                                    document.getElementById('contractAddressDisplay').value = token.genContractAddr;
                                    // Make the contract address field visible
                                    const addressContainer = document.getElementById('contractAddressDisplay').parentElement;
                                    if (addressContainer) {
                                        addressContainer.style.display = 'flex';
                                    }
                                }

                                showStatus("Latest contract loaded successfully");
                            } else {
                                // Show the message that allows manual creation
                                showStatus(data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error searching contract:', error);
                            showStatus("Failed to search contract: " + error.message, true);
                        });
                }


                function saveContractToDatabase() {
                    if (!userAddress) {
                        showStatus("Please connect wallet   first", true);
                        return;
                    }

                    // Get form data
                    const tokenName = document.getElementById('tokenName').value;
                    const tokenSymbol = document.getElementById('tokenSymbol').value;
                    const contractAddress = document.getElementById('contractAddressDisplay').value;
                    const invalidDate = document.getElementById('invalidDate').value;
                    // const amount = document.getElementById('amount').value || '0'; // Default to 0 if empty
                    //  const memo = document.getElementById('memo') ? document.getElementById('memo').value : '';

                    // Add debugging
                    console.log("userAddress:", userAddress);
                    console.log("tokenName:", tokenName);
                    console.log("tokenSymbol:", tokenSymbol);
                    console.log("invalidDate:", invalidDate);
                    console.log("contractAddress:", contractAddress);



                    // Validate required fields
                    if (!tokenName || !tokenSymbol || !invalidDate) {
                        showStatus("The fields are required to save contract", true);
                        return;
                    }

                    const confirmSave = confirm("Are you sure  to savthis contract to the database?");
                    if (!confirmSave) {
                        showStatus("Save operation cancelled", true);
                        return; // Exit the function if user cancels
                    }
                    showStatus("Saving contract to database...");

                    const params = new URLSearchParams();
                    params.append("owerAddr", userAddress);
                    params.append("tokenName", tokenName);
                    params.append("tokenSymbol", tokenSymbol);
                    params.append("scexpireDate", invalidDate);
                    params.append("genContractAddr", contractAddress || '');


                    console.log("Sending data:", Object.fromEntries(params));
                    fetch('saveToken', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: params.toString()  // Convert to string - important!
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                showStatus("Contract saved to database successfully!");
                            } else {
                                showStatus("Error saving contract: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error saving contract:', error);
                            showStatus("Failed to save contract: " + error.message, true);
                        });
                }

                function copyContractAddress() {
                    const contractAddressEl = document.getElementById('contractAddressDisplay');
                    contractAddressEl.select();
                    document.execCommand('copy');
                    alert('Contract address copied to clipboard!');
                }


                async function deployCustomTokenContract() {
                    if (!web3 || !userAddress) {
                        showStatus("Wallet not connected. Please connect your wallet first.", true);
                        return false;
                    }

                    try {
                        // Get form values
                        const tokenName = document.getElementById('tokenName').value;
                        const tokenSymbol = document.getElementById('tokenSymbol').value;
                        const invalidDate = document.getElementById('invalidDate').value;

                        // Validate form values
                        if (!tokenName || !tokenSymbol || !invalidDate) {
                            showStatus("Please fill in all required fields", true);
                            return false;
                        }

                        // Convert date to timestamp (seconds)
                        const invalidDateTimestamp = Math.floor(new Date(invalidDate).getTime() / 1000);

                        // Show status message
                        showStatus("Preparing to deploy contract...");

                        // Fix bytecode - ensure even length
                        let cleanBytecode = customTokenBytecode;
                        if (cleanBytecode.startsWith("0x")) {
                            cleanBytecode = cleanBytecode.substring(2);
                        }

                        // Ensure bytecode has even length
                        if (cleanBytecode.length % 2 !== 0) {
                            cleanBytecode = cleanBytecode.substring(0, cleanBytecode.length - 1);
                        }

                        // Restore 0x prefix
                        cleanBytecode = "0x" + cleanBytecode;

                        // 先定义合约对象
                        const TokenContract = new web3.eth.Contract(customTokenABI);

                        showStatus("Deploying contract, please confirm the transaction...");

                        try {
                            // 直接使用固定gas和较高的gasLimit进行部署
                            const deployedContract = await TokenContract.deploy({
                                data: cleanBytecode,
                                arguments: [tokenName, tokenSymbol, invalidDateTimestamp]
                            }).send({
                                from: userAddress,
                                gas: 3000000, // 固定较大的gas数量
                                gasPrice: await web3.eth.getGasPrice() // 使用当前gas价格
                            });

                            // 添加调试信息
                            console.log("Contract deployed successfully!");
                            console.log("Contract address:", deployedContract.options.address);

                            const newTokenAddress = deployedContract.options.address;

                            // 确保合约地址显示在UI上
                            const addressField = document.getElementById('contractAddressDisplay');
                            if (addressField) {
                                addressField.value = newTokenAddress;
                                console.log("Set address field value to:", newTokenAddress);

                                // 确保父元素显示
                                const parentElement = addressField.parentElement;
                                if (parentElement) {
                                    parentElement.style.display = 'flex'; // 使用flex而不是block以确保布局正确
                                    console.log("Set parent element display to flex");
                                } else {
                                    console.error("Could not find parent element of address field");
                                }
                            } else {
                                console.error("Could not find contractAddressDisplay element");
                            }

                            // 更新状态
                            showStatus(`Contract deployed successfully! Token address: ${newTokenAddress}`);
                            document.getElementById('contractAddressDisplay').value = newTokenAddress;
                            document.getElementById('contractAddressDisplay').parentElement.style.display = 'block';

                            // 保存合约实例
                            contract = deployedContract;

                            // 启用铸币按钮
                            document.querySelector('.btn-generate').disabled = false;

                            return true;
                        } catch (txError) {
                            console.error("Transaction error:", txError);
                            showStatus(`Transaction failed: ${txError.message}`, true);
                            return false;
                        }
                    } catch (error) {
                        console.error("Error deploying contract:", error);
                        showStatus(`Error deploying contract: ${error.message}`, true);
                        return false;
                    }
                }


            </script>

            <script>
                async function refreshContractAddress() {
                    if (!web3) {
                        showStatus("Web3 not initialized. Please connect your wallet first.", true);
                        return;
                    }

                    try {
                        // Define the target address
                        //  const targetAddress = "0xc8c632da94924456d96c6ad801f22e7ae9716d55";

                        const targetAddress = userAddress;
                        // Ensure the target address is valid
                        if (!web3.utils.isAddress(targetAddress)) {
                            throw new Error("Invalid target address format");
                        }

                        // Log the target address
                        console.log("Using target address:", targetAddress);

                        // Show status
                        showStatus(`Searching for contracts deployed by ${targetAddress}...`);
                        console.log("Starting blockchain query for contract address");

                        try {
                            // Construct the API URL
                            // const apiUrl = `https://api-amoy.polygonscan.com/api?module=account&action=txlist&address=${targetAddress}&sort=desc`;
                            //const apiUrl = "https://api-amoy.polygonscan.com/api?module=account&action=txlist&address=0xc8c632da94924456d96c6ad801f22e7ae9716d55&sort=desc";
                            const apiUrl = "https://api-amoy.polygonscan.com/api?module=account&action=txlist&address=" + targetAddress + "&sort=desc&limit=20";
                            console.log("Requesting data from blockchain API:", apiUrl);

                            // Fetch data from the API
                            const response = await fetch(apiUrl);
                            if (!response.ok) {
                                throw new Error(`API responded with status: ${response.status}`);
                            }

                            const data = await response.json();
                            console.log("API Response:", data);

                            if (data.status === "1" && data.result && data.result.length > 0) {
                                console.log(`Found ${data.result.length} transactions`);

                                // Filter for contract creation transactions
                                const contractCreationTxs = data.result.filter(tx =>
                                    (!tx.to || tx.to === '') &&
                                    tx.contractAddress &&
                                    tx.contractAddress !== ''
                                );

                                console.log(`Found ${contractCreationTxs.length} contract creation transactions`);

                                if (contractCreationTxs.length > 0) {
                                    // Get the most recent contract
                                    const latestTx = contractCreationTxs[0];
                                    const contractAddress = latestTx.contractAddress;

                                    console.log(`Found contract: ${contractAddress} created at block ${latestTx.blockNumber}`);
                                    document.getElementById('contractAddressDisplay').value = contractAddress;
                                    showStatus(`Found contract: ${contractAddress} (Block: ${latestTx.blockNumber})`);
                                    if (latestTx.timeStamp) {
                                        const timestamp = parseInt(latestTx.timeStamp);
                                        const date = new Date(timestamp * 1000); // Convert to milliseconds
                                        // const formattedDate = date.toLocaleString(); // Format date as local string
                                        const formattedDate = date.toLocaleString('en-US', {
                                            year: 'numeric',
                                            month: '2-digit',
                                            day: '2-digit',
                                            hour: '2-digit',
                                            minute: '2-digit',
                                            second: '2-digit',
                                            hour12: false
                                        }).replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$1-$2'); // Convert MM/DD/YYYY to YYYY-MM-DD

                                        // Update the SC Create Time display
                                        document.getElementById('scCreateTimeDisplay').value = formattedDate;
                                        console.log("Contract creation time:", formattedDate);
                                    }
                                    // Create contract instance
                                    try {
                                        contract = new web3.eth.Contract(customTokenABI, contractAddress);
                                        console.log("Contract instance created successfully");
                                    } catch (contractError) {
                                        console.error("Error creating contract instance:", contractError);
                                        showStatus(`Found contract address but couldn't initialize it: ${contractError.message}`, true);
                                    }
                                } else {
                                    console.log("No contract creation transactions found");
                                    showStatus("No contract creation transactions found for this address", true);
                                }
                            } else {
                                console.error("API returned no results or error:", data);
                                showStatus("Blockchain API returned no results or error", true);
                            }
                        } catch (apiError) {
                            console.error("API request failed:", apiError);
                            showStatus(`Blockchain query failed: ${apiError.message}`, true);
                        }
                    } catch (error) {
                        console.error("Error searching for contract address:", error);
                        showStatus(`Error: ${error.message}`, true);
                    }
                }

                function copyContractAddress() {
                    const contractAddressEl = document.getElementById('contractAddressDisplay');
                    const address = contractAddressEl.value.trim();

                    // Check if address exists
                    if (!address) {
                        showStatus("No contract address to copy. Please deploy or refresh a contract first.", true);
                        return;
                    }

                    // Copy to clipboard
                    contractAddressEl.select();
                    document.execCommand('copy');
                    showStatus(`Contract address copied: ${address}`);
                }


                function saveSCAddress2DB() {
                    // Get token ID and contract address
                    const tokenId = document.getElementById('tokenID').value;
                    const contractAddress = document.getElementById('contractAddressDisplay').value;

                    // Validate values
                    if (!tokenId) {
                        showStatus("Error! Please search the latest SC first.", true);
                        return;
                    }

                    if (!contractAddress) {
                        showStatus("No sc address to save. Please  refresh  first.", true);
                        return;
                    }

                    // Ask for confirmation
                    const confirmSave = confirm("Are you sure to update this contract address in the database?");
                    if (!confirmSave) {
                        showStatus("Update operation cancelled", true);
                        return;
                    }

                    // Show saving status
                    showStatus("Updating contract address in database...");

                    // Create form data
                    const params = new URLSearchParams();
                    params.append("tokenId", tokenId);
                    params.append("contractAddress", contractAddress);

                    // Send update request
                    fetch('updateSCAddress', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: params.toString()
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                showStatus("Contract address updated successfully!");
                            } else {
                                showStatus("Error updating contract address: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error updating contract address:', error);
                            showStatus("Failed to update contract address: " + error.message, true);
                        });
                }


            </script>

            <!-- Footer -->
            <div class="footer">
                <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
            </div>
    </body>

    </html>