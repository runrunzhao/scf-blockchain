<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Issue CTT Loan Details - Supply Chain Finance</title>
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

            .edit-mode {
                display: none;
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
        <!-- Header and Navigation Menu -->
        <div class="header">
            <h1>Supply Chain Finance Platform</h1>
            <div class="menu">
                <a href="index.jsp">Home</a>
                <a href="#user-management">User</a>
                <div class="dropdown d-inline-block">
                    <a href="#" class="dropdown-toggle" id="enterpriseDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Enterprise
                    </a>
                    <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                        <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                        <a class="dropdown-item" href="singleEnterprise.jsp?mode=add">Add New Enterprise</a>
                    </div>
                </div>
                <a href="contract.jsp">Contract</a>
                <a href="invoice.jsp">Invoice</a>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="detail-panel">
                        <form id="loanForm">

                            <input type="hidden" id="loanIssueID" name="loanIssueID">
                            <div class="form-group">
                                <label for="coreEnterprise">The coreEnterprise </label>
                                <input type="hidden" id="enterpriseID" name="enterpriseID" value="E2937293">
                                <input type="text" class="form-control" id="coreEnterprise" value="core enterprise"
                                    readonly>
                            </div>
                            <div class="form-group">
                                <label for="loanAmount">Loan Amount:</label>
                                <input type="number" class="form-control" id="loanAmount" required>
                            </div>
                            <div class="form-group">
                                <label for="interestRate">Interest Rate(Annual APR %):</label>
                                <input type="number" class="form-control" id="interestRate" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label for="issueDate">Loan Issue Date:</label>
                                <input type="date" class="form-control" id="issueDate" required>
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
                                <label for="correspondpingTXDate">correspondpingTX Date:</label>
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

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 Supply Chain Finance Platform | All rights reserved.</p>
        </div>

        <!-- Bootstrap and jQuery JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>


        <script>

            function goBack() {
                window.location.href = "CTTLoanSearch.jsp";
            }


            function loadCTTLoanDetails(loanIssueID) {
                if (!loanIssueID) {
                    console.log("No loan ID provided, assuming Create mode.");
                    // Set UI for create mode
                    $('h1').first().text('Issue New CTT Loan');
                    document.title = 'Issue New CTT Loan - Supply Chain Finance';
                    $('#loanForm button.btn-success').text('Issue Loan');
                    return; // Exit if no ID
                }

                console.log("Loading loan details for ID:", loanIssueID);

                $.ajax({
                    url: 'getLoanRecord', // Ensure this servlet URL is correct
                    type: 'GET',
                    data: { loanIssueID: loanIssueID },
                    dataType: 'json',
                    success: function (data) {
                        console.log("Raw server response:", JSON.stringify(data));


                        let loan = null;
                        if (data && data.success === true && data.loanRecord) {
                            loan = data.loanRecord;
                        } else if (data && data.loanIssueID) { // Direct object case
                            loan = data;
                        }

                        if (loan && loan.loanIssueID) {
                            console.log("Loan data loaded:", loan);

                            // Ensure hidden input exists and populate it
                            if ($('#loanIssueID').length === 0) {
                                $('<input>').attr({ type: 'hidden', id: 'loanIssueID', name: 'loanIssueID' }).appendTo('#loanForm');
                            }
                            $('#loanIssueID').val(loan.loanIssueID);

                            // Populate form fields using the 'loan' object
                            $('#loanAmount').val(loan.loanAmount !== undefined ? loan.loanAmount : '');
                            $('#interestRate').val(loan.interestRate !== undefined ? loan.interestRate : '');
                            $('#loanDueDate').val(loan.loanDueDate || '');
                            $('#correspondpingTX').val(loan.correspondpingTX || '');
                            $('#correspondpingTXDate').val(loan.correspondpingTXDate || '');
                            $('#loanDescription').val(loan.loanDescription || '');
                            $('#issueDate').val(loan.issueDate || ''); // Populate issue date if available


                            // Update UI for edit mode
                            $('h1').first().text('Edit CTT Loan Details');
                            document.title = 'Edit CTT Loan - Supply Chain Finance';
                            $('#loanForm button.btn-success').text('Update Loan');

                        } else {
                            // Handle cases where data is missing or format is wrong
                            const errorMessage = data && data.message ? data.message : "Could not find or load loan details for the specified ID.";
                            console.error("Error loading loan data:", errorMessage, "Raw data:", data);
                            alert(errorMessage);
                            // Optionally disable form or redirect
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error loading loan details:", error);
                        console.error("Server response:", xhr.responseText);
                        alert("Error loading loan details. Please try again later.");
                    },
                    complete: function () {
                        // Hide loading indicator if you have one
                        // $('#loadingIndicator').hide();
                    }
                });
            }

            function issueLoan(event) {
                // 1. Prevent default form submission behavior
                if (event) event.preventDefault();

                // 2. Get Loan ID (Should always exist in update-only scenario)
                const loanIssueID = $('#loanIssueID').val();

                // 3. Check if loanIssueID is present (essential for update)
                if (!loanIssueID) {
                    alert('Error: Loan ID is missing. Cannot update.');
                    console.error("Update attempt failed: loanIssueID is missing from the hidden input.");
                    return; // Stop if ID is missing
                }

                // 4. Gather data from form fields
                const loanData = {
                    loanIssueID: loanIssueID, // Always include the ID for update
                    loanAmount: $('#loanAmount').val(),
                    interestRate: $('#interestRate').val(),
                    loanDueDate: $('#loanDueDate').val(),
                    issueDate: $('#issueDate').val(), // Make sure this field exists in your form
                };

                // 5. Basic Client-Side Validation (Optional but Recommended)
                if (!loanData.loanAmount || !loanData.interestRate || !loanData.issueDate || !loanData.loanDueDate) {
                    alert('Please fill in all required fields (Loan Amount, Interest Rate, Issue Date, Due Date).');
                    return; // Stop submission if validation fails
                }

                // 6. Define the Servlet URL (Hardcoded for update)
                const actionUrl = 'updateLoanRecord';

                // 7. Log data being sent (for debugging)
                console.log(`Submitting update request to ${actionUrl}`, loanData);

                // 8. Update UI - Disable button and show loading text
                const $submitButton = $('#loanForm button.btn-success'); // Assumes the button always starts as "Update Loan"
                $submitButton.prop('disabled', true).text('Updating...');

                // 9. Perform AJAX POST request
                $.ajax({
                    url: actionUrl, // Hardcoded update URL
                    type: 'POST',
                    contentType: 'application/json', // Sending data as JSON
                    data: JSON.stringify(loanData), // Convert JS object to JSON string
                    success: function (response) {
                        // 10. Handle Success Response
                        if (response && response.success) {
                            alert('Loan updated successfully!');
                            window.location.href = 'CTTLoanSearch.jsp'; // Redirect back to search page
                        } else {
                            // Server indicated failure
                            alert(`Update failed: ${response ? response.message : 'Unknown server error'}`);
                            // Re-enable button on failure
                            $submitButton.prop('disabled', false).text('Update Loan');
                        }
                    },
                    error: function (xhr, status, error) {
                        // 11. Handle AJAX Error
                        console.error("Error updating loan:", error, xhr.responseText);
                        alert(`Error updating loan. Status: ${status}. Please check console for details.`);
                        // Re-enable button on error
                        $submitButton.prop('disabled', false).text('Update Loan');
                    }
                });
            }


            // --- Document Ready ---
            $(document).ready(function () {
                console.log("页面加载 - 初始化");

                // Get the loanIssueID from URL parameter
                const urlParams = new URLSearchParams(window.location.search);
                const loanIssueID = urlParams.get('loanIssueID');

                // Load details if ID exists
                loadCTTLoanDetails(loanIssueID);

                // Initialize Bootstrap dropdowns
                $('.dropdown-toggle').dropdown();

                // Add hover effect for dropdowns (optional)
                $('.dropdown').hover(
                    function () { $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100); },
                    function () { $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100); }
                );

                // Ensure buttons don't cause default form submission
                $('#loanForm button').each(function () {
                    if (!$(this).attr('type')) {
                        $(this).attr('type', 'button');
                    }
                });

            }); // End of $(document).ready()
        </script>

    </body>

    </html>