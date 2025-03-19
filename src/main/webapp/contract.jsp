<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.supplychainfinance.model.Contract" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html lang="en">
            <!-- Rest of your contract.jsp file -->
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Contract Search - Supply Chain Finance</title>
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

                        <!-- Enterprise dropdown menu -->
                        <div class="dropdown d-inline-block">
                            <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Enterprise
                            </a>
                            <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                                <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                                <a class="dropdown-item" href="enterpriseDetail.jsp?mode=add">Add New Enterprise</a>
                            </div>
                        </div>

                        <!-- Contract dropdown menu -->
                        <div class="dropdown d-inline-block">
                            <a class="dropdown-toggle" href="#" role="button" id="contractDropdown"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
                    <!-- Search Form Section -->
                    <div class="row">
                        <div class="col-12">
                            <div class="search-form">
                                <h3 class="mb-4">Contract Search</h3>
                                <form id="contractSearchForm">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="contractId">Contract ID</label>
                                            <input type="text" class="form-control" id="contractId"
                                                placeholder="Enter Contract ID">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="enterpriseName">Enterprise Name</label>
                                            <input type="text" class="form-control" id="enterpriseName"
                                                placeholder="Enter Enterprise Name">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="contractStatus">Contract Status</label>
                                            <select class="form-control" id="contractStatus">
                                                <option value="">All Statuses</option>
                                                <option value="Draft">Draft</option>
                                                <option value="Pending">Pending</option>
                                                <option value="Active">Active</option>
                                                <option value="Completed">Completed</option>
                                                <option value="Cancelled">Cancelled</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="contractType">Contract Type</label>
                                            <select class="form-control" id="contractType">
                                                <option value="">All Types</option>
                                                <option value="Purchase">Purchase Contract</option>
                                                <option value="Sales">Sales Contract</option>
                                                <option value="Service">Service Contract</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6 mb-2">
                                            <button type="button" class="btn btn-primary btn-block"
                                                onclick="searchContracts()">Search</button>
                                        </div>
                                        <div class="col-md-3 mb-2">
                                            <button type="button" class="btn btn-secondary btn-block"
                                                onclick="resetForm()">Reset</button>
                                        </div>
                                        <div class="col-md-3 mb-2">
                                            <button type="button" class="btn btn-success btn-block"
                                                onclick="addNewContract()">Add New</button>
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
                                    <p class="mt-2">Loading contracts...</p>
                                </div>
                                <div class="table-responsive">
                                    <!-- Update the table headers in contract.jsp -->
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Contract ID</th>
                                                <th>Real No</th>
                                                <th>Amount</th>
                                                <th>Signing Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="resultsBody">
                                            <!-- Data will be populated dynamically -->
                                        </tbody>
                                    </table>
                                </div>
                                <div id="noResults" style="display: none;">
                                    <p class="text-center">No contracts found matching your search criteria.</p>
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
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

                <script>
                    // 导航到新建合同页面
                    function addNewContract() {
                        window.location.href = 'contractDetail.jsp?mode=add';
                    }

                    // 格式化日期为 DD/MM/YYYY 格式
                    function formatDateToDDMMYYYY(dateStr) {
                        console.log("Format date input:", dateStr, "type:", typeof dateStr);

                        // 如果是空值，直接返回空字符串
                        if (!dateStr) {
                            console.log("Empty date input");
                            return '';
                        }

                        try {
                            // 创建日期对象
                            let date;

                            // 根据输入类型处理
                            if (typeof dateStr === 'object') {
                                // 如果已经是日期对象
                                date = dateStr;
                                console.log("Date is already an object");
                            } else if (typeof dateStr === 'number') {
                                // 如果是时间戳
                                date = new Date(dateStr);
                                console.log("Date is a timestamp:", dateStr);
                            } else if (typeof dateStr === 'string') {
                                // 处理各种字符串格式
                                console.log("Date is a string:", dateStr);

                                if (dateStr.includes('T')) {
                                    // ISO 格式: 2023-01-01T00:00:00.000Z
                                    date = new Date(dateStr);
                                    console.log("Parsed ISO format:", date);
                                } else if (dateStr.includes('-')) {
                                    // YYYY-MM-DD 格式
                                    const parts = dateStr.split('-');
                                    if (parts.length === 3) {
                                        date = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
                                        console.log("Parsed YYYY-MM-DD format:", date);
                                    } else {
                                        date = new Date(dateStr);
                                    }
                                } else if (dateStr.includes('/')) {
                                    // 可能是 DD/MM/YYYY 或 MM/DD/YYYY 格式
                                    const parts = dateStr.split('/');
                                    if (parts.length === 3) {
                                        if (parts[2].length === 4) {
                                            // 假设是 DD/MM/YYYY 格式
                                            date = new Date(parseInt(parts[2]), parseInt(parts[1]) - 1, parseInt(parts[0]));
                                            console.log("Parsed DD/MM/YYYY format:", date);
                                        } else {
                                            // 假设是 MM/DD/YYYY 格式
                                            date = new Date(parseInt(parts[2]), parseInt(parts[0]) - 1, parseInt(parts[1]));
                                            console.log("Parsed MM/DD/YYYY format:", date);
                                        }
                                    } else {
                                        date = new Date(dateStr);
                                    }
                                } else {
                                    // 尝试直接解析
                                    date = new Date(dateStr);
                                    console.log("Used default date parsing:", date);
                                }
                            }

                            // 检查日期是否有效
                            if (date && !isNaN(date.getTime())) {
                                // 返回 DD/MM/YYYY 格式
                                let result = String(date.getDate()).padStart(2, '0') + '/' +
                                    String(date.getMonth() + 1).padStart(2, '0') + '/' +
                                    date.getFullYear();
                                console.log("Formatted date result:", result);
                                return result;
                            } else {
                                console.log("Invalid date object or NaN time");
                            }
                        } catch (e) {
                            console.error("Error formatting date:", e, "for date:", dateStr);
                        }

                        // 如果无法解析，尝试直接使用原值
                        console.warn("Could not format date, returning original:", dateStr);
                        return String(dateStr);
                    }

                    // 查看合同详情
                    function viewContract(contractId) {
                        window.location.href = 'contractDetail.jsp?contractId=' + contractId + '&mode=view';
                    }

                    // 重置搜索表单
                    function resetForm() {
                        document.getElementById('contractId').value = '';
                        document.getElementById('enterpriseName').value = '';
                        document.getElementById('contractStatus').value = '';
                        document.getElementById('contractType').value = '';
                        document.getElementById('resultsBody').innerHTML = '';
                        document.getElementById('noResults').style.display = 'none';
                    }

                    // 搜索合同函数
                    function searchContracts() {
                        const contractId = document.getElementById('contractId').value;
                        const enterpriseName = document.getElementById('enterpriseName').value;
                        const contractStatus = document.getElementById('contractStatus').value;

                        console.log("Searching contracts with params - ID:", contractId, "Enterprise:", enterpriseName,
                            "Status:", contractStatus);

                        // Show loading indicator
                        document.getElementById('loading').style.display = 'block';
                        document.getElementById('noResults').style.display = 'none';
                        document.getElementById('resultsBody').innerHTML = '';

                        // Perform AJAX call to search contracts
                        $.ajax({
                            url: "searchContract",
                            type: "GET",
                            data: {
                                contractId: contractId,
                                enterpriseName: enterpriseName,
                                contractStatus: contractStatus
                            },
                            dataType: "json",
                            success: function (contracts) {
                                document.getElementById('loading').style.display = 'none';
                                console.log("Received contracts data:", contracts);

                                if (!contracts || contracts.length === 0) {
                                    document.getElementById('noResults').style.display = 'block';
                                } else {
                                    let html = '';

                                    contracts.forEach(function (contract) {
                                        console.log("Processing contract:", contract);

                                        // 输出日期原始值，以便调试
                                        console.log("Raw sign date:", contract.signDate);

                                        // 格式化日期
                                        let formattedDate = '';
                                        if (contract.signDate) {
                                            formattedDate = formatDateToDDMMYYYY(contract.signDate);
                                        } else if (contract.formattedSignDate) {
                                            // 尝试使用预格式化的日期
                                            formattedDate = contract.formattedSignDate;
                                        }
                                        console.log("Formatted date result:", formattedDate);

                                        // 格式化金额
                                        let formattedAmount = '$' + (contract.amount ? parseFloat(contract.amount).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : '0.00');

                                        // 构建表格行 - 与表头匹配
                                        html += '<tr onclick="viewContract(\'' + contract.contractId + '\')">';
                                        html += '<td>' + (contract.contractId || '') + '</td>';
                                        html += '<td>' + (contract.contractName || '') + '</td>';
                                        html += '<td>' + formattedAmount + '</td>';
                                        html += '<td>' + formattedDate + '</td>';
                                        html += '<td>' + (contract.status || '') + '</td>';
                                        html += '</tr>';
                                    });

                                    document.getElementById('resultsBody').innerHTML = html;
                                }
                            },
                            error: function (xhr, status, error) {
                                document.getElementById('loading').style.display = 'none';
                                console.error("AJAX Error:", status, error);
                                console.error("Response Text:", xhr.responseText);

                                try {
                                    // Try to parse as JSON error message
                                    const errorData = JSON.parse(xhr.responseText);
                                    if (errorData && errorData.error) {
                                        alert("Error searching contracts: " + errorData.error);
                                    } else {
                                        alert("Error searching contracts. See console for details.");
                                    }
                                } catch (e) {
                                    alert("Error searching contracts. Server returned an invalid response.");
                                }

                                // Show error in the results area
                                document.getElementById('resultsBody').innerHTML = '<tr><td colspan="5" class="text-danger">Error occurred while searching. Please try again.</td></tr>';
                            }
                        });
                    }
                </script>
            </body>

            </html>