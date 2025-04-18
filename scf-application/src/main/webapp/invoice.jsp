<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice Search - Supply Chain Finance</title>
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
                    <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Enterprise
                    </a>
                    <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                        <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                        <a class="dropdown-item" href="enterpriseDetail.jsp?mode=add">Add New Enterprise</a>
                    </div>
                </div>

                <!-- Contract dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="contractDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Contract
                    </a>
                    <div class="dropdown-menu" aria-labelledby="contractDropdown">
                        <a class="dropdown-item" href="contract.jsp">Search Contracts</a>
                        <a class="dropdown-item" href="contractDetail.jsp?mode=add">Add New Contract</a>
                    </div>
                </div>

                <!-- Invoice dropdown menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="invoiceDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        Invoice
                    </a>
                    <div class="dropdown-menu" aria-labelledby="invoiceDropdown">
                        <a class="dropdown-item" href="invoice.jsp">Search Invoices</a>
                        <a class="dropdown-item" href="invoiceDetail.jsp?mode=add">Add New Invoice</a>

                    </div>
                </div>

                <!-- CTT menu -->
                <div class="dropdown d-inline-block">
                    <a class="dropdown-toggle" href="#" role="button" id="cttDropdown" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false"> CTT
                    </a>
                    <div class="dropdown-menu" aria-labelledby="cttDropdown">
                        <a class="dropdown-item" href="signSC.jsp">Sign SC</a>
                        <a class="dropdown-item" href="TGE.jsp">TGE</a>
                        <a class="dropdown-item" href="CTTinfo.jsp">Detail</a>
                        <a class="dropdown-item" href="AutoPayInvoice.jsp">AutoPay Invoice</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Search Form Section -->
            <div class="row">
                <div class="col-12">
                    <div class="search-form">
                        <h3 class="mb-4">Invoice Search</h3>
                        <form id="invoiceSearchForm">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="invoiceID">Invoice ID</label>
                                    <input type="text" class="form-control" id="invoiceID"
                                        placeholder="Enter Invoice ID">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="contractId">Contract ID</label>
                                    <input type="text" class="form-control" id="contractId"
                                        placeholder="Enter Contract ID">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="enterpriseName">Enterprise Name</label>
                                    <input type="text" class="form-control" id="enterpriseName"
                                        placeholder="Enter Enterprise Name">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="invoiceStatus">Invoice Status</label>
                                    <select class="form-control" id="invoiceStatus">
                                        <option value="">All Statuses</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Approved">Approved</option>
                                        <option value="Paid">Paid</option>
                                        <option value="Rejected">Rejected</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-2">
                                    <button type="button" class="btn btn-primary btn-block"
                                        onclick="searchInvoices()">Search</button>
                                </div>
                                <div class="col-md-3 mb-2">
                                    <button type="button" class="btn btn-secondary btn-block"
                                        onclick="resetForm()">Reset</button>
                                </div>
                                <div class="col-md-3 mb-2">
                                    <button type="button" class="btn btn-success btn-block"
                                        onclick="addNewInvoice()">Add New</button>
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
                            <p class="mt-2">Loading invoices...</p>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Invoice ID</th>
                                        <th>Contract ID</th>
                                        <th>Amount</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="resultsBody">
                                    <!-- Data will be populated dynamically -->
                                </tbody>
                            </table>
                        </div>
                        <div id="noResults" style="display: none;">
                            <p class="text-center">No invoices found matching your search criteria.</p>
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
            function searchInvoices() {
                const invoiceID = document.getElementById('invoiceID').value;
                const contractId = document.getElementById('contractId').value;
                const enterpriseName = document.getElementById('enterpriseName').value;
                const invoiceStatus = document.getElementById('invoiceStatus').value;

                console.log("Searching invoices with params - Invoice ID:", invoiceID,
                    "Contract ID:", contractId,
                    "Enterprise:", enterpriseName,
                    "Status:", invoiceStatus);

                // Show loading indicator
                document.getElementById('loading').style.display = 'block';
                document.getElementById('noResults').style.display = 'none';
                document.getElementById('resultsBody').innerHTML = '';

                // 实际的AJAX调用
                $.ajax({
                    url: 'getInvoices',  // 后端搜索API端点
                    type: 'GET',
                    data: {
                        invoiceID: invoiceID,
                        contractId: contractId,
                        enterpriseName: enterpriseName,
                        status: invoiceStatus
                    },
                    dataType: 'json',
                    success: function (data) {
                        console.log("搜索结果:", data);
                        document.getElementById('loading').style.display = 'none';

                        if (data && data.length > 0) {
                            // 渲染发票数据
                            renderInvoiceTable(data);
                        } else {
                            // 显示无结果消息
                            document.getElementById('noResults').style.display = 'block';
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("搜索错误:", error);
                        console.error("响应:", xhr.responseText);
                        document.getElementById('loading').style.display = 'none';
                        document.getElementById('noResults').style.display = 'block';
                        alert('搜索发票时出错: ' + error);
                    }
                });
            }

            // 渲染发票数据到表格中
            function renderInvoiceTable(invoices) {
                const tbody = document.getElementById('resultsBody');
                tbody.innerHTML = '';

                invoices.forEach(function (invoice) {
                    const row = document.createElement('tr');

                    // 使行可点击以查看发票详情
                    row.style.cursor = 'pointer';
                    row.addEventListener('dblclick', function () {
                        window.location.href = 'invoiceDetail.jsp?id=' + invoice.invoiceID;
                    });

                    // 发票ID
                    const idCell = document.createElement('td');
                    idCell.textContent = invoice.invoiceID;
                    row.appendChild(idCell);

                    // 合同ID
                    const contractCell = document.createElement('td');
                    contractCell.textContent = invoice.contractID;
                    row.appendChild(contractCell);


                    // 金额
                    const amountCell = document.createElement('td');
                    amountCell.textContent = formatCurrency(invoice.amount);
                    row.appendChild(amountCell);

                    // 日期
                    const dateCell = document.createElement('td');
                    dateCell.textContent = formatDate(invoice.payDate);
                    row.appendChild(dateCell);

                    // 状态
                    const statusCell = document.createElement('td');
                    statusCell.textContent = invoice.status;
                    row.appendChild(statusCell);

                    // 添加SC AutoPay按钮
                    const actionCell = document.createElement('td');
                    const autoPayButton = document.createElement('button');
                    autoPayButton.textContent = 'SC AutoPay';
                    autoPayButton.className = 'btn btn-sm btn-primary';
                    autoPayButton.addEventListener('click', function (e) {
                        e.stopPropagation(); // 防止触发行的双击事件
                        handleAutoPay(invoice.invoiceID);
                    });
                    actionCell.appendChild(autoPayButton);
                    row.appendChild(actionCell);

                    tbody.appendChild(row);
                });
            }


            // 处理AutoPay按钮点击
            function handleAutoPay(invoiceId) {
                // 跳转到AutoPay处理页面，传递发票ID参数
                window.location.href = 'autoPay.jsp?invoiceId=' + invoiceId;
            }
            // 格式化货币显示
            function formatCurrency(amount) {
                return new Intl.NumberFormat('en-US', {
                    style: 'currency',
                    currency: 'USD'
                }).format(amount);
            }

            // 格式化日期显示
            function formatDate(dateStr) {
                if (!dateStr) return '-';
                const date = new Date(dateStr);
                return date.toLocaleDateString();
            }

            // Function to reset the search form
            function resetForm() {
                document.getElementById('invoiceSearchForm').reset();
            }

            // Function to add new invoice
            function addNewInvoice() {
                window.location.href = "invoiceDetail.jsp?mode=add";
            }

            // Initialize when document is ready
            $(document).ready(function () {
                // Initialize dropdown menu
                $('.dropdown-toggle').dropdown();

                // Add event listener to make dropdown work on hover too
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