<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wallet - Supply Chain Finance</title>
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
        /* 新增：用于显示用户名的样式 */
        .user-info {
            font-size: 18px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            <!-- 登录信息显示区域 -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <c:choose>
                        <c:when test="${not empty user}">
                            ${user.username}
                        </c:when>
                        <c:otherwise>User</c:otherwise>
                    </c:choose>
                </a>
                <div class="dropdown-menu" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="profile.jsp">Profile</a>
                    <a class="dropdown-item" href="settings.jsp">Settings</a>
                    <a class="dropdown-item active" href="myWallet.jsp">My Wallet</a>
                    <a class="dropdown-item" href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- 新增：显示用户名信息 -->
        <div class="user-info">
            <p><strong>Username:</strong>
                <c:choose>
                    <c:when test="${not empty user}">
                        ${user.username}
                    </c:when>
                    <c:otherwise>
                        anthony
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        <h2>My Wallet</h2>
        <hr>
        <div id="walletInfo">
            <p><strong>Wallet Address:</strong> <span id="walletAddress">Not connected</span></p>
            <p><strong>Balance:</strong> <span id="walletBalance">0 ETH</span></p>
        </div>
        <button class="btn btn-primary" onclick="connectWallet()">Connect Wallet</button>
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
        async function connectWallet() {
            if (typeof window.ethereum !== 'undefined') {
                try {
                    // 请求账户访问
                    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
                    const walletAddress = accounts[0];
                    document.getElementById('walletAddress').innerText = walletAddress;
                    // 获取当前账户余额
                    const balanceHex = await ethereum.request({
                        method: 'eth_getBalance',
                        params: [walletAddress, 'latest']
                    });
                    // 将余额从 Wei 转为 ETH（注意：余额以十六进制字符串返回）
                    const balance = parseFloat(parseInt(balanceHex, 16) / Math.pow(10, 18)).toFixed(4);
                    document.getElementById('walletBalance').innerText = balance + " ETH";
                } catch (error) {
                    console.error("Failed to connect wallet:", error);
                    alert("Failed to connect wallet: " + error.message);
                }
            } else {
                alert("MetaMask is not installed. Please install it to use this feature.");
            }
        }
    </script>
</body>
</html>