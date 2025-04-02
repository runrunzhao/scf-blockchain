<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>TGE - Token Generation Event</title>
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

        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .card-header {
            font-weight: bold;
            background-color: #007bff;
            color: white;
        }

        .btn-generate {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .btn-generate:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <div class="container">
        <!-- Static Information Section -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-info-circle mr-2"></i> Limit Information
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <p><strong>Bank Name:</strong> ABC Bank</p>
                    </div>
                    <div class="col-md-4">
                        <p><strong>Limit:</strong> $1,000,000</p>
                    </div>
                    <div class="col-md-4">
                        <p><strong>Invalid Date:</strong> Dec 31, 2025</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Input Form Section -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-edit mr-2"></i> Generate Token
            </div>
            <div class="card-body">
                <form action="generateToken" method="post">
                    <div class="form-group">
                        <label for="tokenName">Token Name:</label>
                        <input type="text" class="form-control" id="tokenName" name="tokenName" placeholder="Enter Token Name" required>
                    </div>
                    <div class="form-group">
                        <label for="tokenTracker">Token Tracker:</label>
                        <input type="text" class="form-control" id="tokenTracker" name="tokenTracker" placeholder="Enter Token Tracker" required>
                    </div>
                    <div class="form-group">
                        <label for="amount">Amount:</label>
                        <input type="number" class="form-control" id="amount" name="amount" placeholder="Enter Amount" required>
                    </div>
                    <div class="form-group">
                        <label for="invalidDate">Invalid Date:</label>
                        <input type="date" class="form-control" id="invalidDate" name="invalidDate" required>
                    </div>
                    <button type="submit" class="btn btn-generate btn-block">Generate Token</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</body>

</html>