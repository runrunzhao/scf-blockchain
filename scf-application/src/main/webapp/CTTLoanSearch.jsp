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
            background-color: #0056b3;
        }

        #loading {
            display: none;
            text-align: center;
            padding: 20px;
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
            <div class="dropdown d-inline-block">
                <a href="#" class="dropdown-toggle" id="enterpriseDropdown" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
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
        <!-- Search Form Section -->
        <div class="row">
            <div class="col-12">
                <div class="search-form">
                    <h3 class="mb-4">CTTLoan Search</h3>
                    <form id="enterpriseSearchForm">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="correspondpingTX">correspondpingTX</label>
                                <input type="text" class="form-control" id="correspondpingTX"
                                    placeholder="Enter corresponding TX">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="correspondpingTXDate">correspondpingTXDate</label>
                                <input type="text" class="form-control" id="correspondpingTXDate"
                                    placeholder="Enter corresponding TX Date">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="loanAmount">loanAmount</label>
                                <input type="text" class="form-control" id="loanAmount"
                                    placeholder="Enter loan amount">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-6 mb-2">
                                <button type="button" class="btn btn-primary btn-block"
                                    onclick="searchEnterprises()">Search</button>
                            </div>
                            <div class="col-md-3 mb-2">
                                <button type="button" class="btn btn-secondary btn-block"
                                    onclick="resetForm()">Reset</button>
                            </div>
                            <div class="col-md-3 mb-2">
                                <button type="button" class="btn btn-success btn-block" onclick="addNewEnterprise()">Add
                                    New</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Results Table Section -->
        <div class="row">
            <div class="col-12">
                <div class="results-table">
                    <h3 class="mb-4">Search Results</h3>
                    <div id="loading">
                        <div class="spinner-border text-primary" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                        <p class="mt-2">Loading enterprises...</p>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>loanIssueID</th>
                                    <th>loanAmount</th>
                                    <th>correspondpingTX</th>
                                    <th>correspondpingTXDate</th>                                  
                                </tr>
                            </thead>
                            <tbody id="resultsBody">
                                <!-- Data will be populated dynamically -->
                            </tbody>
                        </table>
                    </div>
                    <div id="noResults" style="display: none;">
                        <p class="text-center">No enterprises found matching your search criteria.</p>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script>
        // Function to search enterprises
        // Update the searchEnterprises function error handler:

        function searchEnterprises() {
            const enterpriseId = document.getElementById('enterpriseId').value;
            const enterpriseName = document.getElementById('enterpriseName').value;
            const enterpriseType = document.getElementById('enterpriseType').value;

            // Show loading indicator
            document.getElementById('loading').style.display = 'block';
            document.getElementById('noResults').style.display = 'none';
            document.getElementById('resultsBody').innerHTML = '';

            // Prepare search parameters
            const searchParams = new URLSearchParams();
            if (enterpriseId) searchParams.append('id', enterpriseId);
            if (enterpriseName) searchParams.append('name', enterpriseName);
            if (enterpriseType) searchParams.append('type', enterpriseType);

            // Log the search URL for debugging
            console.log('Search URL: searchEnterprises?' + searchParams.toString());

            // Send AJAX request to get enterprises
            $.ajax({
                url: 'searchEnterprises?' + searchParams.toString(),
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    // Hide loading indicator
                    document.getElementById('loading').style.display = 'none';

                    // Log the response for debugging
                    console.log('Search response:', data);

                    // Update results table
                    if (data && data.length > 0) {
                        renderEnterpriseTable(data);
                    } else {
                        document.getElementById('noResults').style.display = 'block';
                    }
                },
                error: function (xhr, status, error) {
                    // Hide loading indicator
                    document.getElementById('loading').style.display = 'none';

                    // Show error message with more details
                    console.error('Search error:', error);
                    console.error('Response text:', xhr.responseText);

                    // Update the UI to show the error
                    document.getElementById('resultsBody').innerHTML = '';
                    document.getElementById('noResults').style.display = 'block';
                    document.getElementById('noResults').innerHTML =
                        '<p class="text-danger">Error searching enterprises. Please check console for details.</p>';

                    // Alert with simplified error message
                    alert('Error searching enterprises. Please try again later.');
                }
            });
        }

        // Function to render enterprise table
        function renderEnterpriseTable(enterprises) {
            const tbody = document.getElementById('resultsBody');
            tbody.innerHTML = '';

            // Log the full data for debugging
            console.log("Enterprises data:", enterprises);

            enterprises.forEach(function (enterprise, index) {
                const row = document.createElement('tr');

                // Extract ID and ensure consistency
                const id = enterprise.enterpriseID || enterprise.id || enterprise.ID || '';
                console.log(`Enterprise ${index} ID:`, id);

                // 将ID存储为行的数据属性
                row.setAttribute('data-enterprise-id', id);

                // 使用jQuery绑定双击事件以确保可靠性
                $(row).dblclick(function () {
                    const clickedId = $(this).attr('data-enterprise-id');

                    showEnterpriseDetail(clickedId);
                });

                // Enterprise ID column
                const idCell = document.createElement('td');
                idCell.textContent = id;
                row.appendChild(idCell);

                // Name column
                const nameCell = document.createElement('td');
                nameCell.textContent = enterprise.enterpriseName;
                row.appendChild(nameCell);

                // Type column
                const typeCell = document.createElement('td');
                typeCell.textContent = getTypeDisplayText(enterprise.role);
                row.appendChild(typeCell);

                // Phone column
                const phoneCell = document.createElement('td');
                phoneCell.textContent = enterprise.telephone;
                row.appendChild(phoneCell);

                // Address column
                const addressCell = document.createElement('td');
                addressCell.textContent = enterprise.address;
                row.appendChild(addressCell);

                tbody.appendChild(row);
            });

            // 在渲染完成后添加调试信息
            console.log("Table rendering complete, rows count:", $('#resultsBody tr').length);
        }


        // Helper function to get display text for enterprise type
        function getTypeDisplayText(type) {
            switch (type) {
                case 'Core': return 'Core Enterprise';
                case 'Bank': return 'Bank';
                case 'Supplier': return 'Supplier';
                case 'Distributor': return 'Distributor';
                default: return type;
            }
        }

        // Function to reset the search form
        function resetForm() {
            document.getElementById('enterpriseSearchForm').reset();
        }

        function showEnterpriseDetail(id) {
            if (!id) {
                console.error("尝试查看详情但企业ID为空");
                alert("无法显示企业详情：缺少企业ID");
                return;
            }
            // 转义$符号防止JSP误解为EL表达式
            const url = "singleEnterprise.jsp?id=" + encodeURIComponent(id.trim());

            window.location.href = url;
        }

        // Function to add new enterprise
        function addNewEnterprise() {
            //window.location.href = "enterpriseDetail.jsp?mode=add";
            window.location.href = "singleEnterprise.jsp?mode=add";
        }

        // Load all enterprises when the page loads
        // $(document).ready(function () {
        //     searchEnterprises();
        //  });

        $(document).ready(function () {
            // Make sure dropdown works properly
            document.getElementById('noResults').style.display = 'block';
            document.getElementById('noResults').innerHTML =
                '<p class="text-center text-muted">Enter search criteria and click "Search" to find enterprises.</p>';


            $('.dropdown-toggle').dropdown();

            $('.dropdown').hover(
                function () {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100);
                },
                function () {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100);
                }
            );
        });

    </script>
</body>

</html>