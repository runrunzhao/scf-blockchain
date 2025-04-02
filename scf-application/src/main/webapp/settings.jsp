<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
    
    <!-- Main Container -->
    <div class="container">
        <h2>Account Settings</h2>
        <hr>
        <!-- 修改用户基本信息的表单 -->
        <form method="post" action="updateSettings">
            <div class="form-group">
                <label for="email">Email address</label>
                <!-- Email 从数据库查询后传入，此处假设后台将 user 对象放入 request 范围 -->
                <input type="email" class="form-control" id="email" name="email" value="${user.email}">
            </div>
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" class="form-control" id="fullname" name="fullname" 
                       value="<%= session.getAttribute("fullname") != null ? session.getAttribute("fullname") : "" %>">
            </div>
            <div class="form-group">
                <label for="password">Change Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password">
            </div>
            
            <!-- 新增：Wallet Address 输入框和Confirm按钮 -->
            <div class="form-group">
                <label for="walletAddress">Wallet Address:</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="walletAddress" name="walletAddress" placeholder="Enter your ETH address">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-secondary" onclick="confirmWallet()">Confirm</button>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">Save Changes</button>
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
                    // 请求账户访问
                    await ethereum.request({ method: 'eth_requestAccounts' });
                    const accounts = await ethereum.request({ method: 'eth_accounts' });
                    
                    // 获取用户输入的目标钱包地址
                    const walletAddress = document.getElementById('walletAddress').value;
                    if (!walletAddress) {
                        alert("Please enter a wallet address.");
                        return;
                    }
                    
                    // 构造交易参数，可以根据具体业务调整
                    const txParameters = {
                        from: accounts[0],
                        to: walletAddress,
                        value: '0x0', // 发送0以太币，仅作为确认操作
                        gas: '0x5208' // 21000 gas
                    };
                    
                    // 发送交易请求到 MetaMask
                    const txHash = await ethereum.request({
                        method: 'eth_sendTransaction',
                        params: [txParameters],
                    });
                    alert('Transaction submitted with hash: ' + txHash);
                } catch (error) {
                    console.error('Error submitting transaction:', error);
                    alert('Transaction failed: ' + error.message);
                }
            } else {
                alert('MetaMask is not installed. Please install MetaMask and try again.');
            }
        }
    </script>
</body>
</html>