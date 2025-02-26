webapp/contractDetail.jsp -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contract Details - Supply Chain Finance</title>
    <!-- Bootstrap CSS -->
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
            margin-bottom: 20px;
        }

        .related-entities {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            display: inline-block;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background-color: #cce5ff;
            color: #004085;
        }

        hr.section-divider {
            border-top: 1px solid #eaeaea;
            margin: 25px 0;
        }
    </style>
</head>

<body>

    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            <a href="#user-management">User </a>
            <a href="enterprise.jsp">Enterprise</a>
            <a href="contract.jsp">Contract</a>
            <a href="invoice.jsp">Invoice</a>
        </div>
    </div>

    <div class="container">
        <!-- Contract Detail Section -->
        <div class="row">
            <div class="col-12">
                <div class="detail-panel">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3>Contract Details</h3>
                        <button class="btn btn-secondary" onclick="goBack()">Back to Search</button>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><strong>Contract ID:</strong></label>
                                <p id="detailId">C001</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Real Contract Number:</strong></label>
                                <p id="detailRealNo">XYZ-2025-001</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Amount:</strong></label>
                                <p id="detailAmount">$250,000</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Date:</strong></label>
                                <p id="detailDate">January 15, 2025</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><strong>Status:</strong></label>
                                <p><span class="status-badge status-active" id="detailStatus">Active</span></p>
                            </div>
                            <div class="form-group">
                                <label><strong>Core Enterprise:</strong></label>
                                <p id="detailCoreEnterprise">XYZ Corporation (001)</p>
                                <a href="enterpriseDetail.jsp?id=001" class="btn btn-sm btn-info">View Enterprise</a>
                            </div>
                            <div class="form-group">
                                <label><strong>Supplier:</strong></label>
                                <p id="detailSupplier">Acme Suppliers (S001)</p>
                                <a href="enterpriseDetail.jsp?id=S001" class="btn btn-sm btn-info">View Supplier</a>
                            </div>
                        </div>
                    </div>

                    <hr class="section-divider">

                    <div class="row">
                        <div class="col-12">
                            <h5>Contract Description</h5>
                            <div class="form-group">
                                <label><strong>Part 1:</strong></label>
                                <p id="detailPart1">This contract covers the supply of raw materials for Q1 2025 production requirements for XYZ Corporation. The agreement includes all delivery schedules and quality requirements as per attached specifications.</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Part 2:</strong></label>
                                <p id="detailPart2">Payment terms are Net 60 from the date of delivery, with 2% discount if paid within 15 days. All deliveries must be accompanied by quality certificates and must meet ISO 9001 standards.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Invoices Section -->
        <div class="row">
            <div class="col-12">
                <div class="related-entities">
                    <h4 class="mb-4">Related Invoices</h4>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Invoice ID</th>
                                    <th>Amount</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>INV001</td>
                                    <td>$85,000</td>
                                    <td>01/30/2025</td>
                                    <td><span class="badge badge-success">Paid</span></td>
                                    <td><a href="invoiceDetail.jsp?id=INV001" class="btn btn-sm btn-info">View</a></td>
                                </tr>
                                <tr>
                                    <td>INV002</td>
                                    <td>$75,000</td>
                                    <td>02/15/2025</td>
                                    <td><span class="badge badge-warning">Pending</span></td>
                                    <td><a href="invoiceDetail.jsp?id=INV002" class="btn btn-sm btn-info">View</a></td>
                                </tr>
                                <tr>
                                    <td>INV003</td>
                                    <td>$90,000</td>
                                    <td>03/01/2025</td>
                                    <td><span class="badge badge-secondary">Draft</span></td>
                                    <td><a href="invoiceDetail.jsp?id=INV003" class="btn btn-sm btn-info">View</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contract Timeline Section -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="related-entities">
                    <h4 class="mb-4">Contract Timeline</h4>
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>Contract Created</strong>
                                <p class="mb-0 text-muted">Initial draft created by John Smith</p>
                            </div>
                            <span class="badge badge-primary badge-pill">Jan 10, 2025</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>Contract Approved</strong>
                                <p class="mb-0 text-muted">Approved by financial department</p>
                            </div>
                            <span class="badge badge-primary badge-pill">Jan 12, 2025</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>Contract Signed</strong>
                                <p class="mb-0 text-muted">Signed by both parties</p>
                            </div>
                            <span class="badge badge-primary badge-pill">Jan 15, 2025</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>First Delivery</strong>
                                <p class="mb-0 text-muted">Initial batch delivered to XYZ Corporation</p>
                            </div>
                            <span class="badge badge-primary badge-pill">Jan 25, 2025</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
    </div>

    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script>
        // Function to go back to search page
        function goBack() {
            window.location.href = "contract.jsp";
        }

        // Function to load contract details based on the ID from query parameter
        function loadContractDetails() {
            // Get ID from URL
            const urlParams = new URLSearchParams(window.location.search);
            const id = urlParams.get('id');
            
            // In a real implementation, this would make an AJAX call to fetch data
            // For demo purposes, just show the ID in the console
            console.log("Loading details for contract ID:", id);
            
            // We could update the page elements with actual data here
            document.title = `Contract Details: ${id} - Supply Chain Finance`;
            
            // Example of updating status badge based on contract ID
            if (id === 'C003') {
                document.getElementById('detailStatus').textContent = 'Pending';
                document.getElementById('detailStatus').className = 'status-badge status-pending';
            }
        }

        // Call the function when the page loads
        window.onload = loadContractDetails;
    </script>
</body>

</html>