<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contract Details - Supply Chain Finance</title>
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

        .detail-panel {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .form-section {
            margin-bottom: 30px;
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

        /* Make the dropdown visible */
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

        /* Fix inline display */
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
            <a href="#user-management">User</a>
            
            <!-- Enterprise dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Enterprise
                </a>
                <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                    <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                    <a class="dropdown-item" href="enterpriseDetail.jsp?mode=add">Add New Enterprise</a>
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
            
            <a href="invoice.jsp">Invoice</a>
        </div>
    </div>

    <div class="container">
        <!-- Contract Details Panel -->
        <div class="row">
            <div class="col-12">
                <div class="detail-panel">
                    <h3 class="mb-4" id="panelTitle">Add New Contract</h3>
                    
                    <!-- Form for adding or editing a contract -->
                    <form id="contractForm">
                        <div class="form-section">
                            <h4>Basic Information</h4>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="contractId">Contract ID</label>
                                    <input type="text" class="form-control" id="contractId" placeholder="Auto-generated" readonly>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="contractName">Contract Name</label>
                                    <input type="text" class="form-control" id="contractName" placeholder="Enter Contract Name">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="contractType">Contract Type</label>
                                    <select class="form-control" id="contractType">
                                        <option value="Purchase">Purchase Contract</option>
                                        <option value="Sales">Sales Contract</option>
                                        <option value="Service">Service Contract</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="contractStatus">Status</label>
                                    <select class="form-control" id="contractStatus">
                                        <option value="Draft">Draft</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Active">Active</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h4>Enterprise Information</h4>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="fromEnterpriseId">From Enterprise</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="fromEnterpriseId" placeholder="Enterprise ID" readonly>
                                        <input type="text" class="form-control" id="fromEnterpriseName" placeholder="Enterprise Name" readonly>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button" onclick="selectFromEnterprise()">Select</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="toEnterpriseId">To Enterprise</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="toEnterpriseId" placeholder="Enterprise ID" readonly>
                                        <input type="text" class="form-control" id="toEnterpriseName" placeholder="Enterprise Name" readonly>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button" onclick="selectToEnterprise()">Select</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h4>Financial Information</h4>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="amount">Total Amount</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">$</span>
                                        </div>
                                        <input type="number" class="form-control" id="amount" placeholder="0.00" step="0.01">
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="signDate">Sign Date</label>
                                    <input type="date" class="form-control" id="signDate">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="effectiveDate">Effective Date</label>
                                    <input type="date" class="form-control" id="effectiveDate">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="expiryDate">Expiry Date</label>
                                    <input type="date" class="form-control" id="expiryDate">
                                </div>
                                <div class="form-group col-md-8">
                                    <label for="paymentTerms">Payment Terms</label>
                                    <input type="text" class="form-control" id="paymentTerms" placeholder="e.g., Net 30 days">
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h4>Additional Information</h4>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="description" rows="3" placeholder="Enter contract description"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="remarks">Remarks</label>
                                <textarea class="form-control" id="remarks" rows="2" placeholder="Any additional notes"></textarea>
                            </div>
                        </div>

                        <div class="form-row mt-4">
                            <div class="col-md-6 mb-2">
                                <button type="button" class="btn btn-primary btn-block" onclick="saveContract()">Save Contract</button>
                            </div>
                            <div class="col-md-6 mb-2">
                                <button type="button" class="btn btn-secondary btn-block" onclick="goBack()">Cancel</button>
                            </div>
                        </div>
                    </form>
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
        // Variable to track the current mode (add or view/edit)
        let isAddMode = true;
        
        // Function to initialize the page based on parameters
        function initPage() {
            const urlParams = new URLSearchParams(window.location.search);
            const id = urlParams.get('id');
            const mode = urlParams.get('mode');
            
            if (mode === 'add') {
                isAddMode = true;
                document.getElementById('panelTitle').innerText = 'Add New Contract';
                // Set today's date as the default sign date
                document.getElementById('signDate').valueAsDate = new Date();
            } else if (id) {
                isAddMode = false;
                document.getElementById('panelTitle').innerText = 'Contract Details';
                loadContractDetails(id);
            } else {
                alert('Invalid parameters. Redirecting to contract search.');
                window.location.href = 'contract.jsp';
            }
        }
        
        // Function to load contract details (for edit mode)
        function loadContractDetails(id) {
            // This would be an AJAX call to get contract details from the server
            // For now, just show an alert
            alert('Loading contract with ID: ' + id);
            
            // Simulate loading data after a delay
            setTimeout(() => {
                document.getElementById('contractId').value = id;
                document.getElementById('contractName').value = 'Sample Contract ' + id;
                // Set other fields...
            }, 500);
        }
        
        // Function to select from enterprise
        function selectFromEnterprise() {
            // Open a modal or navigate to a selection page
            alert('Enterprise selection feature will be implemented here');
            // For now, simulate selection
            document.getElementById('fromEnterpriseId').value = 'CORE001';
            document.getElementById('fromEnterpriseName').value = 'Central Manufacturing Inc.';
        }
        
        // Function to select to enterprise
        function selectToEnterprise() {
            // Open a modal or navigate to a selection page
            alert('Enterprise selection feature will be implemented here');
            // For now, simulate selection
            document.getElementById('toEnterpriseId').value = 'S001';
            document.getElementById('toEnterpriseName').value = 'FastSupply Materials Co.';
        }
        
        // Function to save the contract
        function saveContract() {
            // Validate form fields
            if (!validateForm()) {
                return;
            }
            
            // This would be an AJAX call to save the contract to the server
            alert('Contract saved successfully');
            
            // Redirect to contract search page
            window.location.href = 'contract.jsp';
        }
        
        // Function to validate the form
        function validateForm() {
            // Add your validation logic here
            const contractName = document.getElementById('contractName').value;
            if (!contractName) {
                alert('Please enter a contract name');
                return false;
            }
            
            return true;
        }
        
        // Function to go back to the previous page
        function goBack() {
            window.location.href = 'contract.jsp';
        }
        
        // Initialize when document is ready
        $(document).ready(function() {
            // Initialize page
            initPage();
            
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