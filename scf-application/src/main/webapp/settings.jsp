jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings - Supply Chain Finance</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
        }

        .container {
            margin-top: 30px;
        }

        .header {
            background-color: #007bff;
            padding: 15px;
            color: white;
            text-align: center;
            font-size: 24px;
            border-radius: 10px;
            position: relative;
            margin-bottom: 30px;
        }

        .menu {
            margin-bottom: 15px;
            margin-top: 15px;
        }

        .menu a {
            color: #fff;
            font-size: 18px;
            margin: 0 15px;
        }

        .menu a:hover {
            text-decoration: underline;
        }

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

        .dropdown.d-inline-block {
            vertical-align: middle;
        }

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
    </style>
</head>

<body>
    <!-- Header with improved navigation -->
    <div class="header">
        <div class="d-flex justify-content-between align-items-center">
            <h1 class="mb-0">Supply Chain Finance Platform</h1>

            <!-- User Status - Right corner -->
            <div class="user-status">
                <% if(session != null && session.getAttribute("username") != null) { 
                   String username = (String)session.getAttribute("username"); 
                %>
                    <div class="dropdown">
                        <a class="dropdown-toggle text-white" href="#" role="button" id="userStatusDropdown"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user-circle mr-1"></i>
                            <%= username %>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userStatusDropdown">
                            <a class="dropdown-item" href="profile.jsp"><i
                                    class="fas fa-id-card mr-2"></i>Profile</a>
                            <a class="dropdown-item active" href="settings.jsp"><i
                                    class="fas fa-cog mr-2"></i>Settings</a>
                            <a class="dropdown-item" href="myWallet.jsp"><i class="fas fa-wallet mr-2"></i>My
                                Wallet</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="logout.jsp"><i
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
                    <% if(session != null && session.getAttribute("username") != null) { %>
                        <a class="dropdown-item" href="profile.jsp">My Profile</a>
                        <a class="dropdown-item active" href="settings.jsp">My Settings</a>
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

    <!-- Debug section to help troubleshoot -->
    <div class="container">
        <div class="row mb-4" style="display:none;">
            <div class="col">
                <div class="card">
                    <div class="card-header">Debug Info</div>
                    <div class="card-body">
                        <p>Username from session: <%= session.getAttribute("username") %></p>
                        <p>Wallet address from session: <%= session.getAttribute("walletAddr") %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <h2>Account Settings</h2>
        <hr>

        <!-- Show success message if present -->
        <% if (session.getAttribute("message") != null) { %>
            <div class="alert alert-success">
                <%= session.getAttribute("message") %>
                <% session.removeAttribute("message"); %>
            </div>
        <% } %>

        <!-- Alert for demo form submission -->
        <div id="formSuccessMessage" class="alert alert-success" style="display: none;">
            Settings saved successfully!
        </div>

        <!-- Form should submit to a servlet endpoint -->
        <form id="settingsForm" method="post" action="updateSettings" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" class="form-control" id="email" name="email" readonly
                    value="${user.email}">
            </div>
            <div class="form-group">
                <label for="username">User Name</label>
                <input type="text" class="form-control" id="username" name="username" readonly
                    value="<%= session.getAttribute("username") != null ? session.getAttribute("username") : "" %>">
            </div>

            <div class="form-group">
                <label for="enterpriseId">Enterprise ID</label>
                <input type="text" class="form-control" id="enterpriseId" name="enterpriseId" readonly
                    placeholder="Enter your Enterprise ID"
                    value="${user.enterpriseId != null ? user.enterpriseId : ''}">
                <small class="form-text text-muted">You can update in profile.</small>
            </div>

            <div class="form-group">
                <label for="walletAddr">Wallet Address:</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="walletAddr" name="walletAddr"
                        placeholder="Enter your ETH address" 
                        value="<%= session.getAttribute("walletAddr") != null ? session.getAttribute("walletAddr") : "" %>">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-secondary"
                            onclick="confirmWallet()">Confirm</button>
                    </div>
                </div>
                <small id="walletStatus" class="form-text text-muted">Please verify your wallet address
                    before saving changes.</small>
                <input type="hidden" id="walletVerified" name="walletVerified" value="false">
            </div>

            <button type="submit" class="btn btn-primary">Save Wallet Address</button>
        </form>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
    </div>

    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <!-- Add dropdown hover functionality -->
    <script>
        $(document).ready(function() {
            // Initialize dropdown menu
            $('.dropdown-toggle').dropdown();
            
            // Add hover effect for better usability
            $('.dropdown').hover(
                function() { 
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100); 
                },
                function() { 
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100); 
                }
            );
        });
    </script>

    <!-- MetaMask Interaction Script -->
    <script>
        async function confirmWallet() {
            if (typeof window.ethereum !== 'undefined') {
                try {
                    // Request account access
                    await ethereum.request({ method: 'eth_requestAccounts' });
                    const accounts = await ethereum.request({ method: 'eth_accounts' });

                    // Get user input wallet address
                    const walletAddrInput = document.getElementById('walletAddr').value;
                    if (!walletAddrInput) {
                        alert("Please enter a wallet address.");
                        return;
                    }

                    // Check if input address matches connected wallet
                    if (walletAddrInput.toLowerCase() !== accounts[0].toLowerCase()) {
                        alert("The address you entered doesn't match your connected wallet address.\n\nEntered: " + walletAddrInput + "\nConnected: " + accounts[0]);
                        return;
                    }

                    // Create a message for signing
                    const message = `Verify wallet ownership: ${walletAddrInput}`;

                    // Ask user to sign the message (no gas fees, just signature)
                    const signature = await ethereum.request({
                        method: 'personal_sign',
                        params: [message, accounts[0]],
                    });

                    // If we get here, signature was successful
                    document.getElementById('walletVerified').value = "true";
                    document.getElementById('walletStatus').innerHTML =
                        '<span class="text-success">✓ Wallet verified successfully! Your address has been confirmed.</span>';

                } catch (error) {
                    console.error('Error verifying wallet:', error);
                    alert('Verification failed: ' + error.message);
                }
            } else {
                alert('MetaMask is not installed. Please install MetaMask and try again.');
            }
        }

        function validateForm() {
            const walletAddrValue = document.getElementById('walletAddr').value;
            const walletVerified = document.getElementById('walletVerified').value;
            const oldWalletAddr = '<%= session.getAttribute("walletAddr") != null ? session.getAttribute("walletAddr") : "" %>';

            // If the wallet address hasn't changed, no need to verify again
            if (walletAddrValue === oldWalletAddr && walletAddrValue !== "") {
                return true;
            }

            // Only require verification for new or changed wallet addresses
            if (walletAddrValue && walletVerified !== "true") {
                alert("Please verify your wallet address before saving changes.");
                return false;
            }
            return true;
        }

        $(document).ready(function () {
        const currentWalletAddr = document.getElementById('walletAddr').value;
        
        // Fix: properly handle JSP expression in JavaScript 
        const savedWalletAddr = '<%= session.getAttribute("walletAddr") != null ? session.getAttribute("walletAddr") : "" %>';

        // If wallet already exists in session, mark as verified
        if (currentWalletAddr && currentWalletAddr === savedWalletAddr && currentWalletAddr !== "") {
            document.getElementById('walletVerified').value = "true";
            document.getElementById('walletStatus').innerHTML =
                '<span class="text-success">✓ Previous wallet already verified</span>';
        }
    });

    </script>
</body>
</html>