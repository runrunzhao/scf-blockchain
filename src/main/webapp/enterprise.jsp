/webapp/enterprise.jsp -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Query - Supply Chain Finance</title>
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

        .search-form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .results-table {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .results-table table tbody tr {
            cursor: pointer;
        }

        .results-table table tbody tr:hover {
            background-color: #f1f1f1;
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
        <!-- Search Form Section -->
        <div class="row">
            <div class="col-12">
                <div class="search-form">
                    <h3 class="mb-4">Enterprise Search</h3>
                    <form id="enterpriseSearchForm">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="enterpriseId">Enterprise ID</label>
                                <input type="text" class="form-control" id="enterpriseId" placeholder="Enter Enterprise ID">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="enterpriseName">Enterprise Name</label>
                                <input type="text" class="form-control" id="enterpriseName" placeholder="Enter Enterprise Name">
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="searchEnterprises()">Search</button>
                        <button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Results Table Section -->
        <div class="row">
            <div class="col-12">
                <div class="results-table">
                    <h3 class="mb-4">Search Results</h3>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Enterprise ID</th>
                                    <th>Name</th>
                                    <th>Type</th>
                                    <th>Phone</th>
                                </tr>
                            </thead>
                            <tbody id="resultsBody">
                                <!-- Sample data, would be populated dynamically -->
                                <tr ondblclick="showEnterpriseDetail('001')">
                                    <td>001</td>
                                    <td>XYZ Corporation</td>
                                    <td>Core Enterprise</td>
                                    <td>+123-456-7890</td>
                                </tr>
                                <tr ondblclick="showEnterpriseDetail('S001')">
                                    <td>S001</td>
                                    <td>Acme Suppliers</td>
                                    <td>Supplier (Tier 1)</td>
                                    <td>+123-567-8901</td>
                                </tr>
                                <tr ondblclick="showEnterpriseDetail('D001')">
                                    <td>D001</td>
                                    <td>Global Distribution Inc.</td>
                                    <td>Distributor (Tier 1)</td>
                                    <td>+123-678-9012</td>
                                </tr>
                            </tbody>
                        </table>
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
        // Function to search enterprises (would connect to backend in a real implementation)
        function searchEnterprises() {
            const enterpriseId = document.getElementById('enterpriseId').value;
            const enterpriseName = document.getElementById('enterpriseName').value;
            
            // For demo, just show an alert
            alert(`Searching for enterprises with ID: ${enterpriseId} and Name: ${enterpriseName}`);
            // In a real implementation, this would make an AJAX call and update the table
        }

        // Function to reset the search form
        function resetForm() {
            document.getElementById('enterpriseSearchForm').reset();
        }

        // Function to show enterprise details
        function showEnterpriseDetail(id) {
            window.location.href = `enterpriseDetail.jsp?id=${id}`;
        }
    </script>
</body>

</html>