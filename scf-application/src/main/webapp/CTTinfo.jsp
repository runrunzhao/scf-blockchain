<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>CTT Information - Supply Chain Finance</title>
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

        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            margin-bottom: 20px;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            font-weight: bold;
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
        }

        .info-value {
            font-size: 24px;
            font-weight: bold;
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
        <h1>CTT Information</h1>
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
            
            <!-- CTT menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="cttDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    CTT
                </a>
                <div class="dropdown-menu" aria-labelledby="cttDropdown">
                    <a class="dropdown-item" href="TGE.jsp">TGE</a>
                    <a class="dropdown-item" href="CTTinfo.jsp">Detail</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <!-- Total Supply Card -->
            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-coins mr-2"></i> Total Supply
                    </div>
                    <div class="card-body text-center">
                        <p class="info-value" id="totalSupply">1,000,000</p>
                        <p class="text-muted">CTT</p>
                    </div>
                </div>
            </div>
            
            <!-- Issue Date Card -->
            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-header">
                        <i class="far fa-calendar-alt mr-2"></i> Issue Date
                    </div>
                    <div class="card-body text-center">
                        <p class="info-value" id="issueDate">Mar 01, 2025</p>
                        <p class="text-muted">Token Creation</p>
                    </div>
                </div>
            </div>
            
            <!-- Holders Card -->
            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-users mr-2"></i> Holders
                    </div>
                    <div class="card-body text-center">
                        <p class="info-value" id="holders">27</p>
                        <p class="text-muted">Unique Addresses</p>
                    </div>
                </div>
            </div>
            
            <!-- Total Transfers Card -->
            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-exchange-alt mr-2"></i> Total Transfers
                    </div>
                    <div class="card-body text-center">
                        <p class="info-value" id="transfers">142</p>
                        <p class="text-muted">Transactions</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional CTT Information Section -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-info-circle mr-2"></i> CTT Token Information
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th>Token Name</th>
                                        <td>Credit Transfer Token (CTT)</td>
                                    </tr>
                                    <tr>
                                        <th>Contract Address</th>
                                        <td>0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71</td>
                                    </tr>
                                    <tr>
                                        <th>Token Standard</th>
                                        <td>ERC-20</td>
                                    </tr>
                                    <tr>
                                        <th>Decimals</th>
                                        <td>18</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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

    <script>
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
            
            // You can load actual CTT data from server here
            // For now, we're using static data
            
            // Example of loading data from server (uncomment and modify as needed)
            /*
            $.ajax({
                url: "getCTTInfo",
                type: "GET",
                dataType: "json",
                success: function(response) {
                    if(response) {
                        $('#totalSupply').text(response.totalSupply.toLocaleString());
                        $('#issueDate').text(response.issueDate);
                        $('#holders').text(response.holders.toLocaleString());
                        $('#transfers').text(response.transfers.toLocaleString());
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error loading CTT info: " + error);
                }
            });
            */
        });
    </script>
</body>
</html>