<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

                .wallet-actions {
                    margin-top: 20px;
                }

                .wallet-actions button {
                    margin-right: 10px;
                }

                /* 居中二维码和按钮 */
                #qrcode {
                    display: block;
                    margin: 0 auto;
                    /* 居中二维码 */
                }

                .modal-body button {
                    display: block;
                    margin: 20px auto;
                    /* 居中按钮 */
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
                    <!-- 登录信息显示区域 -->
                    <div class="dropdown d-inline-block">
                        <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false">
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
                <h2>My Wallet</h2>
                <hr>
                <div id="walletInfo">
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
                    <p><strong>Wallet Address:</strong> <span id="walletAddress">Not connected</span></p>
                    <p><strong>gas Balance:</strong> <span id="walletBalance">0 POL</span></p>
                    <p><strong>CTT Balance:</strong> <span id="tokenBalance">0</span></p>
                </div>

                <!-- Wallet Actions -->
                <div class="wallet-actions">
                    <button class="btn btn-primary" onclick="connectWallet()">Connect Wallet</button>
                    <button class="btn btn-secondary" onclick="showTokenBalance()">Query CTT</button>
                    <button class="btn btn-success" onclick="showReceiveAddress()">Receive</button>
                    <button class="btn btn-warning" onclick="showSendModal()">Send</button>

                </div>



                <!-- Receive Address Modal -->
                <div id="receiveModal" class="modal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Receive Address</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <canvas id="qrcode" style="margin-bottom: 20px;"></canvas>
                                <p id="receiveAddress" style="word-break: break-all;">Not connected</p>
                                <button class="btn btn-success" onclick="copyAddress()">Copy Address</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Send Modal -->
                <div id="sendModal" class="modal fade" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Send Tokens</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="sendForm">
                                    <div class="form-group">
                                        <label for="recipientAddress">Recipient Address</label>
                                        <input type="text" class="form-control" id="recipientAddress"
                                            placeholder="Enter recipient address" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="sendAmount">Amount</label>
                                        <input type="number" class="form-control" id="sendAmount"
                                            placeholder="Enter amount" required>
                                    </div>
                                    <button type="button" class="btn btn-primary" onclick="sendTokens()">Send</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
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

                            // Change the connect button style directly
                            const connectButton = document.querySelector('.btn.btn-primary[onclick="connectWallet()"]');
                            if (connectButton) {
                                connectButton.innerText = "Wallet Connected";
                                connectButton.classList.remove('btn-primary');
                                connectButton.classList.add('btn-success');
                            }

                        } catch (error) {
                            console.error("Failed to connect wallet:", error);
                            alert("Failed to connect wallet: " + error.message);
                        }
                    } else {
                        alert("MetaMask is not installed. Please install it to use this feature.");
                    }
                }
                async function showTokenBalance() {
                    const tokenAddress = "0x0000000000000000000000000000000000001010"; // 替换为实际代币地址
                    const provider = new ethers.providers.Web3Provider(window.ethereum);
                    const signer = provider.getSigner();
                    const userAddress = await signer.getAddress();
                    const tokenABI = [
                        "function balanceOf(address owner) view returns (uint256)",
                        "function decimals() view returns (uint8)"
                    ];
                    const tokenContract = new ethers.Contract(tokenAddress, tokenABI, provider);
                    const rawBalance = await tokenContract.balanceOf(userAddress);
                    const decimals = await tokenContract.decimals();
                    const formattedBalance = parseFloat(ethers.utils.formatUnits(rawBalance, decimals)).toFixed(4);
                    document.getElementById('tokenBalance').innerText = formattedBalance + " CTT ";
                }


                async function showReceiveAddress() {
                    if (typeof window.ethereum !== 'undefined') {
                        try {
                            const provider = new ethers.providers.Web3Provider(window.ethereum);
                            const signer = provider.getSigner();
                            const walletAddress = await signer.getAddress();

                            // 调试信息
                            console.log("Wallet Address:", walletAddress);

                            // 更新钱包地址
                            document.getElementById('receiveAddress').innerText = walletAddress;

                            // 确保二维码容器是 <canvas>
                            const qrCodeCanvas = document.getElementById('qrcode');
                            if (!qrCodeCanvas || qrCodeCanvas.tagName !== 'CANVAS') {
                                console.error("QR Code container is not a valid <canvas> element.");
                                alert("QR Code container is not a valid <canvas> element. Please check the HTML structure.");
                                return;
                            }

                            // 清空之前的二维码
                            const context = qrCodeCanvas.getContext('2d');
                            context.clearRect(0, 0, qrCodeCanvas.width, qrCodeCanvas.height);

                            // 生成二维码
                            try {
                                QRCode.toCanvas(qrCodeCanvas, walletAddress, { width: 200 });
                            } catch (error) {
                                console.error("QR Code generation failed:", error);
                                alert("Failed to generate QR Code. Please try again.");
                                return;
                            }

                            // 显示模态框
                            $('#receiveModal').modal('show');
                        } catch (error) {
                            console.error("Failed to get wallet address:", error);
                            alert("Failed to get wallet address: " + error.message);
                        }
                    } else {
                        alert("MetaMask is not installed. Please install it to use this feature.");
                    }
                }

                function copyAddress() {
                    const address = document.getElementById('receiveAddress').innerText;
                    navigator.clipboard.writeText(address).then(() => {
                        alert("Address copied to clipboard!");
                    }).catch(err => {
                        console.error("Failed to copy address:", err);
                    });
                }

                function showSendModal() {
                    $('#sendModal').modal('show'); // 显示发送模态框
                }

                async function sendTokens() {
                    const recipientAddress = document.getElementById('recipientAddress').value;
                    const sendAmount = document.getElementById('sendAmount').value;

                    if (!recipientAddress || !sendAmount) {
                        alert("Please enter recipient address and amount.");
                        return;
                    }

                    if (typeof window.ethereum !== 'undefined') {
                        try {
                            const provider = new ethers.providers.Web3Provider(window.ethereum);
                            const signer = provider.getSigner();
                            const tokenAddress = "0x0000000000000000000000000000000000001010"; // 替换为实际代币地址
                            const tokenABI = [
                                "function transfer(address to, uint256 amount) returns (bool)"
                            ];
                            const tokenContract = new ethers.Contract(tokenAddress, tokenABI, signer);
                            const decimals = 18;
                            const amountInWei = ethers.utils.parseUnits(sendAmount, decimals);
                            const tx = await tokenContract.transfer(recipientAddress, amountInWei);
                            alert("Transaction sent! Hash: " + tx.hash);
                            await tx.wait();
                            alert("Transaction confirmed!");
                            $('#sendModal').modal('hide');
                        } catch (error) {
                            console.error("Failed to send tokens:", error);
                            alert("Failed to send tokens: " + error.message);
                        }
                    } else {
                        alert("MetaMask is not installed. Please install it to use this feature.");
                    }
                }
            </script>
        </body>

        </html>