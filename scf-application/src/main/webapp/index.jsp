<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.supplychainfinance.model.Enterprise" %>
<%@ page import="com.supplychainfinance.dao.EnterpriseDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Supply Chain Finance</title>
    <!-- Bootstrap CSS for responsive layout and styling -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
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

        .card {
            margin: 20px 0;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
        }

        .core-enterprise {
            text-align: center;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
        }

        .core-enterprise:hover {
            transform: translateY(-5px);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
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
            position: relative;
        }

        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #aaa;
        }

        /* Updated dropdown menu styling */
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

        /* Force dropdown menu display when .show class is present */
        .dropdown-menu.show {
            display: block !important;
        }

        /* Ensure dropdown menus stay on top of other content */
        .dropdown-menu {
            z-index: 1050 !important;
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
    </style>
</head>

<body>
    <!-- 直接硬编码页头，而不是使用include -->
    <div class="header">
        <div class="d-flex justify-content-between align-items-center">
            <h1 class="mb-0">Supply Chain Finance Platform</h1>
            
            <!-- User Status - 显示在右上角 -->
            <div class="user-status">
                <% if(session != null && session.getAttribute("isLoggedIn") != null && (Boolean)session.getAttribute("isLoggedIn")) { 
                    String username = (String)session.getAttribute("username");
                %>
                    <div class="dropdown">
                        <a class="dropdown-toggle text-white" href="#" role="button" id="userStatusDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user-circle mr-1"></i> <%= username %>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userStatusDropdown">
                            <a class="dropdown-item" href="profile.jsp"><i class="fas fa-id-card mr-2"></i>Profile</a>
                            <a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog mr-2"></i>Settings</a>
                            <a class="dropdown-item" href="myWallet.jsp"><i class="fas fa-wallet mr-2"></i>My Wallet</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt mr-2"></i>Logout</a>
                        </div>
                    </div>
                <% } else { %>
                    <div class="login-register">
                        <a href="login.jsp" class="text-white mr-3"><i class="fas fa-sign-in-alt mr-1"></i> Login</a>
                        <a href="register.jsp" class="text-white"><i class="fas fa-user-plus mr-1"></i> Register</a>
                    </div>
                <% } %>
            </div>
        </div>
        
        <div class="menu">
            <a href="index.jsp">Home</a>
            
            <!-- User dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    User
                </a>
                <div class="dropdown-menu" aria-labelledby="userDropdown">
                    <% if(session != null && session.getAttribute("isLoggedIn") != null && (Boolean)session.getAttribute("isLoggedIn")) { %>
                        <a class="dropdown-item" href="profile.jsp">My Profile</a>
                        <a class="dropdown-item" href="settings.jsp">My Settings</a>
                    <% } else { %>
                        <a class="dropdown-item" href="login.jsp">Login</a>
                        <a class="dropdown-item" href="register.jsp">Register</a>
                    <% } %>
                </div>
            </div>
            
            <!-- Enterprise dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Enterprise
                </a>
                <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                    <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                    <a class="dropdown-item" href="singleEnterprise.jsp?mode=add">Add New Enterprise</a>
                </div>
            </div>
            
            <!-- Contract dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="contractDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Contract
                </a>
                <div class="dropdown-menu" aria-labelledby="contractDropdown">
                    <a class="dropdown-item" href="contract.jsp">Search Contracts</a>
                    <a class="dropdown-item" href="contractDetail.jsp?mode=add">Add New Contract</a>
                </div>
            </div>

            <!-- Invoice dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="invoiceDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Invoice
                </a>
                <div class="dropdown-menu" aria-labelledby="invoiceDropdown">
                    <a class="dropdown-item" href="invoice.jsp">Search Invoices</a>
                    <a class="dropdown-item" href="invoiceDetail.jsp?mode=add">Add New Invoice</a>
                </div>
            </div>
            
             <!-- CTT menu -->
             <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="cttDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    CTT
                </a>
                <div class="dropdown-menu" aria-labelledby="cttDropdown">
                    <a class="dropdown-item" href="signSC.jsp">Sign SC</a>
                    <a class="dropdown-item" href="TGE.jsp">TGE</a>
                    <a class="dropdown-item" href="waitConfirm.jsp">Confirm TGE</a>
                    <a class="dropdown-item" href="CTTinfo.jsp">Detail</a>
                    <a class="dropdown-item" href="autoPay.jsp"">AutoPay</a>
                    <a class="dropdown-item" href="CTTFinancing.jsp"">Financing</a>
                    <a class="dropdown-item" href="CTTBurn.jsp"">Burning</a>
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
        <!-- Core Enterprise Section -->
        <div class="row justify-content-center">
            <div class="col-md-6">
                <%
                    // 声明并初始化变量 
                    Enterprise coreEnterprise = null;
                    
                    // 从请求获取核心企业
                    coreEnterprise = (Enterprise) request.getAttribute("coreEnterprise");
                    
                    // 如果找不到，直接从DAO获取
                    if (coreEnterprise == null) {
                        EnterpriseDAO dao = new EnterpriseDAO();
                        coreEnterprise = dao.getCoreEnterprise();
                    }
                    
                    if (coreEnterprise != null) {
                %>
                <div class="core-enterprise" onclick="navigateToEnterpriseDetail('<%= coreEnterprise.getEnterpriseID() %>')">
                    <h3>Core Enterprise</h3>
                    <p><strong>Core Enterprise Name:</strong> <%= coreEnterprise.getEnterpriseName() %></p>
                    <p><strong>Core Enterprise ID:</strong> <%= coreEnterprise.getEnterpriseID() %></p>
                    <p><strong>Contact:</strong> <%= coreEnterprise.getTelephone() %></p>
                    <button class="btn btn-primary" onclick="event.stopPropagation(); window.location.href='enterpriseDetail.jsp?id=<%= coreEnterprise.getEnterpriseID() %>';">SCDetails</button>
                </div>
                <% } else { %>
                <div class="core-enterprise">
                    <h3>Core Enterprise</h3>
                    <p>No core enterprise found in the database.</p>
                    <p>Please add a core enterprise through the Enterprise menu.</p>
                    <a href="singleEnterprise.jsp?mode=add" class="btn btn-primary">Add Core Enterprise</a>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Upstream and Downstream Suppliers Section -->
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h4 class="text-center mb-3">Upstream Suppliers (Tier 1)</h4>
                <%
                    // 声明并初始化变量
                    List<Enterprise> suppliers = null;
                    
                    // 获取一级供应商
                    EnterpriseDAO supplierDao = new EnterpriseDAO();
                    suppliers = supplierDao.getTier1Suppliers();
                    
                    if (suppliers != null && !suppliers.isEmpty()) {
                        for (Enterprise supplier : suppliers) {
                %>
                <div class="core-enterprise mb-3" onclick="navigateToEnterpriseDetail('<%= supplier.getEnterpriseID() %>')">
                    <h5><%= supplier.getEnterpriseName() %></h5>
                    <p><strong>Enterprise ID:</strong> <%= supplier.getEnterpriseID() %></p>
                    <p><strong>Type:</strong> Supplier (Tier 1)</p>
                    <p><strong>Contact:</strong> <%= supplier.getTelephone() != null ? supplier.getTelephone() : "N/A" %></p>
                    <button class="btn btn-primary" onclick="event.stopPropagation(); window.location.href='enterpriseDetail.jsp?id=<%= supplier.getEnterpriseID() %>';">SCDetails</button>
                </div>
                <% 
                        }
                    } else { 
                %>
                <div class="core-enterprise mb-3">
                    <h5>No Tier 1 Suppliers</h5>
                    <p>No tier 1 suppliers found in the database.</p>
                    <p>Please add a supplier through the Enterprise menu.</p>
                    <a href="singleEnterprise.jsp?mode=add" class="btn btn-primary">Add Supplier</a>
                </div>
                <% } %>
            </div>

            <div class="col-md-6">
                <h4 class="text-center mb-3">Downstream Distributors (Tier 1)</h4>
                <%
                    // 声明并初始化变量
                    List<Enterprise> distributors = null;
                    
                    // 获取一级分销商
                    EnterpriseDAO distributorDao = new EnterpriseDAO();
                    distributors = distributorDao.getTier1Distributors();
                    
                    if (distributors != null && !distributors.isEmpty()) {
                        for (Enterprise distributor : distributors) {
                %>
                <div class="core-enterprise mb-3" onclick="navigateToEnterpriseDetail('<%= distributor.getEnterpriseID() %>')">
                    <h5><%= distributor.getEnterpriseName() %></h5>
                    <p><strong>Enterprise ID:</strong> <%= distributor.getEnterpriseID() %></p>
                    <p><strong>Type:</strong> Distributor (Tier 1)</p>
                    <p><strong>Contact:</strong> <%= distributor.getTelephone() != null ? distributor.getTelephone() : "N/A" %></p>
                    <button class="btn btn-primary" onclick="event.stopPropagation(); window.location.href='enterpriseDetail.jsp?id=<%= distributor.getEnterpriseID() %>';">SCDetails</button>
                </div>
                <% 
                        }
                    } else { 
                %>
                <div class="core-enterprise mb-3">
                    <h5>No Tier 1 Distributors</h5>
                    <p>No tier 1 distributors found in the database.</p>
                    <p>Please add a distributor through the Enterprise menu.</p>
                    <a href="singleEnterprise.jsp?mode=add" class="btn btn-primary">Add Distributor</a>
                </div>
                <% } %>
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

    <script>
        // Function to navigate to enterprise detail page
        function navigateToEnterpriseDetail(id) {
            console.log("Enterprise ID received:", id);

            if (!id || id === "null" || id === "undefined") {
                alert('No enterprise ID provided');
                return;
            }

            // Ensure the ID is properly URL encoded
            var encodedId = encodeURIComponent(id);
            console.log("Navigating to:", "singleEnterprise.jsp?id=" + encodedId);

            window.location.href = "singleEnterprise.jsp?id=" + encodedId;
        }

        $(document).ready(function () {
            // Initialize dropdown menu
            $('.dropdown-toggle').dropdown();

            // Force re-initialization after a delay to ensure everything is loaded
            setTimeout(function () {
                $('.dropdown-toggle').dropdown();
            }, 200);

            // Add event listener to make dropdown work on hover too
            $('.dropdown').hover(
                function () {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100);
                },
                function () {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100);
                }
            );

            // 特别为User菜单添加点击处理
            $('#userDropdown').on('click', function (e) {
                if (!$(this).next('.dropdown-menu').hasClass('show')) {
                    e.preventDefault();
                    $(this).next('.dropdown-menu').addClass('show');
                }
            });
        });
    </script>
</body>
</html>