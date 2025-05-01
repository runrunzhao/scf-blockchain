<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issue Loan - Supply Chain Finance</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
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
        .button-group {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            text-align: center;
        }
        .button-group button {
            margin: 0 10px;
            min-width: 100px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <p>Issue Loan</p>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="detail-panel">
                    <form id="loanForm">
                        <div class="form-group">
                            <label for="coreEnterprise">The coreEnterprise </label>
                            <input type="text" class="form-control" id="coreEnterprise" required>
                        </div>
                        <div class="form-group">
                            <label for="loanAmount">Loan Amount:</label>
                            <input type="number" class="form-control" id="loanAmount" required>
                        </div>
                        <div class="form-group">
                            <label for="interestRate">Interest Rate:</label>
                            <input type="number" class="form-control" id="interestRate" step="0.01" required>
                        </div>
                         <div class="form-group">
                            <label for="loanDueDate">Loan Due Date:</label>
                            <input type="date" class="form-control" id="loanDueDate" required>
                        </div>
                        <div class="form-group">
                            <label for="correspondpingTX">correspondpingTX</label>
                            <input type="text" class="form-control" id="correspondpingTX" required>
                        </div>
                        <div class="form-group">
                            <label for="correspondpingTXDate">correspondpingTX  Date:</label>
                            <input type="text" class="form-control" id="correspondpingTXDate" required>
                        </div>
                        <div class="form-group">
                            <label for="loanDescription">Loan Description:</label>
                            <textarea class="form-control" id="loanDescription" rows="3"></textarea>
                        </div>
                        <div class="button-group">
                            <button class="btn btn-success" onclick="issueLoan()">Issue Loan</button>
                            <button class="btn btn-secondary" onclick="goBack()">Back</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script>
        function goBack() {
            window.location.href = "index.jsp"; // Or wherever you want to go back to
        }

        function issueLoan() {
            const loanData = {
                borrowerAddress: document.getElementById('borrowerAddress').value,
                loanAmount: document.getElementById('loanAmount').value,
                interestRate: document.getElementById('interestRate').value,
                loanTerm: document.getElementById('loanTerm').value,
                loanDueDate: document.getElementById('loanDueDate').value,
                loanDescription: document.getElementById('loanDescription').value
            };

            // Basic validation
            if (!loanData.borrowerAddress || !loanData.loanAmount || !loanData.interestRate || !loanData.loanTerm || !loanData.loanDueDate) {
                alert("Please fill in all required fields.");
                return;
            }

            $.ajax({
                url: 'createLoanRecord', // Make sure this URL is correct
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(loanData),
                success: function (response) {
                    if (response.success) {
                        alert('Loan record created successfully!');
                        document.getElementById('loanForm').reset(); // Clear the form
                    } else {
                        alert('Error creating loan record: ' + (response.message || 'Unknown error'));
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error creating loan record:", xhr.responseText);
                    alert('Error creating loan record: ' + error);
                }
            });
        }
    </script>
</body>
</html>