<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.supplychainfinance.model.Enterprise" %>
<%@ page import="com.supplychainfinance.model.Enterprise, java.util.List" %>
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
    </style>
</head>

<body>

    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            
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
        </div>
    </div>

    <div class="container">
        <!-- Core Enterprise Section -->
        <div class="row justify-content-center">
            <div class="col-md-6">
                <%
                // Get the core enterprise from request or directly from DAO
                Enterprise coreEnterprise = (Enterprise) request.getAttribute("coreEnterprise");
                
                // If not found through request attribute, try to get it directly
                if (coreEnterprise == null) {
                    // Import the DAO at the top of the file
                    com.supplychainfinance.dao.EnterpriseDAO dao = new com.supplychainfinance.dao.EnterpriseDAO();
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
                <%
                } else {
                %>
                <div class="core-enterprise">
                    <h3>Core Enterprise</h3>
                    <p>No core enterprise found in the database.</p>
                    <p>Please add a core enterprise through the Enterprise menu.</p>
                    <a href="singleEnterprise.jsp?mode=add" class="btn btn-primary">Add Core Enterprise</a>
                </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <!-- Replace the Upstream and Downstream Suppliers Section with this updated version -->
    <div class="container">
        <!-- Upstream and Downstream Suppliers Section -->
        <div class="row">
            <div class="col-md-6">
                <h4 class="text-center mb-3">Upstream Suppliers (Tier 1)</h4>
                <% 
                // Get tier 1 suppliers from database
                List<Enterprise> suppliers = new com.supplychainfinance.dao.EnterpriseDAO().getTier1Suppliers();
                
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
                // Get tier 1 distributors from database
                List<Enterprise> distributors = new com.supplychainfinance.dao.EnterpriseDAO().getTier1Distributors();
                
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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
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
        
        $(document).ready(function() {
            // Initialize dropdown menu
            $('.dropdown-toggle').dropdown();
            
            // Add event listener to make dropdown work on hover too
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
</body>
</html>