jsp -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Details - Supply Chain Finance</title>
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

        .card {
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            <a href="#user-management">User Management</a>
            <a href="enterprise.jsp">Enterprise Query</a>
            <a href="contract.jsp">Contract Query</a>
            <a href="invoice.jsp">Invoice Query</a>
        </div>
    </div>

    <div class="container">
        <!-- Enterprise Detail Section -->
        <div class="row">
            <div class="col-12">
                <div class="detail-panel">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3>Enterprise Details</h3>
                        <button class="btn btn-secondary" onclick="goBack()">Back to Search</button>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><strong>Enterprise ID:</strong></label>
                                <p id="detailId">001</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Enterprise Name:</strong></label>
                                <p id="detailName">XYZ Corporation</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Type:</strong></label>
                                <p id="detailType">Core Enterprise</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><strong>Contact Number:</strong></label>
                                <p id="detailContact">+123-456-7890</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Email:</strong></label>
                                <p id="detailEmail">info@xyzcorp.com</p>
                            </div>
                            <div class="form-group">
                                <label><strong>Address:</strong></label>
                                <p id="detailAddress">123 Business Park, Finance District, 10001</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Entities Section -->
        <div class="row">
            <div class="col-12">
                <div class="related-entities">
                    <h4 class="mb-4">Related Entities</h4>

                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="suppliers-tab" data-toggle="tab" href="#suppliers" role="tab">Suppliers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="distributors-tab" data-toggle="tab" href="#distributors" role="tab">Distributors</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="contracts-tab" data-toggle="tab" href="#contracts" role="tab">Contracts</a>
                        </li>
                    </ul>
                    <div class="tab-content pt-3" id="myTabContent">
                        <div class="tab-pane fade show active" id="suppliers" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Acme Suppliers</h5>
                                    <p class="card-text">Tier: 1</p>
                                    <a href="enterpriseDetail.jsp?id=S001" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Component Manufacturing Ltd</h5>
                                    <p class="card-text">Tier: 2</p>
                                    <a href="enterpriseDetail.jsp?id=S002" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="distributors" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Global Distribution Inc.</h5>
                                    <p class="card-text">Tier: 1</p>
                                    <a href="enterpriseDetail.jsp?id=D001" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Regional Sales Co.</h5>
                                    <p class="card-text">Tier: 2</p>
                                    <a href="enterpriseDetail.jsp?id=D002" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="contracts" role="tabpanel">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Contract ID</th>
                                            <th>Real No.</th>
                                            <th>Amount</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>C001</td>
                                            <td>XYZ-2025-001</td>
                                            <td>$250,000</td>
                                            <td>01/15/2025</td>
                                            <td><a href="contractDetail.jsp?id=C001" class="btn btn-sm btn-info">View</a></td>
                                        </tr>
                                        <tr>
                                            <td>C002</td>
                                            <td>XYZ-2025-002</td>
                                            <td>$175,000</td>
                                            <td>01/28/2025</td>
                                            <td><a href="contractDetail.jsp?id=C002" class="btn btn-sm btn-info">View</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script>
        // Function to go back to search page
        function goBack() {
            window.location.href = "enterprise.jsp";
        }

        // Function to load enterprise details based on the ID from query parameter
        function loadEnterpriseDetails() {
            // Get ID from URL
            const urlParams = new URLSearchParams(window.location.search);
            const id = urlParams.get('id');
            
            // In a real implementation, this would make an AJAX call to fetch data
            // For demo purposes, just show the ID in the console
            console.log("Loading details for enterprise ID:", id);
            
            // We could update the page elements with actual data here
            document.title = `Enterprise Details: ${id} - Supply Chain Finance`;
        }

        // Call the function when the page loads
        window.onload = loadEnterpriseDetails;
    </script>
</body>

</html>