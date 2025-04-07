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
            margin-bottom: 30px;
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

        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #aaa;
        }
    </style>
</head>

<body>
    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            <!-- 用户菜单 -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    User
                </a>
                <div class="dropdown-menu" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="profile.jsp">Profile</a>
                    <a class="dropdown-item active" href="settings.jsp">Settings</a>
                    <a class="dropdown-item" href="myWallet.jsp">My Wallet</a>
                    <a class="dropdown-item" href="logout.jsp">Logout</a>
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
                <input type="text" class="form-control" id="enterpriseId" name="enterpriseId" 
                       placeholder="Enter your Enterprise ID" 
                       value="${user.enterpriseId != null ? user.enterpriseId : ''}">
                <small class="form-text text-muted">Your company's unique identifier in the supply chain system.</small>
            </div>
            
            <div class="form-group">
                <label for="walletAddr">Wallet Address:</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="walletAddr" name="walletAddr"
                        placeholder="Enter your ETH address" 
                        value="<%= session.getAttribute("walletAddr") != null ? session.getAttribute("walletAddr") : "" %>">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-secondary" onclick="confirmWallet()">Confirm</button>
                    </div>
                </div>
                <small id="walletStatus" class="form-text text-muted">Please verify your wallet address before saving changes.</small>
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

    <!-- MetaMask Interaction Script -->
    <script>
        async function confirmWallet() {
            if (typeof window.ethereum !== 'undefined') {
                try {
                    // Request account access
                    await ethereum.request({ method: 'eth_requestAccounts' });
                    const accounts = await ethereum.request({ method: 'eth_accounts' });

                    // Get user input wallet address - FIXED: use walletAddr not walletAddress
                    const walletAddr = document.getElementById('walletAddr').value;
                    if (!walletAddr) {
                        alert("Please enter a wallet address.");
                        return;
                    }

                    // Check if input address matches connected wallet
                    if (walletAddr.toLowerCase() !== accounts[0].toLowerCase()) {
                        alert("The address you entered doesn't match your connected wallet address.\n\nEntered: " + walletAddr + "\nConnected: " + accounts[0]);
                        return;
                    }

                    // Create a message for signing
                    const message = `Verify wallet ownership: ${walletAddr}`;

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
            const walletAddr = document.getElementById('walletAddr').value;
            const walletVerified = document.getElementById('walletVerified').value;

            if (walletAddr && walletVerified !== "true") {
                alert("Please verify your wallet address before saving changes.");
                return false;
            }
            return true;
        }

        // Debug function - uncomment to help troubleshoot
        // $(document).ready(function() {
        //     console.log("Session attributes available:");
        //     console.log("Username: " + "<%= session.getAttribute("username") %>");
        //     console.log("Wallet Address: " + "<%= session.getAttribute("walletAddr") %>");
        // });
    </script>
</body>
</html>