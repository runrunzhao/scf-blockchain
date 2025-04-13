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
                            <p><strong>Invalid Date:</strong> Dec 31, 2026</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
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
                        <div class="form-row mb-3">
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
                        <div class="form-row mb-4">
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
                        <div class="form-row mb-4">
                            <div class="col-md-4">
                                <button type="button" id="searchSCTransBtn" class="btn btn-success btn-block">
                                    <i class="fas fa-search mr-1"></i> Search Latest SCTrans from Server
                                </button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="saveScTransBtn" class="btn btn-generate btn-block">
                                    <i class="fas fa-save mr-1"></i> Save SCTrans to Server
                                </button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="deployScTransBtn" class="btn btn-warning btn-block">
                                    <i class="fas fa-signature mr-1"></i> Deploy SCTrans on Blockchain
                                </button>
                            </div>
                        </div>

                        <!-- Contract Address Display Section -->
                        <hr class="my-4">

                        <div class="card bg-light">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="scTransAddressDisplay"><strong>SCTrans BlockChain:</strong></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="scTransAddressDisplay" readonly>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-primary" type="button"
                                                onclick="refreshScTransAddress()">
                                                <i class="fas fa-sync-alt"></i> Refresh
                                            </button>
                                            <button class="btn btn-outline-secondary" type="button"
                                                onclick="copySCTransAddress()">
                                                <i class="fas fa-copy"></i> CopySCTransAddress
                                            </button>
                                            <button class="btn btn-outline-success" type="button"
                                                onclick="saveSCTransAddress2DB()">
                                                <i class="fas fa-save"></i> saveSCTransAddress2DB
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group mb-0">
                                    <label for="scTransCreateTimeDisplay"><strong>SCTrans CreateTime:</strong></label>
                                    <input type="text" class="form-control" id="scTransCreateTimeDisplay" readonly>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <i class="fas fa-edit mr-2"></i>Step2: Generate Manage SC (Multi-Sig)
                </div>
                <div class="card-body">
                    <form id="scMultiForm">
                        <div class="form-group">
                            <label for="scMultiTransAddress">SCTrans Address:</label>
                            <input type="text" class="form-control" id="scMultiTransAddress" name="scMultiTransAddress"
                                placeholder="Shower Util SmartContract Address (0x...)" required readonly>
                        </div>

                        <div class="form-row mb-4">
                            <div class="form-group col-md-6">
                                <label for="multiAddress1">Multi Address1:</label>
                                <input type="text" class="form-control" id="multiAddress1" name="multiAddress1"
                                    placeholder="Enter Manage address (0x...)" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="multiAddress2">Multi Address2:</label>
                                <input type="text" class="form-control" id="multiAddress2" name="multiAddress2"
                                    placeholder="Enter Manage Address (0x...)" required>
                            </div>
                        </div>

                        <input type="hidden" id="scMultiTokenID" name="scMultiTokenID">
                        <!-- Three buttons in a single row -->
                        <div class="form-row mb-4">
                            <div class="col-md-4">
                                <button type="button" id="searchScMultiBtn" class="btn btn-success btn-block">
                                    <i class="fas fa-search mr-1"></i> Search Latest SCMulti from Server
                                </button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="saveScMultiBtn" class="btn btn-generate btn-block">
                                    <i class="fas fa-save mr-1"></i> Save SCMulti to Server
                                </button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="deployScMultiBtn" class="btn btn-warning btn-block">
                                    <i class="fas fa-signature mr-1"></i> Deploy SCMulti on Blockchain
                                </button>
                            </div>
                        </div>

                        <!-- Contract Address Display Section -->
                        <hr class="my-4">

                        <div class="card bg-light">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="scMultiAddressDisplay"><strong>SCMulti BlockChain:</strong></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="scMultiAddressDisplay" readonly>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-primary" type="button"
                                                onclick="refreshScMultiAddress()">
                                                <i class="fas fa-sync-alt"></i> Refresh
                                            </button>
                                            <button class="btn btn-outline-secondary" type="button"
                                                onclick="copyScMultiAddress()">
                                                <i class="fas fa-copy"></i> CopySCMultiAddress
                                            </button>
                                            <button class="btn btn-outline-success" type="button"
                                                onclick="saveSCMultiAddress2DB()">
                                                <i class="fas fa-save"></i> saveSCMultiAddress2DB
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group mb-0">
                                    <label for="scMultiCreateTimeDisplay"><strong>SCMulti CreateTime:</strong></label>
                                    <input type="text" class="form-control" id="scMultiCreateTimeDisplay" readonly>
                                </div>
                            </div>
                        </div>
                    </form>
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

                        <input type="hidden" id="connectionID" name="connectionID">
                        <!-- Two buttons in a single row -->
                        <div class="form-row">
                            <div class="col-md-4">
                                <button type="button" id="searchSCConnectionsBtn"
                                    class="btn btn-generate btn-block">Search
                                    Connections from Server
                                </button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="saveSCConnectionsBtn" class="btn btn-generate btn-block">Save
                                    Connections to Server
                                </button>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="signSCConnectionsBtn" class="btn btn-warning btn-block">Sign
                                    SCConnections on Blockchain</button>
                            </div>
                        </div>
                        <hr class="my-4">

                        <div class="card bg-light">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="signTx"><strong>signTx BlockChain:</strong></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="signTx" readonly>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-primary" type="button"
                                                onclick="refreshSignTx()">
                                                <i class="fas fa-sync-alt"></i> Refresh
                                            </button>
                                            <button class="btn btn-outline-secondary" type="button"
                                                onclick="copySignTx()">
                                                <i class="fas fa-copy"></i> CopySignConnectionsTx
                                            </button>
                                            <button class="btn btn-outline-success" type="button"
                                                onclick="saveSignTx2DB()">
                                                <i class="fas fa-save"></i> saveSignTx2DB
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group mb-0">
                                    <label for="signTxTimeDisplay"><strong>signTx CreateTime:</strong></label>
                                    <input type="text" class="form-control" id="signTxCreateTimeDisplay" readonly>
                                </div>
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


                const customTokenMultiBytecode = "608060405234801561000f575f80fd5b50604051612eaa380380612eaa8339818101604052810190610031919061066a565b335f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036100a2575f6040517f1e4fbdf700000000000000000000000000000000000000000000000000000000815260040161009991906106e5565b60405180910390fd5b6100b1816103bb60201b60201c565b505f8251116100f5576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016100ec90610758565b60405180910390fd5b5f81118015610105575081518111155b610144576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161013b906107c0565b60405180910390fd5b8260015f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550806002819055505f5b82518110156103b2575f8382815181106101aa576101a96107de565b5b602002602001015190505f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff1603610222576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161021990610855565b60405180910390fd5b60035f8273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff16156102ac576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016102a3906108bd565b60405180910390fd5b600160035f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f6101000a81548160ff021916908315150217905550600481908060018154018082558091505060019003905f5260205f20015f9091909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508073ffffffffffffffffffffffffffffffffffffffff167f47d1c22a25bb3a5d4e481b9b1e6944c2eade3181a0a20b495ed61d35b5323f2460405160405180910390a250808060010191505061018d565b505050506108db565b5f805f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff169050815f806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f604051905090565b5f80fd5b5f80fd5b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f6104b68261048d565b9050919050565b6104c6816104ac565b81146104d0575f80fd5b50565b5f815190506104e1816104bd565b92915050565b5f80fd5b5f601f19601f8301169050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b610531826104eb565b810181811067ffffffffffffffff821117156105505761054f6104fb565b5b80604052505050565b5f61056261047c565b905061056e8282610528565b919050565b5f67ffffffffffffffff82111561058d5761058c6104fb565b5b602082029050602081019050919050565b5f80fd5b5f6105b46105af84610573565b610559565b905080838252602082019050602084028301858111156105d7576105d661059e565b5b835b8181101561060057806105ec88826104d3565b8452602084019350506020810190506105d9565b5050509392505050565b5f82601f83011261061e5761061d6104e7565b5b815161062e8482602086016105a2565b91505092915050565b5f819050919050565b61064981610637565b8114610653575f80fd5b50565b5f8151905061066481610640565b92915050565b5f805f6060848603121561068157610680610485565b5b5f61068e868287016104d3565b935050602084015167ffffffffffffffff8111156106af576106ae610489565b5b6106bb8682870161060a565b92505060406106cc86828701610656565b9150509250925092565b6106df816104ac565b82525050565b5f6020820190506106f85f8301846106d6565b92915050565b5f82825260208201905092915050565b7f5369676e657273207265717569726564000000000000000000000000000000005f82015250565b5f6107426010836106fe565b915061074d8261070e565b602082019050919050565b5f6020820190508181035f83015261076f81610736565b9050919050565b7f496e76616c696420636f6e6669726d6174696f6e7300000000000000000000005f82015250565b5f6107aa6015836106fe565b91506107b582610776565b602082019050919050565b5f6020820190508181035f8301526107d78161079e565b9050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b7f496e76616c6964207369676e65720000000000000000000000000000000000005f82015250565b5f61083f600e836106fe565b915061084a8261080b565b602082019050919050565b5f6020820190508181035f83015261086c81610833565b9050919050565b7f5369676e6572206e6f7420756e697175650000000000000000000000000000005f82015250565b5f6108a76011836106fe565b91506108b282610873565b602082019050919050565b5f6020820190508181035f8301526108d48161089b565b9050919050565b6125c2806108e85f395ff3fe608060405234801561000f575f80fd5b5060043610610140575f3560e01c806382e717f7116100b6578063c01a8c841161007a578063c01a8c84146103a4578063c4a7a24e146103c0578063d42f2f35146103f0578063eb12d61e1461040e578063ee22610b1461042a578063f2fde38b1461044657610140565b806382e717f7146102e65780638da5cb5b146103045780639ace38c2146103225780639dcfdda414610356578063b715be811461038657610140565b8063382ad19911610108578063382ad1991461021257806355a373d614610242578063715018a6146102605780637698a75c1461026a5780637df73e271461028657806380f59a65146102b657610140565b806307cc98d4146101445780630e316ab7146101745780632079fb9a146101905780632e7700f0146101c057806333ea3dc8146101de575b5f80fd5b61015e60048036038101906101599190611b48565b610462565b60405161016b9190611b95565b60405180910390f35b61018e60048036038101906101899190611bae565b6104ff565b005b6101aa60048036038101906101a59190611bd9565b6107ed565b6040516101b79190611c13565b60405180910390f35b6101c8610828565b6040516101d59190611b95565b60405180910390f35b6101f860048036038101906101f39190611bd9565b610834565b604051610209959493929190611cb9565b60405180910390f35b61022c60048036038101906102279190611d0a565b610907565b6040516102399190611d48565b60405180910390f35b61024a6109b0565b6040516102579190611dbc565b60405180910390f35b6102686109d5565b005b610284600480360381019061027f9190611bd9565b6109e8565b005b6102a0600480360381019061029b9190611bae565b610ac4565b6040516102ad9190611d48565b60405180910390f35b6102d060048036038101906102cb9190611d0a565b610ae1565b6040516102dd9190611d48565b60405180910390f35b6102ee610b0b565b6040516102fb9190611b95565b60405180910390f35b61030c610b11565b6040516103199190611c13565b60405180910390f35b61033c60048036038101906103379190611bd9565b610b38565b60405161034d959493929190611cb9565b60405180910390f35b610370600480360381019061036b9190611b48565b610bb1565b60405161037d9190611b95565b60405180910390f35b61038e610c4f565b60405161039b9190611b95565b60405180910390f35b6103be60048036038101906103b99190611bd9565b610c5b565b005b6103da60048036038101906103d59190611b48565b610f17565b6040516103e79190611b95565b60405180910390f35b6103f8610fb5565b6040516104059190611e8c565b60405180910390f35b61042860048036038101906104239190611bae565b611040565b005b610444600480360381019061043f9190611bd9565b61123b565b005b610460600480360381019061045b9190611bae565b6116a8565b005b5f60035f3373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff166104ec576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016104e390611f06565b60405180910390fd5b6104f783835f61172c565b905092915050565b610507611968565b60035f8273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff16610590576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161058790611f06565b60405180910390fd5b600254600480549050116105d9576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016105d090611f94565b60405180910390fd5b5f60035f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f6101000a81548160ff0219169083151502179055505f5b6004805490508110156107a6578173ffffffffffffffffffffffffffffffffffffffff166004828154811061066757610666611fb2565b5b905f5260205f20015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff160361079957600460016004805490506106be919061200c565b815481106106cf576106ce611fb2565b5b905f5260205f20015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff166004828154811061070b5761070a611fb2565b5b905f5260205f20015f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060048054806107625761076161203f565b5b600190038181905f5260205f20015f6101000a81549073ffffffffffffffffffffffffffffffffffffffff021916905590556107a6565b808060010191505061062f565b508073ffffffffffffffffffffffffffffffffffffffff167f3525e22824a8a7df2c9a6029941c824cf95b6447f1e13d5128fd3826d35afe8b60405160405180910390a250565b600481815481106107fc575f80fd5b905f5260205f20015f915054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b5f600580549050905090565b5f805f805f6005805490508610610880576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610877906120b6565b60405180910390fd5b5f6005878154811061089557610894611fb2565b5b905f5260205f2090600402019050805f015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff168160010154826002015f9054906101000a900460ff168360020160019054906101000a900460ff168460030154955095509550955095505091939590929450565b5f600580549050831061094f576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610946906120b6565b60405180910390fd5b60065f8481526020019081526020015f205f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff16905092915050565b60015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6109dd611968565b6109e65f6119ef565b565b6109f0611968565b5f8111610a32576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610a299061211e565b60405180910390fd5b600480549050811115610a7a576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610a7190612186565b60405180910390fd5b5f6002549050816002819055507f46c34fea7ed20f668890245de1733dbcc8a05baeeabd4d4bfdd14bfc59bba6648183604051610ab89291906121a4565b60405180910390a15050565b6003602052805f5260405f205f915054906101000a900460ff1681565b6006602052815f5260405f20602052805f5260405f205f915091509054906101000a900460ff1681565b60025481565b5f805f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b60058181548110610b47575f80fd5b905f5260205f2090600402015f91509050805f015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690806001015490806002015f9054906101000a900460ff16908060020160019054906101000a900460ff16908060030154905085565b5f60035f3373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff16610c3b576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610c3290611f06565b60405180910390fd5b610c478383600161172c565b905092915050565b5f600480549050905090565b60035f3373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff16610ce4576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610cdb90611f06565b60405180910390fd5b6005805490508110610d2b576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610d22906120b6565b60405180910390fd5b5f60058281548110610d4057610d3f611fb2565b5b905f5260205f20906004020190508060020160019054906101000a900460ff1615610da0576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610d9790612215565b60405180910390fd5b60065f8381526020019081526020015f205f3373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff1615610e39576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610e309061227d565b60405180910390fd5b600160065f8481526020019081526020015f205f3373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f6101000a81548160ff0219169083151502179055506001816003015f828254610eb1919061229b565b925050819055503373ffffffffffffffffffffffffffffffffffffffff16827f15c2f311c9e0f53b50388279894aeff029a3457884a6601e924fca879e12adcc60405160405180910390a3600254816003015410610f1357610f128261123b565b5b5050565b5f60035f3373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff16610fa1576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610f9890611f06565b60405180910390fd5b610fad8383600261172c565b905092915050565b6060600480548060200260200160405190810160405280929190818152602001828054801561103657602002820191905f5260205f20905b815f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019060010190808311610fed575b5050505050905090565b611048611968565b5f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036110b6576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016110ad90612318565b60405180910390fd5b60035f8273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f9054906101000a900460ff1615611140576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161113790612380565b60405180910390fd5b600160035f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f6101000a81548160ff021916908315150217905550600481908060018154018082558091505060019003905f5260205f20015f9091909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508073ffffffffffffffffffffffffffffffffffffffff167f47d1c22a25bb3a5d4e481b9b1e6944c2eade3181a0a20b495ed61d35b5323f2460405160405180910390a250565b6005805490508110611282576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401611279906120b6565b60405180910390fd5b5f6005828154811061129757611296611fb2565b5b905f5260205f20906004020190508060020160019054906101000a900460ff16156112f7576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016112ee90612215565b60405180910390fd5b60025481600301541015611340576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401611337906123e8565b60405180910390fd5b60018160020160016101000a81548160ff0219169083151502179055505f80600281111561137157611370611c2c565b5b826002015f9054906101000a900460ff16600281111561139457611393611c2c565b5b036114515760015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16632b3b8499835f015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1684600101546040518363ffffffff1660e01b815260040161141b929190612406565b5f604051808303815f87803b158015611432575f80fd5b505af1158015611444573d5f803e3d5ffd5b5050505060019050611636565b6001600281111561146557611464611c2c565b5b826002015f9054906101000a900460ff16600281111561148857611487611c2c565b5b036115455760015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663cd13d3df835f015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1684600101546040518363ffffffff1660e01b815260040161150f929190612406565b5f604051808303815f87803b158015611526575f80fd5b505af1158015611538573d5f803e3d5ffd5b5050505060019050611635565b60028081111561155857611557611c2c565b5b826002015f9054906101000a900460ff16600281111561157b5761157a611c2c565b5b036116345760015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663cd13d3df835f015f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1684600101546040518363ffffffff1660e01b8152600401611602929190612406565b5f604051808303815f87803b158015611619575f80fd5b505af115801561162b573d5f803e3d5ffd5b50505050600190505b5b5b80611676576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161166d90612477565b60405180910390fd5b827f15ed165a284872ea7017f03df402a0cadfbfab588320ffaf83f160c2f82781c760405160405180910390a2505050565b6116b0611968565b5f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff1603611720575f6040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081526004016117179190611c13565b60405180910390fd5b611729816119ef565b50565b5f8073ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff160361179b576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401611792906124df565b60405180910390fd5b5f83116117dd576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016117d490612547565b60405180910390fd5b600580549050905060056040518060a001604052808673ffffffffffffffffffffffffffffffffffffffff16815260200185815260200184600281111561182757611826611c2c565b5b81526020015f151581526020015f815250908060018154018082558091505060019003905f5260205f2090600402015f909190919091505f820151815f015f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550602082015181600101556040820151816002015f6101000a81548160ff021916908360028111156118d6576118d5611c2c565b5b021790555060608201518160020160016101000a81548160ff0219169083151502179055506080820151816003015550508373ffffffffffffffffffffffffffffffffffffffff16817f7b118f820c4e021e3f79a1e38f92ecd8e6d201b6f0374196a81b94547bb070b68585604051611950929190612565565b60405180910390a361196181610c5b565b9392505050565b611970611ab0565b73ffffffffffffffffffffffffffffffffffffffff1661198e610b11565b73ffffffffffffffffffffffffffffffffffffffff16146119ed576119b1611ab0565b6040517f118cdaa70000000000000000000000000000000000000000000000000000000081526004016119e49190611c13565b60405180910390fd5b565b5f805f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff169050815f806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f33905090565b5f80fd5b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f611ae482611abb565b9050919050565b611af481611ada565b8114611afe575f80fd5b50565b5f81359050611b0f81611aeb565b92915050565b5f819050919050565b611b2781611b15565b8114611b31575f80fd5b50565b5f81359050611b4281611b1e565b92915050565b5f8060408385031215611b5e57611b5d611ab7565b5b5f611b6b85828601611b01565b9250506020611b7c85828601611b34565b9150509250929050565b611b8f81611b15565b82525050565b5f602082019050611ba85f830184611b86565b92915050565b5f60208284031215611bc357611bc2611ab7565b5b5f611bd084828501611b01565b91505092915050565b5f60208284031215611bee57611bed611ab7565b5b5f611bfb84828501611b34565b91505092915050565b611c0d81611ada565b82525050565b5f602082019050611c265f830184611c04565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602160045260245ffd5b60038110611c6a57611c69611c2c565b5b50565b5f819050611c7a82611c59565b919050565b5f611c8982611c6d565b9050919050565b611c9981611c7f565b82525050565b5f8115159050919050565b611cb381611c9f565b82525050565b5f60a082019050611ccc5f830188611c04565b611cd96020830187611b86565b611ce66040830186611c90565b611cf36060830185611caa565b611d006080830184611b86565b9695505050505050565b5f8060408385031215611d2057611d1f611ab7565b5b5f611d2d85828601611b34565b9250506020611d3e85828601611b01565b9150509250929050565b5f602082019050611d5b5f830184611caa565b92915050565b5f819050919050565b5f611d84611d7f611d7a84611abb565b611d61565b611abb565b9050919050565b5f611d9582611d6a565b9050919050565b5f611da682611d8b565b9050919050565b611db681611d9c565b82525050565b5f602082019050611dcf5f830184611dad565b92915050565b5f81519050919050565b5f82825260208201905092915050565b5f819050602082019050919050565b611e0781611ada565b82525050565b5f611e188383611dfe565b60208301905092915050565b5f602082019050919050565b5f611e3a82611dd5565b611e448185611ddf565b9350611e4f83611def565b805f5b83811015611e7f578151611e668882611e0d565b9750611e7183611e24565b925050600181019050611e52565b5085935050505092915050565b5f6020820190508181035f830152611ea48184611e30565b905092915050565b5f82825260208201905092915050565b7f4e6f742061207369676e657200000000000000000000000000000000000000005f82015250565b5f611ef0600c83611eac565b9150611efb82611ebc565b602082019050919050565b5f6020820190508181035f830152611f1d81611ee4565b9050919050565b7f43616e6e6f742068617665206665776572207369676e657273207468616e20725f8201527f6571756972656420636f6e6669726d6174696f6e730000000000000000000000602082015250565b5f611f7e603583611eac565b9150611f8982611f24565b604082019050919050565b5f6020820190508181035f830152611fab81611f72565b9050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61201682611b15565b915061202183611b15565b925082820390508181111561203957612038611fdf565b5b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603160045260245ffd5b7f5472616e73616374696f6e20646f6573206e6f742065786973740000000000005f82015250565b5f6120a0601a83611eac565b91506120ab8261206c565b602082019050919050565b5f6020820190508181035f8301526120cd81612094565b9050919050565b7f4d757374206265203e20300000000000000000000000000000000000000000005f82015250565b5f612108600b83611eac565b9150612113826120d4565b602082019050919050565b5f6020820190508181035f830152612135816120fc565b9050919050565b7f43616e6e6f7420657863656564207369676e657220636f756e740000000000005f82015250565b5f612170601a83611eac565b915061217b8261213c565b602082019050919050565b5f6020820190508181035f83015261219d81612164565b9050919050565b5f6040820190506121b75f830185611b86565b6121c46020830184611b86565b9392505050565b7f5472616e73616374696f6e20616c7265616479206578656375746564000000005f82015250565b5f6121ff601c83611eac565b915061220a826121cb565b602082019050919050565b5f6020820190508181035f83015261222c816121f3565b9050919050565b7f5472616e73616374696f6e20616c726561647920636f6e6669726d65640000005f82015250565b5f612267601d83611eac565b915061227282612233565b602082019050919050565b5f6020820190508181035f8301526122948161225b565b9050919050565b5f6122a582611b15565b91506122b083611b15565b92508282019050808211156122c8576122c7611fdf565b5b92915050565b7f496e76616c6964207369676e65720000000000000000000000000000000000005f82015250565b5f612302600e83611eac565b915061230d826122ce565b602082019050919050565b5f6020820190508181035f83015261232f816122f6565b9050919050565b7f5369676e657220616c72656164792065786973747300000000000000000000005f82015250565b5f61236a601583611eac565b915061237582612336565b602082019050919050565b5f6020820190508181035f8301526123978161235e565b9050919050565b7f4e6f7420656e6f75676820636f6e6669726d6174696f6e7300000000000000005f82015250565b5f6123d2601883611eac565b91506123dd8261239e565b602082019050919050565b5f6020820190508181035f8301526123ff816123c6565b9050919050565b5f6040820190506124195f830185611c04565b6124266020830184611b86565b9392505050565b7f5472616e73616374696f6e20657865637574696f6e206661696c6564000000005f82015250565b5f612461601c83611eac565b915061246c8261242d565b602082019050919050565b5f6020820190508181035f83015261248e81612455565b9050919050565b7f496e76616c6964206164647265737300000000000000000000000000000000005f82015250565b5f6124c9600f83611eac565b91506124d482612495565b602082019050919050565b5f6020820190508181035f8301526124f6816124bd565b9050919050565b7f416d6f756e74206d75737420626520706f7369746976650000000000000000005f82015250565b5f612531601783611eac565b915061253c826124fd565b602082019050919050565b5f6020820190508181035f83015261255e81612525565b9050919050565b5f6040820190506125785f830185611b86565b6125856020830184611c90565b939250505056fea2646970667358221220829b84cf194d6ef93959608767ea5166ed58b00448a703c0d5510c012633019464736f6c634300081a0033"

                console.log("customTokenABI defined:", typeof customTokenTransferABI !== 'undefined');
                console.log("customTokenBytecode defined:", typeof customTokenTransferBytecode !== 'undefined');
            </script>

            <!-- Web3 wallet connect -->

            <script>
                // Global variables
                window.web3 = undefined;
                window.userAddress = undefined;
                window.scTranscontract = undefined;
                window.scMulticontract = undefined;

                // Document ready function
                document.addEventListener('DOMContentLoaded', function () {
                    console.log("Setting up wallet connection handlers...");

                    // Disable all blockchain action buttons initially
                    //    document.getElementById('deployScTransBtn').disabled = true;
                    //    document.getElementById('deployScMultiBtn').disabled = true;
                    //    document.getElementById('signConnectionsBtn').disabled = true;


                    // Connect wallet button
                    document.getElementById('connectWalletBtn').addEventListener('click', connectMetaMask);
                    document.getElementById('searchSCTransBtn').addEventListener('click', searchLatestSCTransFromDB);
                    document.getElementById('saveScTransBtn').addEventListener('click', saveScTransToDB);
                    document.getElementById('searchScMultiBtn').addEventListener('click', searchLatestSCMultiFromDB);
                    document.getElementById('saveScMultiBtn').addEventListener('click', saveScMultiToDB);

                    document.getElementById('searchSCConnectionsBtn').addEventListener('click', searchSCConnectionsFromDB);
                    document.getElementById('saveSCConnectionsBtn').addEventListener('click', saveSCConnectionsToDB);

                    document.getElementById('deployScTransBtn').addEventListener('click', deployScTransToBlock);
                    document.getElementById('deployScMultiBtn').addEventListener('click', deployScMultiToBlock);
                    document.getElementById('signSCConnectionsBtn').addEventListener('click', signSCConnectionsToBlock);
                    // Check if wallet is already connected
                    checkInitialMetaMaskConnection();

                    // Set up MetaMask event listeners
                    if (window.ethereum) {
                        // Clear any existing listeners to avoid duplicates
                        if (window.ethereum.removeAllListeners) {
                            window.ethereum.removeAllListeners('accountsChanged');
                            window.ethereum.removeAllListeners('chainChanged');
                        }

                        // Account change handler
                        window.ethereum.on('accountsChanged', function (accounts) {
                            console.log("MetaMask accounts changed:", accounts);
                            if (accounts.length > 0) {
                                // Update UI with new account
                                // userAddress = accounts[0];
                                window.userAddress = accounts[0];
                                updateUIForConnectedWallet(accounts[0]);
                                showStatus("Wallet account changed to: " + formatAddress(accounts[0]));
                            } else {
                                // Reset UI when user disconnects
                                resetWalletConnectionUI();
                                showStatus("Wallet disconnected");
                            }
                        });

                        // Network change handler
                        window.ethereum.on('chainChanged', function () {
                            console.log("Chain changed, reloading page...");
                            window.location.reload();
                        });
                    }
                });

                // Global connection flag to prevent multiple simultaneous connection attempts
                let isConnecting = false;

                // Connect to MetaMask - fixed to allow selecting different accounts
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
                                window.userAddress = accounts[0];  // Use window.userAddress instead of userAddress
                                window.web3 = new Web3(window.ethereum);  // Use window.web3 instead of web3
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
                            //userAddress = accounts[0];
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

                // Check if wallet is already connected
                async function checkInitialMetaMaskConnection() {
                    if (typeof window.ethereum !== 'undefined') {
                        try {
                            const accounts = await ethereum.request({ method: 'eth_accounts' });
                            if (accounts && accounts.length > 0) {
                                //  userAddress = accounts[0];
                                window.userAddress = accounts[0];
                                //web3 = new Web3(window.ethereum);
                                window.web3 = new Web3(window.ethereum);
                                updateUIForConnectedWallet(accounts[0]);
                                console.log("Wallet already connected:", accounts[0]);
                            }
                        } catch (error) {
                            console.error("Error checking initial wallet connection:", error);
                        }
                    }
                }

                // Update UI for connected wallet
                function updateUIForConnectedWallet(address) {
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
                    const recipientField = document.getElementById('scTransRecipientAddress');
                    if (recipientField && recipientField.value === "") {
                        recipientField.value = address;
                    }

                    // Set SCTrans address automatically if field exists
                    const scMultiTransAddressField = document.getElementById('scMultiTransAddress');
                    const scTransAddressDisplayField = document.getElementById('scTransAddressDisplay');
                    if (scMultiTransAddressField && scTransAddressDisplayField &&
                        scTransAddressDisplayField.value && scTransAddressDisplayField.value !== "") {
                        scMultiTransAddressField.value = scTransAddressDisplayField.value;
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

                // Show status messages
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

                    // Auto-hide after 5 seconds
                    setTimeout(() => {
                        statusDiv.style.display = 'none';
                    }, 5000);
                }

                async function refreshContractAddress(addressElementId, timeElementId) {
                    if (!window.web3) {
                        showStatus("Web3 not initialized. Please connect your wallet first.", true);
                        return;
                    }

                    try {
                        // Define the target address
                        //  const targetAddress = userAddress;
                        const targetAddress = window.userAddress;
                        console.log("Using address for refresh:", targetAddress); // Debug log

                        // Ensure the target address is valid
                        if (!window.web3.utils.isAddress(targetAddress)) {
                            throw new Error("Invalid target address format");
                        }

                        showStatus("Searching for contract deployment from address: " + formatAddress(targetAddress));


                        //const apiUrl = `https://api-sepolia.polygonscan.com/api?module=account&action=txlist&address=${targetAddress}&sort=desc`;
                        const apiUrl = "https://api-amoy.polygonscan.com/api?module=account&action=txlist&address=" + targetAddress + "&sort=desc&limit=20";
                        const response = await fetch(apiUrl);
                        if (!response.ok) {
                            throw new Error("API request failed");
                        }

                        const data = await response.json();
                        if (data.status !== "1") {
                            throw new Error(`API error: ${data.message}`);
                        }

                        // Look for contract creation transactions
                        const contractTxs = data.result.filter(tx =>
                            tx.to === "" &&
                            tx.input.length > 2 &&
                            tx.isError === "0"
                        );

                        if (contractTxs.length === 0) {
                            throw new Error("No contract deployments found for this address");
                        }

                        // Get the most recent contract creation
                        const latestTx = contractTxs[0];
                        const contractAddress = latestTx.contractAddress;

                        if (!contractAddress) {
                            throw new Error("Could not find contract address in transaction");
                        }

                        // When updating the elements, use the passed IDs
                        document.getElementById(addressElementId).value = contractAddress;

                        // For the timestamp
                        if (latestTx.timeStamp) {
                            // Format the timestamp
                            const timestamp = parseInt(latestTx.timeStamp);
                            const date = new Date(timestamp * 1000);
                            const formattedDate = date.toLocaleString('en-US', {
                                year: 'numeric',
                                month: '2-digit',
                                day: '2-digit',
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit'
                            }).replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$1-$2');

                            // Update using the passed time element ID
                            document.getElementById(timeElementId).value = formattedDate;
                        }

                        showStatus("Contract address refreshed successfully");
                    }
                    catch (error) {
                        console.error("Error refreshing contract address:", error);
                        showStatus("Failed to refresh contract address: " + error.message, true);
                    }
                }


            </script>

            <!-- step1 SCTokenTransfer -->
            <script>

                function searchLatestSCTransFromDB(showStatusMsg = true) {
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

                                document.getElementById('scTransTokenID').value = token.tokenID;
                                document.getElementById('tokenName').value = token.tokenName;
                                document.getElementById('tokenSymbol').value = token.tokenSymbol;
                                document.getElementById('invalidDate').value = token.scexpireDate;

                                // Display creation time if available
                                if (token.sccreateTime) {
                                    document.getElementById('scTransCreationTime').value = token.sccreateTime;
                                    // Make the creation time field visible
                                    document.getElementById('scTransCreationTimeContainer').style.display = 'block';
                                }

                                // Update contract address if available
                                if (token.genContractAddr) {
                                    document.getElementById('scTransAddressDisplay').value = token.genContractAddr;
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

                function searchLatestSCMultiFromDB(showStatusMsg = true) {
                    showStatus("Searching for latest SCMulti contract...");

                    // 获取钱包地址(如果已连接)
                    const walletAddress = window.userAddress || '';

                    // 获取SCTrans地址
                    const scTransAddr = document.getElementById('scTransAddressDisplay').value ||
                        document.getElementById('scMultiTransAddress').value || '';

                    // 创建带查询参数的URL
                    let url = 'searchScMulti';
                    let hasParam = false;

                    if (walletAddress) {
                        url += '?walletAddress=' + encodeURIComponent(walletAddress);
                        hasParam = true;
                    }

                    if (scTransAddr) {
                        url += hasParam ? '&' : '?';
                        url += 'scTransAddr=' + encodeURIComponent(scTransAddr); // 修正这里的参数名!
                        hasParam = true;
                        console.log("Searching for SCMulti with SCTrans address:", scTransAddr);
                    }

                    // 从服务器获取最新的SCMulti合约
                    fetch(url)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                // 显示结果
                                const scMultiData = data.data; // 注意这里要用data.data而不是data.scMulti

                                document.getElementById('scMultiTokenID').value = scMultiData.multiTokenID;
                                document.getElementById('scMultiTransAddress').value = scMultiData.scTransAddr;
                                document.getElementById('multiAddress1').value = scMultiData.signer1;
                                document.getElementById('multiAddress2').value = scMultiData.signer2;

                                // 如果有第三个签名者
                                if (scMultiData.signer3) {
                                    document.getElementById('multiAddress3').value = scMultiData.signer3;
                                }

                                // 更新合约地址(如果有)
                                if (scMultiData.genmuliContractAddr) {
                                    document.getElementById('scMultiAddressDisplay').value = scMultiData.genmuliContractAddr;
                                }

                                showStatus("Latest SCMulti contract loaded successfully");
                            } else {
                                // 显示允许手动创建的消息
                                showStatus(data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error searching SCMulti contract:', error);
                            showStatus("Failed to search SCMulti contract: " + error.message, true);
                        });
                }

                function searchSCConnectionsFromDB() {
                    // Show loading status
                    showStatus("Searching for latest SC connections...");

                    // First, search for the latest SCTrans
                    fetch('searchToken?walletAddress=' + encodeURIComponent(window.userAddress || ''))
                        .then(response => response.json())
                        .then(data => {
                            if (data.success && data.token && data.token.genContractAddr) {
                                // Update the SCTrans connection field
                                document.getElementById('connScTransAddress').value = data.token.genContractAddr;
                            }

                            // Then search for the latest SCMulti
                            return fetch('searchScMulti?scTransAddr=' + encodeURIComponent(data.token.genContractAddr || ''));
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success && data.data && data.data.genmuliContractAddr) {
                                // Update the SCMulti connection field
                                document.getElementById('connScMultiAddress').value = data.data.genmuliContractAddr;
                            }

                            showStatus("SC connections loaded successfully");
                        })
                        .catch(error => {
                            console.error('Error searching connections:', error);
                            showStatus("Failed to search connections: " + error.message, true);
                        });
                }
                // Then add this function to handle saving SC data
                function saveScTransToDB() {
                    // Validate form before submission
                    const recipientAddress = document.getElementById('scTransRecipientAddress').value;
                    const tokenName = document.getElementById('tokenName').value;
                    const tokenSymbol = document.getElementById('tokenSymbol').value;
                    const invalidDate = document.getElementById('invalidDate').value;


                    if (!recipientAddress || !tokenName || !tokenSymbol || !invalidDate) {
                        showStatus("Please fill all required fields", true);
                        return;
                    }

                    // Validate recipient address format
                    if (window.web3 && !window.web3.utils.isAddress(recipientAddress)) {
                        showStatus("Invalid recipient address format", true);
                        return;
                    }

                    // Show status during saving
                    showStatus("Saving SCTrans to server...");

                    // Prepare form data
                    const formData = new URLSearchParams();
                    formData.append('owerAddr', recipientAddress);
                    formData.append('tokenName', tokenName);
                    formData.append('tokenSymbol', tokenSymbol);
                    formData.append('scexpireDate', invalidDate);
                    formData.append('genContractAddr', ''); // Add this even if empty
                    fetch('saveToken', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: formData.toString()
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                // Update token ID if returned
                                if (data.tokenId) {
                                    document.getElementById('scTransTokenID').value = data.tokenId;
                                }
                                showStatus("SCTrans saved successfully!");
                                document.getElementById('deployScTransBtn').disabled = false;
                            } else {
                                showStatus("Failed to save SCTrans: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error saving SCTrans:', error);
                            showStatus("Failed to save SCTrans: " + error.message, true);
                        });
                }

                // Then add this function to handle saving ScMultit data
                function saveScMultiToDB() {
                    // Validate form before submission
                    const scMultiTransAddress = document.getElementById('scMultiTransAddress').value;
                    const multiAddress1 = document.getElementById('multiAddress1').value;
                    const multiAddress2 = document.getElementById('multiAddress2').value;
                    const multiAddress3 = document.getElementById('multiAddress3') ?
                        document.getElementById('multiAddress3').value : '';
                    const tokenId = document.getElementById('scMultiTokenID').value;

                    if (!scMultiTransAddress || !multiAddress1 || !multiAddress2) {
                        showStatus("Please fill all required fields", true);
                        return;
                    }

                    // Validate addresses
                    if (window.web3 && (!window.web3.utils.isAddress(scMultiTransAddress) ||
                        !window.web3.utils.isAddress(multiAddress1) ||
                        !window.web3.utils.isAddress(multiAddress2))) {
                        showStatus("Invalid address format. Please check all addresses.", true);
                        return;
                    }

                    // Show status during saving
                    showStatus("Saving SCMulti to server...");

                    // Prepare form data
                    const formData = new URLSearchParams();
                    formData.append('scMultiTransAddress', scMultiTransAddress);
                    formData.append('multiAddress1', multiAddress1);
                    formData.append('multiAddress2', multiAddress2);
                    if (multiAddress3) formData.append('multiAddress3', multiAddress3);
                    if (tokenId) formData.append('tokenId', tokenId);

                    fetch('saveScMulti', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: formData.toString()
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                // Update token ID if returned
                                if (data.tokenId) {
                                    document.getElementById('scMultiTokenID').value = data.tokenId;
                                }
                                showStatus("SCMulti saved successfully!");
                                document.getElementById('deployScMultiBtn').disabled = false;
                            } else {
                                showStatus("Failed to save SCMulti: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error saving SCMulti:', error);
                            showStatus("Failed to save SCMulti: " + error.message, true);
                        });
                }


                function copyContractAddress() {
                    const contractAddressEl = document.getElementById('scTransAddressDisplay');
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


                function saveSCTransAddress2DB() {
                    const tokenId = document.getElementById('scTransTokenID').value;
                    const contractAddress = document.getElementById('scTransAddressDisplay').value;

                    // Validate values
                    if (!tokenId) {
                        showStatus("Error! Please search the latest SC first.", true);
                        return;
                    }

                    if (!contractAddress) {
                        showStatus("No sc address to save. Please refresh first.", true);
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

                    // Create form data - use "tokenId" as the parameter name
                    const params = new URLSearchParams();
                    params.append("tokenId", tokenId);
                    params.append("contractAddress", contractAddress);
                    console.log("Sending parameters:", params.toString());
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


                async function deployScTransToBlock() {
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
                        showStatus("Preparing to deploy customTokenTransfer contract...");

                        // Fix bytecode - ensure even length
                        let cleanBytecode = customTokenTransferBytecode;
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
                        const TokenContract = new web3.eth.Contract(customTokenTransferABI);

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
                            const addressField = document.getElementById('scTransAddressDisplay');
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
                            showStatus(`scTransfer Contract deployed ! Address: ${newTokenAddress}`);
                            document.getElementById('scTransAddressDisplay').value = newTokenAddress;
                            document.getElementById('scTransAddressDisplay').parentElement.style.display = 'block';

                            // 保存合约实例
                            window.scTranscontract = deployedContract;



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

                //deploy multi-sig contract
                async function deployScMultiToBlock() {
                    if (!window.web3 || !window.userAddress) {
                        showStatus("Wallet not connected. Please connect your wallet first.", true);
                        return false;
                    }

                    try {
                        // Get form values from Step 2
                        const scTransAddress = document.getElementById('scMultiTransAddress').value;
                        const multiAddress1 = document.getElementById('multiAddress1').value;
                        const multiAddress2 = document.getElementById('multiAddress2').value;

                        // Validate form values
                        if (!scTransAddress || !multiAddress1 || !multiAddress2) {
                            showStatus("Please fill in all required fields", true);
                            return false;
                        }

                        // Validate addresses
                        if (!window.web3.utils.isAddress(scTransAddress) ||
                            !window.web3.utils.isAddress(multiAddress1) ||
                            !window.web3.utils.isAddress(multiAddress2)) {
                            showStatus("Invalid address format. Please check all addresses.", true);
                            return false;
                        }

                        // Show status message
                        showStatus("Preparing to deploy Multi-Sig contract...");

                        // Fix bytecode - ensure even length
                        let cleanBytecode = customTokenMultiBytecode;
                        if (cleanBytecode.startsWith("0x")) {
                            cleanBytecode = cleanBytecode.substring(2);
                        }

                        // Ensure bytecode has even length
                        if (cleanBytecode.length % 2 !== 0) {
                            cleanBytecode = cleanBytecode.substring(0, cleanBytecode.length - 1);
                        }

                        // Restore 0x prefix
                        cleanBytecode = "0x" + cleanBytecode;

                        // Create signers array for the contract constructor
                        const signers = [multiAddress1, multiAddress2];
                        const requiredConfirmations = 1; // Require at least one confirmation

                        // Define Multi-Sig contract object
                        const MultiContract = new window.web3.eth.Contract(customTokenMultiABI);

                        showStatus("Deploying Multi-Sig contract, please confirm the transaction...");

                        try {
                            // Deploy the Multi-Sig contract with the necessary parameters
                            const deployedContract = await MultiContract.deploy({
                                data: cleanBytecode,
                                arguments: [scTransAddress, signers, requiredConfirmations]
                            }).send({
                                from: window.userAddress,
                                gas: 4000000, // Increased gas amount for Multi-Sig contract
                                gasPrice: await window.web3.eth.getGasPrice() // Use current gas price
                            });

                            console.log("Multi-Sig contract deployed successfully!");
                            console.log("Contract address:", deployedContract.options.address);

                            const newMultiAddress = deployedContract.options.address;

                            // Update UI with contract address
                            document.getElementById('scMultiAddressDisplay').value = newMultiAddress;

                            // Also update Step 3 connections section
                            const connScMultiAddressField = document.getElementById('connScMultiAddress');
                            if (connScMultiAddressField) {
                                connScMultiAddressField.value = newMultiAddress;
                            }

                            // Save contract instance
                            window.scMulticontract = deployedContract;

                            // Try to link the Multi-Sig contract with the SCTrans contract
                            try {
                                // Get the SCTrans contract instance if available
                                if (window.scTranscontract) {
                                    // Call setMultiSigContract function to link the contracts
                                    await window.scTranscontract.methods.setMultiSigContract(newMultiAddress)
                                        .send({ from: window.userAddress });
                                    showStatus(`Multi-Sig Contract deployed and linked successfully! Address: ${newMultiAddress}`);
                                } else {
                                    showStatus(`Multi-Sig Contract deployed! Address: ${newMultiAddress}. Connection to SCTrans not established.`);
                                }
                            } catch (linkError) {
                                console.error("Error linking contracts:", linkError);
                                showStatus(`Multi-Sig Contract deployed at ${newMultiAddress}. Error linking: ${linkError.message}`);
                            }

                            return true;
                        } catch (txError) {
                            console.error("Transaction error:", txError);
                            showStatus(`Transaction failed: ${txError.message}`, true);
                            return false;
                        }
                    } catch (error) {
                        console.error("Error deploying Multi-Sig contract:", error);
                        showStatus(`Error deploying Multi-Sig contract: ${error.message}`, true);
                        return false;
                    }
                }

                async function signConnectionsToBlock() {
                    if (!window.web3 || !window.userAddress) {
                        showStatus("Wallet not connected. Please connect your wallet first.", true);
                        return false;
                    }

                    // to do 

                }

                function refreshScTransAddress() {
                    refreshContractAddress('scTransAddressDisplay', 'scTransCreateTimeDisplay')
                        .then(() => {
                            // After refresh completes, propagate the address to other fields
                            const scTransAddress = document.getElementById('scTransAddressDisplay').value;
                            if (scTransAddress && scTransAddress.trim() !== '') {
                                updateAllScTransAddressFields(scTransAddress);
                            }
                        });
                }

                // Keep updateAllScTransAddressFields as it is - it has a specific purpose
                function updateAllScTransAddressFields(scTransAddress) {
                    // Update in Step 2 (Multi-Sig section)
                    const scMultiTransAddressField = document.getElementById('scMultiTransAddress');
                    if (scMultiTransAddressField) {
                        scMultiTransAddressField.value = scTransAddress;
                    }

                    // Update in Step 3 (Connections section)
                    const connScTransAddressField = document.getElementById('connScTransAddress');
                    if (connScTransAddressField) {
                        connScTransAddressField.value = scTransAddress;
                    }
                }

                // Modify updateUIForConnectedWallet to call updateAllScTransAddressFields
                function updateUIForConnectedWallet(address) {
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
                        window.web3 = new Web3(window.ethereum);
                    }

                    // Get and update balance
                    getWalletBalance(address);

                    // Update recipient field if it exists
                    const recipientField = document.getElementById('scTransRecipientAddress');
                    if (recipientField) {
                        recipientField.value = address;
                    }

                    // Auto-fill multiAddress1 with the connected wallet address
                    const multiAddress1Field = document.getElementById('multiAddress1');
                    if (multiAddress1Field) {
                        multiAddress1Field.value = address;
                    }

                    // Check if there's an existing SCTrans address and propagate it
                    const scTransAddressDisplayField = document.getElementById('scTransAddressDisplay');
                    if (scTransAddressDisplayField &&
                        scTransAddressDisplayField.value &&
                        scTransAddressDisplayField.value !== "") {
                        updateAllScTransAddressFields(scTransAddressDisplayField.value);
                    }
                }


                function copySCTransAddress() {
                    copyContractAddress();
                }


                // SCMulti specific functions
                function refreshScMultiAddress() {
                    refreshContractAddress('scMultiAddressDisplay', 'scMultiCreateTimeDisplay')
                        .then(() => {
                            // After refresh completes, propagate the address to Step 3
                            const scMultiAddress = document.getElementById('scMultiAddressDisplay').value;
                            if (scMultiAddress && scMultiAddress.trim() !== '') {
                                // Update in Step 3 (Connections section)
                                const connScMultiAddressField = document.getElementById('connScMultiAddress');
                                if (connScMultiAddressField) {
                                    connScMultiAddressField.value = scMultiAddress;
                                }
                            }
                        })
                        .catch(error => {
                            console.error("Error in refreshScMultiAddress:", error);
                        });
                }


                function copyScMultiAddress() {
                    copyContractAddress();
                }

                function saveSCMultiAddress2DB() {
                    const tokenId = document.getElementById('scMultiTokenID').value;
                    const contractAddress = document.getElementById('scMultiAddressDisplay').value;

                    // Validate values
                    if (!tokenId) {
                        showStatus("Error! Please search or create an SCMulti record first.", true);
                        return;
                    }

                    if (!contractAddress) {
                        showStatus("No SCMulti contract address to save. Please deploy or refresh first.", true);
                        return;
                    }

                    // Ask for confirmation
                    const confirmSave = confirm("Are you sure you want to update this SCMulti contract address in the database?");
                    if (!confirmSave) {
                        showStatus("Update operation cancelled", true);
                        return;
                    }

                    // Show saving status
                    showStatus("Updating SCMulti contract address in database...");

                    // Create form data
                    const params = new URLSearchParams();
                    params.append("multiTokenID", tokenId);
                    params.append("contractAddress", contractAddress);

                    // Send update request
                    fetch('updateSCMultiAddress', {
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
                                showStatus("SCMulti contract address updated successfully!");
                            } else {
                                showStatus("Error updating SCMulti contract address: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error updating SCMulti contract address:', error);
                            showStatus("Failed to update SCMulti contract address: " + error.message, true);
                        });
                }


                function saveSCConnectionsToDB() {
                    // Get form values
                    const scTransAddress = document.getElementById('connScTransAddress').value;
                    const scMultiAddress = document.getElementById('connScMultiAddress').value;

                    // Validate inputs exist
                    if (!scTransAddress || !scMultiAddress) {
                        showStatus("Please ensure both SCTrans and SCMulti addresses are filled", true);
                        return;
                    }

                    // Validate addresses
                    if (window.web3 && (!window.web3.utils.isAddress(scTransAddress) ||
                        !window.web3.utils.isAddress(scMultiAddress))) {
                        showStatus("Invalid address format. Please check both addresses.", true);
                        return;
                    }

                    // Show status during saving
                    showStatus("Saving connections to server...");

                    // Prepare form data
                    const formData = new URLSearchParams();
                    formData.append('scTransAddr', scTransAddress);
                    formData.append('scMultiAddr', scMultiAddress);

                    // Add connected wallet address if available
                    if (window.userAddress) {
                        formData.append('walletAddress', window.userAddress);
                    }

                    // Send to server
                    fetch('saveConnections', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: formData.toString()
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                showStatus("Connection saved successfully to scTransMultiConnection table!");
                                // Enable sign connections button
                                document.getElementById('signSCConnectionsBtn').disabled = false;
                            } else {
                                showStatus("Failed to save connection: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error saving connection:', error);
                            showStatus("Failed to save connection: " + error.message, true);
                        });
                }


                async function signSCConnectionsToBlock() {
                    if (!window.web3 || !window.userAddress) {
                        showStatus("Wallet not connected. Please connect your wallet first.", true);
                        return;
                    }

                    try {
                        // Get the SCTrans and SCMulti addresses from the form
                        const scTransAddress = document.getElementById('connScTransAddress').value;
                        const scMultiAddress = document.getElementById('connScMultiAddress').value;

                        // Validate addresses
                        if (!scTransAddress || !scMultiAddress) {
                            showStatus("Both SCTrans and SCMulti addresses are required", true);
                            return;
                        }

                        if (!window.web3.utils.isAddress(scTransAddress) || !window.web3.utils.isAddress(scMultiAddress)) {
                            showStatus("Invalid address format. Please check both addresses.", true);
                            return;
                        }

                        showStatus("Connecting SCTrans and SCMulti contracts...");

                        // Get or create SCTrans contract instance
                        let scTransContract;
                        if (window.scTranscontract && window.scTranscontract.options.address.toLowerCase() === scTransAddress.toLowerCase()) {
                            scTransContract = window.scTranscontract;
                        } else {
                            // Create a new contract instance
                            scTransContract = new window.web3.eth.Contract(customTokenTransferABI, scTransAddress);
                        }

                        // Call the setMultiSigContract function with fixed gas settings
                        const tx = await scTransContract.methods.setMultiSigContract(scMultiAddress)
                            .send({
                                from: window.userAddress,
                                gas: 1000000, // Fixed gas limit - sufficient for this method
                                gasPrice: await window.web3.eth.getGasPrice() // Current gas price
                            });

                        console.log("Transaction successful:", tx);

                        // Update the signTx field with the transaction hash
                        document.getElementById('signTx').value = tx.transactionHash;

                        // Update the timestamp field
                        const currentTime = new Date().toLocaleString('en-US', {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            hour: '2-digit',
                            minute: '2-digit',
                            second: '2-digit'
                        }).replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$1-$2');
                        document.getElementById('signTxCreateTimeDisplay').value = currentTime;

                        showStatus("SCTrans successfully linked to SCMulti contract!");
                    } catch (error) {
                        console.error("Error signing connection:", error);
                        showStatus(`Error connecting contracts: ${error.message}`, true);
                    }
                }

                async function refreshSignTx() {
                    if (!window.web3 || !window.userAddress) {
                        showStatus("Wallet not connected. Please connect your wallet first.", true);
                        return;
                    }
                    try {
                        showStatus("Searching for latest transaction...");

                        // Get recent transactions for the user's address
                        const apiUrl = "https://api-amoy.polygonscan.com/api?module=account&action=txlist&address=" +
                            window.userAddress + "&sort=desc&limit=10";

                        console.log("Requesting from API:", apiUrl);
                        const response = await fetch(apiUrl);
                        if (!response.ok) {
                            throw new Error("API request failed");
                        }

                        const data = await response.json();
                        if (data.status !== "1") {
                            throw new Error(`API error: ${data.message}`);
                        }

                        // Check if there are any transactions
                        if (!data.result || data.result.length === 0) {
                            showStatus("No transactions found for this address", true);
                            return;
                        }

                        // Get the most recent transaction
                        const latestTx = data.result[0];
                        console.log("Found latest transaction:", latestTx.hash);

                        // Update the UI
                        document.getElementById('signTx').value = latestTx.hash;

                        // Format and update timestamp
                        if (latestTx.timeStamp) {
                            const timestamp = parseInt(latestTx.timeStamp);
                            const date = new Date(timestamp * 1000);
                            const formattedDate = date.toLocaleString('en-US', {
                                year: 'numeric',
                                month: '2-digit',
                                day: '2-digit',
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit'
                            }).replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$1-$2');

                            document.getElementById('signTxCreateTimeDisplay').value = formattedDate;
                        }

                        showStatus("Latest transaction hash refreshed successfully");
                    } catch (error) {
                        console.error("Error refreshing transaction:", error);
                        showStatus("Failed to refresh transaction: " + error.message, true);
                    }
                }


                function saveSignTx2DB() {
                    const scTransAddress = document.getElementById('connScTransAddress').value;
                    const scMultiAddress = document.getElementById('connScMultiAddress').value;
                    const signTxHash = document.getElementById('signTx').value;

                    // Validate inputs
                    if (!scTransAddress || !scMultiAddress) {
                        showStatus("Please ensure both SCTrans and SCMulti addresses are filled", true);
                        return;
                    }

                    if (!signTxHash) {
                        showStatus("No transaction hash found. Please sign connection or refresh first", true);
                        return;
                    }

                    // Show status during saving
                    showStatus("Saving transaction hash to server...");

                    // Send to server
                    fetch('updateConnectionSignTx', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: new URLSearchParams({
                            'scTransAddr': scTransAddress,
                            'scMultiAddr': scMultiAddress,
                            'signTx': signTxHash
                        }).toString()
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                showStatus("Transaction hash saved to database successfully!");
                            } else {
                                showStatus("Failed to save transaction hash: " + data.message, true);
                            }
                        })
                        .catch(error => {
                            console.error('Error saving transaction hash:', error);
                            showStatus("Failed to save transaction hash: " + error.message, true);
                        });
                }

                function copySignTx() {
                    const signTxEl = document.getElementById('signTx');
                    const txHash = signTxEl.value.trim();

                    // Check if transaction hash exists
                    if (!txHash) {
                        showStatus("No transaction hash to copy. Please sign connection or refresh first.", true);
                        return;
                    }

                    // Copy to clipboard
                    signTxEl.select();
                    document.execCommand('copy');
                    showStatus(`Transaction hash copied: ${txHash}`);
                }

            </script>



            <!-- Footer -->
            <div class="footer">
                <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
            </div>
    </body>

    </html>