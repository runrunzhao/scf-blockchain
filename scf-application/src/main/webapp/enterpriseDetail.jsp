<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <!-- Enterprise Detail Section -->
            <div class="row">
                <div class="col-12">
                    <div class="detail-panel">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3 id="pageTitle">Enterprise Details</h3>
                            <!-- Removed Edit and Back buttons as requested -->
                        </div>

                        <!-- Display-only view -->
                        <div id="viewMode">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><strong>Enterprise ID:</strong></label>
                                        <p id="detailId">-</p>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Enterprise Name:</strong></label>
                                        <p id="detailName">-</p>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Type:</strong></label>
                                        <p id="detailType">-</p>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Tier:</strong></label>
                                        <p id="detailTier">-</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><strong>Contact Number:</strong></label>
                                        <p id="detailContact">-</p>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Address:</strong></label>
                                        <p id="detailAddress">-</p>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Memo:</strong></label>
                                        <p id="detailMemo">-</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Related Entities Section -->
            <div class="row" id="relatedEntitiesSection">
                <div class="col-12">
                    <div class="related-entities">
                        <h4 class="mb-4">Related Entities</h4>

                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="suppliers-tab" data-toggle="tab" href="#suppliers"
                                    role="tab">Suppliers</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="distributors-tab" data-toggle="tab" href="#distributors"
                                    role="tab">Distributors</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="contracts-tab" data-toggle="tab" href="#contracts"
                                    role="tab">Contracts</a>
                            </li>
                        </ul>
                        <div class="tab-content pt-3" id="myTabContent">
                            <!-- 空的内容区域，将被JavaScript动态填充 -->
                            <div class="tab-pane fade show active" id="suppliers" role="tabpanel">
                                <div class="text-center py-3">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                    <p class="mt-2">Loading suppliers...</p>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="distributors" role="tabpanel">
                                <!-- 将在点击时动态加载 -->
                            </div>
                            <div class="tab-pane fade" id="contracts" role="tabpanel">
                                <!-- 将在点击时动态加载 -->
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script>
            // 变量和基础函数定义
            let isAddMode = false;

            function getTierDisplayText(tierValue) {
                if (!tierValue && tierValue !== 0) return "N/A";
                return 'Tier ' + tierValue;
            }

            // 获取企业类型显示文本
            function getTypeDisplayText(type) {
                switch (type) {
                    case 'Core': return 'Core Enterprise';
                    case 'Bank': return 'Bank';
                    case 'Supplier': return 'Supplier';
                    case 'Distributor': return 'Distributor';
                    default: return type;
                }
            }

            // 加载企业详情
            function loadEnterpriseDetails() {
                // 获取URL参数
                const urlParams = new URLSearchParams(window.location.search);
                const id = urlParams.get('id');

                if (!id) {
                    alert('No enterprise ID provided');
                    window.location.href = "enterprise.jsp";
                    return;
                }

                // 从服务器获取企业数据
                $.ajax({
                    url: 'getEnterprise?id=' + id,
                    type: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        if (data) {
                            // 更新查看模式
                            document.getElementById('detailId').textContent = data.enterpriseID;
                            document.getElementById('detailName').textContent = data.enterpriseName;
                            document.getElementById('detailType').textContent = getTypeDisplayText(data.role);
                            document.getElementById('detailContact').textContent = data.telephone;
                            document.getElementById('detailAddress').textContent = data.address;
                            document.getElementById('detailMemo').textContent = data.memo || '-';
                            // 修改后
const tierValue = data.tier !== null && data.tier !== undefined ? Number(data.tier) : null;
document.getElementById('detailTier').textContent = getTierDisplayText(tierValue);

                            // 设置页面标题
                            document.title = `Enterprise Details: ${data.enterpriseName} - Supply Chain Finance`;
                        } else {
                            alert('Enterprise not found');
                            window.location.href = "enterprise.jsp";
                        }
                    },
                    error: function () {
                        alert('Error loading enterprise details');
                    }
                });
            }

            // 格式化货币
            function formatCurrency(amount) {
                if (!amount) return 'N/A';
                return new Intl.NumberFormat('en-US', {
                    style: 'currency',
                    currency: 'USD'
                }).format(amount);
            }

            // 格式化日期
            function formatDate(dateStr) {
                if (!dateStr) return 'N/A';
                const date = new Date(dateStr);
                if (isNaN(date.getTime())) return dateStr; // 如果转换失败，返回原始字符串

                return date.toLocaleDateString('en-US', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit'
                });
            }

            // 核心功能：获取并显示供应商数据
            function fetchAndDisplaySuppliers(enterpriseId) {
                console.log("正在获取企业ID为", enterpriseId, "的供应商数据");
                const suppliersTab = document.getElementById('suppliers');

                if (!suppliersTab) {
                    console.error("未找到suppliers标签页元素");
                    return;
                }

                // 显示加载指示器
                suppliersTab.innerHTML = '<div class="text-center"><div class="spinner-border text-primary"></div><p>Loading suppliers...</p></div>';

                // 确保标签页可见
                suppliersTab.style.cssText = 'display: block !important; opacity: 1 !important; visibility: visible !important';

                // 使用XMLHttpRequest获取数据（避免潜在的fetch API问题）
                const xhr = new XMLHttpRequest();
                xhr.open('GET', 'getRelatedEntities?type=suppliers&id=' + enterpriseId, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                const responseText = xhr.responseText;
                                console.log("服务器原始响应:", responseText);

                                // 处理可能的BOM标记
                                let textToParse = responseText;
                                if (textToParse.charCodeAt(0) === 0xFEFF) {
                                    textToParse = textToParse.slice(1);
                                }

                                const data = JSON.parse(textToParse);
                                console.log("解析后的数据:", data);

                                if (!data || data.length === 0) {
                                    suppliersTab.innerHTML = '<div class="alert alert-info">No suppliers found for this enterprise.</div>';
                                    return;
                                }

                                // 使用严格的属性访问方式创建表格
                                let html = '<table class="table table-striped"><thead><tr>';
                                html += '<th>ID</th><th>Name</th><th>Tier</th><th>Phone</th><th>Address</th><th>Action</th></tr></thead><tbody>';

                                for (let i = 0; i < data.length; i++) {
                                    const supplier = data[i];
                                    // 关键修复：使用方括号访问并转换为字符串
                                    const id = String(supplier["enterpriseID"] || "");
                                    const name = String(supplier["enterpriseName"] || "");
                                    const tierValue = Number(supplier["tier"]) ;
                                    const phone = String(supplier["telephone"] || "");
                                    const addr = String(supplier["address"] || "");

                                    html += '<tr>';
                                    html += '<td>' + id + '</td>';
                                    html += '<td>' + name + '</td>';
                                    html += '<td>' + getTierDisplayText(tierValue) + '</td>';
                                    html += '<td>' + phone + '</td>';
                                    html += '<td>' + addr + '</td>';
                                    html += '<td><a class="btn btn-sm btn-primary" href="enterpriseDetail.jsp?id=' + id + '">View</a></td>';
                                    html += '</tr>';
                                }

                                html += '</tbody></table>';
                                suppliersTab.innerHTML = html;

                                console.log("供应商数据加载成功，表格已渲染");
                            } catch (e) {
                                console.error("解析或渲染数据时出错:", e);
                                suppliersTab.innerHTML = '<div class="alert alert-danger">Error processing data: ' + e.message + '</div>';
                            }
                        } else {
                            console.error("HTTP请求失败:", xhr.status);
                            suppliersTab.innerHTML = '<div class="alert alert-danger">Failed to load suppliers data. Status: ' + xhr.status + '</div>';
                        }
                    }
                };
                xhr.onerror = function () {
                    suppliersTab.innerHTML = '<div class="alert alert-danger">Network error when loading suppliers data</div>';
                };
                xhr.send();
            }

            // 核心功能：获取并显示经销商数据
            function fetchAndDisplayDistributors(enterpriseId) {
                console.log("正在获取企业ID为", enterpriseId, "的经销商数据");
                const distributorsTab = document.getElementById('distributors');

                if (!distributorsTab) {
                    console.error("未找到distributors标签页元素");
                    return;
                }

                // 显示加载指示器
                distributorsTab.innerHTML = '<div class="text-center"><div class="spinner-border text-primary"></div><p>Loading distributors...</p></div>';

                // 确保标签页可见
                distributorsTab.style.cssText = 'display: block !important; opacity: 1 !important; visibility: visible !important';

                // 使用XMLHttpRequest获取数据（避免潜在的fetch API问题）
                const xhr = new XMLHttpRequest();
                xhr.open('GET', 'getRelatedEntities?type=distributors&id=' + enterpriseId, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                const responseText = xhr.responseText;
                                console.log("服务器原始响应(经销商):", responseText);

                                // 处理可能的BOM标记
                                let textToParse = responseText;
                                if (textToParse.charCodeAt(0) === 0xFEFF) {
                                    textToParse = textToParse.slice(1);
                                }

                                const data = JSON.parse(textToParse);
                                console.log("解析后的经销商数据:", data);

                                if (!data || data.length === 0) {
                                    distributorsTab.innerHTML = '<div class="alert alert-info">No distributors found for this enterprise.</div>';
                                    return;
                                }

                                // 使用严格的属性访问方式创建表格
                                let html = '<table class="table table-striped"><thead><tr>';
                                html += '<th>ID</th><th>Name</th><th>Tier</th><th>Phone</th><th>Address</th><th>Action</th></tr></thead><tbody>';

                                for (let i = 0; i < data.length; i++) {
                                    const distributor = data[i];
                                    // 关键修复：使用方括号访问并转换为字符串
                                    const id = String(distributor["enterpriseID"] || "");
                                    const name = String(distributor["enterpriseName"] || "");
                                    const tier = Number(distributor["tier"]);
                                    const phone = String(distributor["telephone"] || "");
                                    const addr = String(distributor["address"] || "");

                                    html += '<tr>';
                                    html += '<td>' + id + '</td>';
                                    html += '<td>' + name + '</td>';
                                    html += '<td>Tier ' + tier + '</td>';
                                    html += '<td>' + phone + '</td>';
                                    html += '<td>' + addr + '</td>';
                                    html += '<td><a class="btn btn-sm btn-primary" href="enterpriseDetail.jsp?id=' + id + '">View</a></td>';
                                    html += '</tr>';
                                }

                                html += '</tbody></table>';
                                distributorsTab.innerHTML = html;

                                console.log("经销商数据加载成功，表格已渲染");
                            } catch (e) {
                                console.error("解析或渲染经销商数据时出错:", e);
                                distributorsTab.innerHTML = '<div class="alert alert-danger">Error processing data: ' + e.message + '</div>';
                            }
                        } else {
                            console.error("HTTP请求失败:", xhr.status);
                            distributorsTab.innerHTML = '<div class="alert alert-danger">Failed to load distributors data. Status: ' + xhr.status + '</div>';
                        }
                    }
                };
                xhr.onerror = function () {
                    distributorsTab.innerHTML = '<div class="alert alert-danger">Network error when loading distributors data</div>';
                };
                xhr.send();
            }

            // 核心功能：获取并显示合同数据
            function fetchAndDisplayContracts(enterpriseId) {
                console.log("正在获取企业ID为", enterpriseId, "的合同数据");
                const contractsTab = document.getElementById('contracts');

                if (!contractsTab) {
                    console.error("未找到contracts标签页元素");
                    return;
                }

                // 显示加载指示器
                contractsTab.innerHTML = '<div class="text-center"><div class="spinner-border text-primary"></div><p>Loading contracts...</p></div>';

                // 确保标签页可见
                contractsTab.style.cssText = 'display: block !important; opacity: 1 !important; visibility: visible !important';

                // 使用XMLHttpRequest获取数据
                const xhr = new XMLHttpRequest();
                xhr.open('GET', 'getRelatedEntities?type=contracts&id=' + enterpriseId, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                const responseText = xhr.responseText;
                                console.log("服务器原始响应(合同):", responseText);

                                // 处理可能的BOM标记
                                let textToParse = responseText;
                                if (textToParse.charCodeAt(0) === 0xFEFF) {
                                    textToParse = textToParse.slice(1);
                                }

                                const data = JSON.parse(textToParse);
                                console.log("解析后的合同数据:", data);

                                if (!data || data.length === 0) {
                                    contractsTab.innerHTML = '<div class="alert alert-info">No contracts found for this enterprise.</div>';
                                    return;
                                }

                                // 使用严格的属性访问方式创建表格
                                let html = '<table class="table table-striped"><thead><tr>';
                                html += '<th>Contract ID</th><th>Real No.</th><th>Amount</th><th>Date</th><th>Status</th><th>Action</th></tr></thead><tbody>';

                                for (let i = 0; i < data.length; i++) {
                                    const contract = data[i];
                                    // 关键修复：使用方括号访问并转换为字符串
                                    const id = String(contract["contractID"] || "");
                                    const number = String(contract["contractNumber"] || "N/A");

                                    // 使用安全的格式化方法处理金额和日期
                                    let formattedAmount = 'N/A';
                                    try {
                                        if (contract["contractAmount"]) {
                                            formattedAmount = formatCurrency(contract["contractAmount"]);
                                        }
                                    } catch (e) {
                                        console.error("格式化金额时出错:", e);
                                    }

                                    let formattedDate = 'N/A';
                                    try {
                                        if (contract["contractDate"]) {
                                            formattedDate = formatDate(contract["contractDate"]);
                                        }
                                    } catch (e) {
                                        console.error("格式化日期时出错:", e);
                                    }

                                    const status = String(contract["status"] || "Active");

                                    html += '<tr>';
                                    html += '<td>' + id + '</td>';
                                    html += '<td>' + number + '</td>';
                                    html += '<td>' + formattedAmount + '</td>';
                                    html += '<td>' + formattedDate + '</td>';
                                    html += '<td>' + status + '</td>';
                                    html += '<td><a class="btn btn-sm btn-info" href="contractDetail.jsp?id=' + id + '">View</a></td>';
                                    html += '</tr>';
                                }

                                html += '</tbody></table>';
                                contractsTab.innerHTML = html;

                                console.log("合同数据加载成功，表格已渲染");
                            } catch (e) {
                                console.error("解析或渲染合同数据时出错:", e);
                                contractsTab.innerHTML = '<div class="alert alert-danger">Error processing data: ' + e.message + '</div>';
                            }
                        } else {
                            console.error("HTTP请求失败:", xhr.status);
                            contractsTab.innerHTML = '<div class="alert alert-danger">Failed to load contracts data. Status: ' + xhr.status + '</div>';
                        }
                    }
                };
                xhr.onerror = function () {
                    contractsTab.innerHTML = '<div class="alert alert-danger">Network error when loading contracts data</div>';
                };
                xhr.send();
            }

            // 文档就绪函数 - 初始化页面
            $(document).ready(function () {
                console.log("页面加载 - 初始化");
                // 确保初始状态下只有suppliers标签页是活动的
                $('.tab-pane').not('#suppliers').removeClass('active show');

                // 1. 加载企业详情
                loadEnterpriseDetails();

                // 2. 初始化下拉菜单
                $('.dropdown-toggle').dropdown();

                // 3. 添加悬停效果处理
                $('.dropdown').hover(
                    function () {
                        $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100);
                    },
                    function () {
                        $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100);
                    }
                );

                // 4. 标签切换处理 - 解决内容叠加问题
                $('#myTab a').on('click', function (e) {
                    e.preventDefault(); // 阻止默认行为

                    // 获取点击的标签和目标内容区ID
                    const $this = $(this);
                    const tabHref = $this.attr('href');
                    const tabId = tabHref.substring(1); // 去掉开头的#

                    console.log("点击标签页: " + tabId);

                    // 移除所有标签的激活状态
                    $('#myTab a').removeClass('active');
                    $this.addClass('active');

                    // 隐藏所有标签内容
                    $('.tab-pane').removeClass('active show').hide();

                    // 仅显示当前标签内容
                    $(tabHref).addClass('active show').show();

                    // 获取URL中的企业ID
                    const urlParams = new URLSearchParams(window.location.search);
                    const enterpriseId = urlParams.get('id');

                    if (!enterpriseId) return;

                    // 根据不同的标签页加载相应数据
                    if (tabId === 'suppliers') {
                        fetchAndDisplaySuppliers(enterpriseId);
                    } else if (tabId === 'distributors') {
                        fetchAndDisplayDistributors(enterpriseId);
                    } else if (tabId === 'contracts') {
                        fetchAndDisplayContracts(enterpriseId);
                    }
                });

                // 5. 获取URL中的企业ID
                const urlParams = new URLSearchParams(window.location.search);
                const enterpriseId = urlParams.get('id');

                // 6. 强制显示suppliers标签页内容
                if (enterpriseId) {
                    // 添加CSS样式，但改为只显示激活的标签
                    const style = document.createElement('style');
                    style.type = 'text/css';
                    style.innerHTML = `
                    /* 确保只有激活的标签页可见 */
                    .tab-pane.active {
                        display: block !important; 
                        opacity: 1 !important;
                        visibility: visible !important;
                    }
                    
                    /* 确保非激活标签页隐藏 */
                    .tab-pane:not(.active) {
                        display: none !important;
                        opacity: 0 !important;
                    }
                    
                    /* 确保suppliers标签按钮初始状态看起来是激活的 */
                    #suppliers-tab {
                        color: #007bff !important;
                        background-color: #fff !important;
                        border-color: #dee2e6 #dee2e6 #fff !important;
                    }
                `;
                    document.head.appendChild(style);

                    // 延迟加载供应商数据，确保DOM已准备好
                    setTimeout(function () {
                        console.log("加载供应商数据...");
                        fetchAndDisplaySuppliers(enterpriseId);
                    }, 500);
                }

                // 7. 移除页面上所有不必要的临时解决方案容器
                setTimeout(function () {
                    const elementsToRemove = [
                        document.querySelector('.card.mt-4.border-danger'), // Emergency Fix
                        document.getElementById('ultimate_fix'),            // Ultimate Fix
                        document.getElementById('direct_suppliers_container') // Direct View
                    ];

                    elementsToRemove.forEach(el => {
                        if (el) el.parentNode.removeChild(el);
                    });
                }, 3000); // 给足够的时间让页面完全加载
            });
        </script>