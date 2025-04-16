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
            <!-- Enterprise Detail Section ONLY -->
            <div class="row">
                <div class="col-12">
                    <div class="detail-panel">
                        <!-- Page Title -->
                        <div class="mb-4">
                            <h3 id="pageTitle">Enterprise Details</h3>
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

                        <!-- Edit mode view -->
                        <div id="editMode" class="edit-mode">
                            <form id="enterpriseForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="editId">Enterprise ID:</label>
                                            <input type="text" class="form-control" id="editId" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="editName">Enterprise Name:</label>
                                            <input type="text" class="form-control" id="editName">
                                        </div>
                                        <div class="form-group">
                                            <label for="editType">Type:</label>
                                            <select class="form-control" id="editType">
                                                <option value="Core">Core Enterprise</option>
                                                <option value="Bank">Bank</option>
                                                <option value="Supplier">Supplier</option>
                                                <option value="Distributor">Distributor</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="editTier">Tier:</label>
                                            <select class="form-control" id="editTier">
                                                <option value="1">Tier 1</option>
                                                <option value="2">Tier 2</option>
                                                <option value="3">Tier 3</option>
                                                <option value="4">Tier 4</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="editContact">Contact Number:</label>
                                            <input type="text" class="form-control" id="editContact">
                                        </div>
                                        <div class="form-group">
                                            <label for="editAddress">Address:</label>
                                            <textarea class="form-control" id="editAddress" rows="2"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="editMemo">Memo:</label>
                                            <textarea class="form-control" id="editMemo" rows="2"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Action Buttons - Moved to bottom -->
                        <div class="button-group">
                            <button class="btn btn-primary" id="editBtn" onclick="toggleEditMode()">Edit</button>
                            <button class="btn btn-success edit-mode" id="saveBtn"
                                onclick="saveEnterprise()">Save</button>
                            <button class="btn btn-secondary" onclick="goBack()">Back</button>
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

            // 返回到搜索页面
            function goBack() {
                window.location.href = "enterprise.jsp";
            }

            // 切换编辑模式
            function toggleEditMode() {
                const viewMode = document.getElementById('viewMode');
                const editMode = document.getElementById('editMode');
                const editBtn = document.getElementById('editBtn');
                const saveBtn = document.getElementById('saveBtn');

                if (editMode.style.display === 'block') {
                    // 切换到查看模式
                    viewMode.style.display = 'block';
                    editMode.style.display = 'none';
                    editBtn.style.display = 'inline-block';
                    saveBtn.style.display = 'none';
                } else {
                    // 切换到编辑模式
                    viewMode.style.display = 'none';
                    editMode.style.display = 'block';
                    editBtn.style.display = 'none';
                    saveBtn.style.display = 'inline-block';
                }
            }

            // 保存企业信息
            function saveEnterprise() {
                // 获取表单数据
                const enterpriseData = {
                    // 如果是添加模式，不传ID；如果是编辑模式，传原ID
                    id: isAddMode ? "" : document.getElementById('editId').value,
                    name: document.getElementById('editName').value,
                    type: document.getElementById('editType').value,
                    contact: document.getElementById('editContact').value,
                    address: document.getElementById('editAddress').value,
                    memo: document.getElementById('editMemo').value,
                    tier: document.getElementById('editTier').value
                };

                // 表单验证
                if (!enterpriseData.name.trim()) {
                    alert("Enterprise name is required");
                    return;
                }

                // AJAX保存企业数据
                $.ajax({
                    url: 'createEnterprise',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(enterpriseData),
                    success: function (response) {
                        if (response.success) {
                            // 如果是添加模式并成功创建，更新ID字段显示
                            if (isAddMode && response.enterpriseID) {
                                document.getElementById('editId').value = response.enterpriseID;

                                // 更新查看模式的显示
                                document.getElementById('detailId').textContent = response.enterpriseID;
                                document.getElementById('detailName').textContent = enterpriseData.name;
                                document.getElementById('detailType').textContent = getTypeDisplayText(enterpriseData.type);
                                document.getElementById('detailTier').textContent = getTierDisplayText(enterpriseData.tier);
                                document.getElementById('detailContact').textContent = enterpriseData.contact || '-';
                                document.getElementById('detailAddress').textContent = enterpriseData.address || '-';
                                document.getElementById('detailMemo').textContent = enterpriseData.memo || '-';

                                // 更新页面模式 - 从添加模式变为查看/编辑模式
                                isAddMode = false;
                                document.getElementById('pageTitle').textContent = 'Enterprise Details';
                                document.title = `Enterprise Details: ${enterpriseData.name} - Supply Chain Finance`;

                                // 修改URL以包含企业ID (不刷新页面)
                                history.pushState(null, '', `singleEnterprise.jsp?id=${response.enterpriseID}`);
                            }

                            alert('Save successful!');

                            // 切换回查看模式
                            toggleEditMode();

                            // 不再跳转到不存在的页面
                            // window.location.href = 'enterpriseList.jsp';
                        } else {
                            alert('Error: ' + (response.message || '未知错误'));
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("保存企业信息错误:", xhr.responseText);
                        alert('保存失败: ' + error);
                    }
                });
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

            // Helper function to format tier display
            function getTierDisplayText(tierValue) {
                // 如果值已经包含 "Tier" 前缀，直接返回
                if (String(tierValue).toLowerCase().includes('tier')) {
                    return tierValue;
                }

                // 否则，添加 "Tier" 前缀
                return 'Tier ' + tierValue;
            }



            // 加载企业详情
            function loadEnterpriseDetails() {
                // 获取URL参数
                const urlParams = new URLSearchParams(window.location.search);
                const id = urlParams.get('id');
                const mode = urlParams.get('mode');

                // 检查是否处于添加模式
                if (mode === 'add') {
                    isAddMode = true;

                    // 设置页面标题
                    document.getElementById('pageTitle').textContent = 'Add New Enterprise';
                    document.title = 'Add New Enterprise - Supply Chain Finance';

                    // 隐藏查看模式，显示编辑模式
                    document.getElementById('viewMode').style.display = 'none';
                    document.getElementById('editMode').style.display = 'block';

                    // 隐藏编辑按钮，显示保存按钮
                    document.getElementById('editBtn').style.display = 'none';
                    document.getElementById('saveBtn').style.display = 'inline-block';

                    // 初始化表单为空值 - 使用正确的默认值格式
                    document.getElementById('editName').value = '';
                    document.getElementById('editType').value = 'Supplier';
                    document.getElementById('editTier').value = '1';  // 数字字符串 (不是 'Tier1')
                    document.getElementById('editContact').value = '';
                    document.getElementById('editAddress').value = '';
                    document.getElementById('editMemo').value = '';
                    document.getElementById('editId').value = '(Auto-generated)';

                    return;
                }
                // 修改这个条件判断
                if (!id || id.trim() === '') {
                    console.error("ID参数缺失或为空字符串:", id);
                    alert('No enterprise ID provided');
                    goBack();
                    return;
                }

                // 从服务器获取企业数据
                $.ajax({
                    url: 'getEnterprise?id=' + id,
                    type: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        if (data) {
                            console.log("Received data from server:", data);

                            // 更新查看模式 - 使用正确的格式化函数
                            document.getElementById('detailId').textContent = data.enterpriseID;
                            document.getElementById('detailName').textContent = data.enterpriseName;
                            document.getElementById('detailType').textContent = getTypeDisplayText(data.role);
                            document.getElementById('detailTier').textContent = getTierDisplayText(data.tier || '1');
                            document.getElementById('detailContact').textContent = data.telephone;
                            document.getElementById('detailAddress').textContent = data.address;
                            document.getElementById('detailMemo').textContent = data.memo || '-';

                            // 更新编辑模式 - 使用正确的值格式
                            document.getElementById('editId').value = data.enterpriseID;
                            document.getElementById('editName').value = data.enterpriseName;
                            document.getElementById('editType').value = data.role;
                            // 修复: 直接显示 tier 数字，而不是用 getTierDisplayText 函数处理
                            if (typeof data.tier === 'number') {
                                document.getElementById('detailTier').textContent = 'Tier ' + data.tier;
                            } else {
                                // 兼容字符串或其他情况
                                document.getElementById('detailTier').textContent = getTierDisplayText(data.tier || '1');
                            }
                            document.getElementById('editContact').value = data.telephone;
                            document.getElementById('editAddress').value = data.address;
                            document.getElementById('editMemo').value = data.memo || '';

                            // 设置页面标题
                            document.title = `Enterprise Details: ${data.enterpriseName} - Supply Chain Finance`;
                        } else {
                            alert('Enterprise not found');
                            goBack();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error loading enterprise:", error);
                        console.error("Response:", xhr.responseText);
                        alert('Error loading enterprise details');
                    }
                });
            }

            // 文档就绪函数 - 初始化页面
            $(document).ready(function () {
                console.log("页面加载 - 初始化");

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
            });
        </script>
    </body>

    </html>