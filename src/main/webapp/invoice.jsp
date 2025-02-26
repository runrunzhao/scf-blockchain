-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contract Query - Supply Chain Finance</title>
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

        .search-panel {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .results-panel {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
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
            <a href="enterprise.jsp">Enterprise</a>
            <a href="contract.jsp">Contract</a>
            <a href="invoice.jsp">Invoice</a>
        </div>
    </div>

    <div class="container">
        <!-- Contract Search Section -->
        <div class="row">
            <div class="col-12">
                <div class="search-panel">
                    <h3 class="mb-4">Contract Search</h3>
                    <form id="contractSearchForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="contractId">Contract ID</label>
                                    <input type="text" class="form-control" id="contractId" placeholder="Enter Contract ID">
                                </div>
                                <div class="form-group">
                                    <label for="realContractNumber">Real Contract Number</label>
                                    <input type="text" class="form-control" id="realContractNumber" placeholder="Enter Real Contract Number">
                                </div>
                                <div class="form-group">
                                    <label for="contractDate">Contract Date</label>
                                    <input type="date" class="form-control" id="contractDate">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="enterpriseId">Core Enterprise ID</label>
                                    <input type="text" class="form-control" id="enterpriseId" placeholder="Enter Enterprise ID">
                                </div>
                                <div class="form-group">
                                    <label for="supplierId">Supplier ID</label>
                                    <input type="text" class="form-control" id="supplierId" placeholder="Enter Supplier ID">
                                </div>
                                <div class="form-group mt-4">
                                    <button type="button" class="btn btn-primary btn-block" onclick="searchContracts()">Search</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Search Results Section -->
        <div class="row">
            <div class="col-12">
                <div class="results-panel">
                    <h4 class="mb-4">Search Results</h4>
                    <div class="table-responsive">
                        <table class="table table-striped" id="resultsTable">
                            <thead>
                                <tr>
                                    <th>Contract ID</th>
                                    <th>Real Contract No.</th>
                                    <th>Core Enterprise</th>
                                    <th>Supplier</th>
                                    <th>Amount</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Sample data for demonstration -->
                                <tr ondblclick="viewContractDetails('C001')">
                                    <td>C001</td>
                                    <td>XYZ-2025-001</td>
                                    <td>XYZ Corporation</td>
                                    <td>Acme Suppliers</td>
                                    <td>$250,000</td>
                                    <td>01/15/2025</td>
                                    <td><span class="badge badge-success">Active</span></td>
                                </tr>
                                <tr ondblclick="viewContractDetails('C002')">
                                    <td>C002</td>
                                    <td>XYZ-2025-002</td>
                                    <td>XYZ Corporation</td>
                                    <td>Component Manufacturing Ltd</td>
                                    <td>$175,000</td>
                                    <td>01/28/2025</td>
                                    <td><span class="badge badge-success">Active</span></td>
                                </tr>
                                <tr ondblclick="viewContractDetails('C003')">
                                    <td>C003</td>
                                    <td>ABC-2025-001</td>
                                    <td>ABC Industries</td>
                                    <td>Global Supply Co.</td>
                                    <td>$320,000</td>
                                    <td>02/05/2025</td>
                                    <td><span class="badge badge-warning">Pending</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-muted mt-3">
                        <small>Double-click on a row to view contract details</small>
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
        // Function to search contracts based on form inputs
        function searchContracts() {
            const contractId = document.getElementById('contractId').value;
            const realContractNumber = document.getElementById('realContractNumber').value;
            const contractDate = document.getElementById('contractDate').value;
            const enterpriseId = document.getElementById('enterpriseId').value;
            const supplierId = document.getElementById('supplierId').value;
            
            // In a real implementation, this would make an AJAX call to fetch data
            console.log("Searching contracts with criteria:", {
                contractId,
                realContractNumber,
                contractDate,
                enterpriseId,
                supplierId
            });
            
            // For demo purposes, just show a success message
            alert("Search completed! Results displayed below.");
            
            // In a real implementation, the table would be populated with actual results
        }
        
        // Function to redirect to contract detail page
        function viewContractDetails(contractId) {
            window.location.href = `contractDetail.jsp?id=${contractId}`;
        }
    </script>
</body>

</html>