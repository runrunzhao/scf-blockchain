/register.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Supply Chain Finance</title>
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

        .header {
            background-color: #007bff;
            padding: 15px;
            color: white;
            text-align: center;
            font-size: 24px;
            border-radius: 10px;
            margin-bottom: 30px;
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

        .register-form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .form-title {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #aaa;
        }

        .password-strength {
            font-size: 12px;
            margin-top: 5px;
        }

        .weak {
            color: #dc3545;
        }

        .medium {
            color: #ffc107;
        }

        .strong {
            color: #28a745;
        }

        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
        }

        .success-message {
            color: #28a745;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Dropdown menu styling */
        .dropdown-menu {
            background-color: #f8f9fa;
            border-radius: 5px;
            margin-top: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
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

        /* Force dropdown menu display when .show class is present */
        .dropdown-menu.show {
            display: block !important;
        }

        /* Ensure dropdown menus stay on top of other content */
        .dropdown-menu {
            z-index: 1050 !important;
        }
    </style>
</head>

<body>
    <!-- Header and Navigation Menu -->
    <div class="header">
        <h1>Supply Chain Finance Platform</h1>
        <div class="menu">
            <a href="index.jsp">Home</a>
            
            <!-- User dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    User
                </a>
                <div class="dropdown-menu" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="login.jsp">Login</a>
                    <a class="dropdown-item active" href="register.jsp">Register</a>
                </div>
            </div>
            
            <!-- Enterprise dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="enterpriseDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Enterprise
                </a>
                <div class="dropdown-menu" aria-labelledby="enterpriseDropdown">
                    <a class="dropdown-item" href="enterprise.jsp">Search Enterprises</a>
                    <a class="dropdown-item" href="singleEnterprise.jsp?mode=add">Add New Enterprise</a>
                </div>
            </div>
            
            <!-- Contract dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="contractDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Contract
                </a>
                <div class="dropdown-menu" aria-labelledby="contractDropdown">
                    <a class="dropdown-item" href="contract.jsp">Search Contracts</a>
                    <a class="dropdown-item" href="contractDetail.jsp?mode=add">Add New Contract</a>
                </div>
            </div>

            <!-- Invoice dropdown menu -->
            <div class="dropdown d-inline-block">
                <a class="dropdown-toggle" href="#" role="button" id="invoiceDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Invoice
                </a>
                <div class="dropdown-menu" aria-labelledby="invoiceDropdown">
                    <a class="dropdown-item" href="invoice.jsp">Search Invoices</a>
                    <a class="dropdown-item" href="invoiceDetail.jsp?mode=add">Add New Invoice</a>
                </div>
            </div>
            
            <a href="CTTinfo.jsp">CTT</a>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="register-form">
                    <h3 class="form-title">Create a New Account</h3>
                    
                    <!-- Display any error or success messages -->
                    <% if(request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                    <% } %>
                    <% if(request.getAttribute("successMessage") != null) { %>
                    <div class="alert alert-success">
                        <%= request.getAttribute("successMessage") %>
                    </div>
                    <% } %>
                    
                    <form id="registerForm" method="post" action="registerUser">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="firstName"><i class="fas fa-user mr-2"></i>First Name:</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter your first name" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="lastName"><i class="fas fa-user mr-2"></i>Last Name:</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter your last name" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope mr-2"></i>Email Address:</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email address" required>
                        </div>
                        <div class="form-group">
                            <label for="username"><i class="fas fa-user-tag mr-2"></i>Username:</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Choose a username" required>
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="fas fa-lock mr-2"></i>Password:</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                            <div id="passwordStrength" class="password-strength"></div>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword"><i class="fas fa-lock mr-2"></i>Confirm Password:</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                        </div>
                        <div class="form-group">
                            <label for="enterpriseId"><i class="fas fa-building mr-2"></i>Enterprise ID:</label>
                            <input type="text" class="form-control" id="enterpriseId" name="enterpriseId" placeholder="Enter your enterprise ID (optional)" maxlength="8">
                            <small class="form-text text-muted">Optional: Link your account to an enterprise</small>
                        </div>
                        <div class="form-group form-check">
                            <input type="checkbox" class="form-check-input" id="termsCheck" name="termsCheck" required>
                            <label class="form-check-label" for="termsCheck">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                        <div id="clientErrorMessage" class="error-message text-center mt-3" style="display: none;"></div>
                    </form>
                    <div class="form-footer">
                        <p>Already have an account? <a href="login.jsp">Login here</a></p>
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
        $(document).ready(function() {
            // Initialize dropdown menu
            $('.dropdown-toggle').dropdown();
            
            // Force re-initialization after a delay to ensure everything is loaded
            setTimeout(function() {
                $('.dropdown-toggle').dropdown();
            }, 200);
            
            // Add event listener to make dropdown work on hover too
            $('.dropdown').hover(
                function() {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeIn(100);
                },
                function() {
                    $(this).find('.dropdown-menu').stop(true, true).delay(100).fadeOut(100);
                }
            );
            
            // Password strength checker
            $('#password').on('input', function() {
                var password = $(this).val();
                var strengthIndicator = $('#passwordStrength');
                
                if (password.length === 0) {
                    strengthIndicator.text('').removeClass('weak medium strong');
                    return;
                }
            });
                
                            
            // Password confirmation check
            $('#confirmPassword').on('input', function() {
                if ($(this).val() !== $('#password').val()) {
                    $(this).addClass('is-invalid');
                } else {
                    $(this).removeClass('is-invalid');
                }
            });
            
            // Form validation
            $('#registerForm').submit(function(e) {
                var password = $('#password').val();
                var confirmPassword = $('#confirmPassword').val();
                var errorMsg = '';
                
                // Clear previous error messages
                $('#clientErrorMessage').hide().text('');
                
                // Validate password match
                if (password !== confirmPassword) {
                    errorMsg = 'Passwords do not match.';
                    $('#clientErrorMessage').text(errorMsg).show();
                    e.preventDefault();
                    return false;
                }
                
                                
                // If all validations pass, form will submit normally
                return true;
            });
        });
    </script>
</body>
</html>