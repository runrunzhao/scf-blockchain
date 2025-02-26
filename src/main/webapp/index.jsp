<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        }

        .core-enterprise {
            text-align: center;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
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
    </style>
</head>

<body>

    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="#user-management">User Management</a>
            <a href="#enterprise-query">Enterprise Query</a>
            <a href="#contract-query">Contract Query</a>
            <a href="#invoice-query">Invoice Query</a>
        </div>
    </div>

    <div class="container">
        <!-- Core Enterprise Section -->
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="core-enterprise">
                    <h3>Core Enterprise</h3>
                    <p><strong>Core Enterprise Name:</strong> XYZ Corporation</p>
                    <p><strong>Core Enterprise ID:</strong> 001</p>
                    <p><strong>Contact:</strong> +123-456-7890</p>
                    <button class="btn btn-primary" onclick="showDetails()">Show Details</button>
                </div>
            </div>
        </div>

        <!-- Upstream and Downstream Suppliers Section -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Upstream Supplier 1</h5>
                        <p class="card-text">Tier: Tier 1</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Upstream Supplier 2</h5>
                        <p class="card-text">Tier: Tier 2</p>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Downstream Distributor 1</h5>
                        <p class="card-text">Tier: Tier 1</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Downstream Distributor 2</h5>
                        <p class="card-text">Tier: Tier 2</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
    </div>

    <!-- Bootstrap and jQuery JS (needed for Bootstrap features like buttons and modals) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script>
        // JavaScript function to show more details about the core enterprise
        function showDetails() {
            alert('Displaying more details about Core Enterprise...');
        }
    </script>
</body>

</html>
