/enterpriseDetail.jsp -->
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
                <a href="#" class="dropdown-toggle" id="enterpriseDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Enterprise
                </a>
                <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                    <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                    <a class="dropdown-item" href="enterpriseDetail.jsp?mode=add">Add New Enterprise</a>
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
                        <div>
                            <!-- Add Edit and Save buttons -->
                            <button class="btn btn-primary" id="editBtn" onclick="toggleEditMode()">Edit</button>
                            <button class="btn btn-success edit-mode" id="saveBtn" onclick="saveEnterprise()">Save</button>
                            <button class="btn btn-secondary" onclick="goBack()">Back</button>
                        </div>
                    </div>

                    <!-- Display-only view -->
                    <div id="viewMode">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><strong>Enterprise ID:</strong></label>
                                    <p id="detailId">001</p>
                                </div>
                                <div class="form-group">
                                    <label><strong>Enterprise Name:</strong></label>
                                    <p id="detailName">XYZ Corporation</p>
                                </div>
                                <div class="form-group">
                                    <label><strong>Type:</strong></label>
                                    <p id="detailType">Core Enterprise</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><strong>Contact Number:</strong></label>
                                    <p id="detailContact">+123-456-7890</p>
                                </div>
                                <div class="form-group">
                                    <label><strong>Address:</strong></label>
                                    <p id="detailAddress">123 Business Park, Finance District, 10001</p>
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
                            <a class="nav-link active" id="suppliers-tab" data-toggle="tab" href="#suppliers" role="tab">Suppliers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="distributors-tab" data-toggle="tab" href="#distributors" role="tab">Distributors</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="contracts-tab" data-toggle="tab" href="#contracts" role="tab">Contracts</a>
                        </li>
                    </ul>
                    <div class="tab-content pt-3" id="myTabContent">
                        <div class="tab-pane fade show active" id="suppliers" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Acme Suppliers</h5>
                                    <p class="card-text">Tier: 1</p>
                                    <a href="enterpriseDetail.jsp?id=S001" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Component Manufacturing Ltd</h5>
                                    <p class="card-text">Tier: 2</p>
                                    <a href="enterpriseDetail.jsp?id=S002" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="distributors" role="tabpanel">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Global Distribution Inc.</h5>
                                    <p class="card-text">Tier: 1</p>
                                    <a href="enterpriseDetail.jsp?id=D001" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Regional Sales Co.</h5>
                                    <p class="card-text">Tier: 2</p>
                                    <a href="enterpriseDetail.jsp?id=D002" class="btn btn-sm btn-info">View Details</a>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="contracts" role="tabpanel">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Contract ID</th>
                                            <th>Real No.</th>
                                            <th>Amount</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>C001</td>
                                            <td>XYZ-2025-001</td>
                                            <td>$250,000</td>
                                            <td>01/15/2025</td>
                                            <td><a href="contractDetail.jsp?id=C001" class="btn btn-sm btn-info">View</a></td>
                                        </tr>
                                        <tr>
                                            <td>C002</td>
                                            <td>XYZ-2025-002</td>
                                            <td>$175,000</td>
                                            <td>01/28/2025</td>
                                            <td><a href="contractDetail.jsp?id=C002" class="btn btn-sm btn-info">View</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
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
        // Variable to track if we're in add mode
        let isAddMode = false;
        
        // Function to go back to search page
        function goBack() {
            window.location.href = "enterprise.jsp";
        }
        
        // Function to toggle between view mode and edit mode
        function toggleEditMode() {
            const viewMode = document.getElementById('viewMode');
            const editMode = document.getElementById('editMode');
            const editBtn = document.getElementById('editBtn');
            const saveBtn = document.getElementById('saveBtn');
            
            if (editMode.style.display === 'block') {
                // Switch to view mode
                viewMode.style.display = 'block';
                editMode.style.display = 'none';
                editBtn.style.display = 'inline-block';
                saveBtn.style.display = 'none';
            } else {
                // Switch to edit mode
                viewMode.style.display = 'none';
                editMode.style.display = 'block';
                editBtn.style.display = 'none';
                saveBtn.style.display = 'inline-block';
            }
        }
        
        // Function to save enterprise data
        function saveEnterprise() {
            const enterpriseData = {
                id: document.getElementById('editId').value,
                name: document.getElementById('editName').value,
                type: document.getElementById('editType').value,
                contact: document.getElementById('editContact').value,
                address: document.getElementById('editAddress').value,
                memo: document.getElementById('editMemo').value
            };
            
            // Perform validation
            if (!enterpriseData.name.trim()) {
                alert('Enterprise name cannot be empty');
                return;
            }
            
            if (!enterpriseData.contact.trim()) {
                alert('Contact number cannot be empty');
                return;
            }
            
            if (!enterpriseData.address.trim()) {
                alert('Address cannot be empty');
                return;
            }
            
            // Send data to server
            const endpoint = isAddMode ? 'createEnterprise' : 'updateEnterprise';
            
            $.ajax({
                url: endpoint,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(enterpriseData),
                success: function(response) {
                    console.log("Response from server:", response); // Debug

                    if (response.success) {
                        alert(isAddMode ? 'Enterprise created successfully' : 'Enterprise updated successfully');
                        
                        if (isAddMode) {
                            // For new enterprise, redirect to the detail page with the new ID
                            var newUrl = "enterpriseDetail.jsp?id=" + response.enterpriseID;
                            console.log("Redirecting to: " + newUrl); // Debug
                            window.location.href = newUrl;
                        } else {
                            // For existing enterprise, update the view with new data
                            document.getElementById('detailName').textContent = enterpriseData.name;
                            document.getElementById('detailType').textContent = getTypeDisplayText(enterpriseData.type);
                            document.getElementById('detailContact').textContent = enterpriseData.contact;
                            document.getElementById('detailAddress').textContent = enterpriseData.address;
                            document.getElementById('detailMemo').textContent = enterpriseData.memo || '-';
                            
                            // Switch back to view mode
                            toggleEditMode();
                        }
                    } else {
                        alert('Error: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX Error:", xhr.responseText); // Debug
                    alert('Error connecting to server: ' + error);
                }
            });
        }
        
        // Helper function to get display text for enterprise type
        function getTypeDisplayText(type) {
            switch(type) {
                case 'Core': return 'Core Enterprise';
                case 'Bank': return 'Bank';
                case 'Supplier': return 'Supplier';
                case 'Distributor': return 'Distributor';
                default: return type;
            }
        }
        
        // Function to generate a new enterprise ID based on role
        function generateEnterpriseID(role) {
            const prefix = role.charAt(0); // C, B, S, or D
            const randomNum = Math.floor(Math.random() * 900) + 100; // Random 3-digit number
            return prefix + randomNum;
        }

        // Function to load enterprise details based on the ID from query parameter
        function loadEnterpriseDetails() {
            // Get parameters from URL
            const urlParams = new URLSearchParams(window.location.search);
            const id = urlParams.get('id');
            const mode = urlParams.get('mode');
            
            // Check if we're in add mode
            if (mode === 'add') {
                isAddMode = true;
                
                // Set page title
                document.getElementById('pageTitle').textContent = 'Add New Enterprise';
                document.title = 'Add New Enterprise - Supply Chain Finance';
                
                // Hide view mode, show edit mode
                document.getElementById('viewMode').style.display = 'none';
                document.getElementById('editMode').style.display = 'block';
                
                // Hide edit button, show save button
                document.getElementById('editBtn').style.display = 'none';
                document.getElementById('saveBtn').style.display = 'inline-block';
                
                // Hide related entities section
                document.getElementById('relatedEntitiesSection').style.display = 'none';
                
                // Initialize form with empty values
                document.getElementById('editName').value = '';
                document.getElementById('editType').value = 'Core';
                document.getElementById('editContact').value = '';
                document.getElementById('editAddress').value = '';
                document.getElementById('editMemo').value = '';
                
                // Generate an enterprise ID based on selected role
                document.getElementById('editType').addEventListener('change', function() {
                    document.getElementById('editId').value = generateEnterpriseID(this.value);
                });
                
                // Generate an initial ID
                document.getElementById('editId').value = generateEnterpriseID('Core');
                
                return;
            }
            
            // If not in add mode, proceed with loading existing enterprise
            if (!id) {
                alert('No enterprise ID provided');
                goBack();
                return;
            }
            
            // Fetch enterprise data from server
            $.ajax({
                url: 'getEnterprise?id=' + id,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    if (data) {
                        // Update view mode
                        document.getElementById('detailId').textContent = data.enterpriseID;
                        document.getElementById('detailName').textContent = data.enterpriseName;
                        document.getElementById('detailType').textContent = getTypeDisplayText(data.role);
                        document.getElementById('detailContact').textContent = data.telephone;
                        document.getElementById('detailAddress').textContent = data.address;
                        document.getElementById('detailMemo').textContent = data.memo || '-';
                        
                        // Update edit mode
                        document.getElementById('editId').value = data.enterpriseID;
                        document.getElementById('editName').value = data.enterpriseName;
                        document.getElementById('editType').value = data.role;
                        document.getElementById('editContact').value = data.telephone;
                        document.getElementById('editAddress').value = data.address;
                        document.getElementById('editMemo').value = data.memo || '';
                        
                        // Set page title
                        document.title = `Enterprise Details: ${data.enterpriseName} - Supply Chain Finance`;
                    } else {
                        alert('Enterprise not found');
                        goBack();
                    }
                },
                error: function() {
                    alert('Error loading enterprise details');
                }
            });
        }

        // Call the function when the page loads
        $(document).ready(function() {
            loadEnterpriseDetails();
        });
        
        $(document).ready(function() {
        // Make sure dropdown works properly
        $('.dropdown-toggle').dropdown();
    });

   
    // Initialization when document is ready
    $(document).ready(function() {
        // Load enterprise details
        loadEnterpriseDetails();
        
        // Initialize dropdown menu
        $('.dropdown-toggle').dropdown();
        
        // Add event listener for hover effect
        $('.dropdown').hover(
            function() {
                $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100);
            },
            function() {
                $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100);
            }
        );
    });

    </script>
</body>

</html>