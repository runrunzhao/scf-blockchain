/login.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Supply Chain Finance</title>
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

        .login-form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
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

        .btn-login {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
            font-weight: 600;
            padding: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background-color: #0069d9;
            border-color: #0062cc;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
                    <a class="dropdown-item active" href="login.jsp">Login</a>
                    <a class="dropdown-item" href="register.jsp">Register</a>
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
                <div class="login-form">
                    <h3 class="form-title"><i class="fas fa-sign-in-alt mr-2"></i>Login to Your Account</h3>
                    
                    <!-- Display error messages if any -->
                    <% if(request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                    <% } %>
                    
                    <!-- Standard HTML form - no AJAX -->
                    <form method="post" action="loginUser">
                        <div class="form-group">
                            <label for="username"><i class="fas fa-user mr-2"></i>Username:</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="fas fa-lock mr-2"></i>Password:</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                        <div class="form-group form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block btn-login">Login</button>
                    </form>
                    
                    <div class="form-footer">
                        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
                        <p><a href="forgotPassword.jsp">Forgot password?</a></p>
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
            
            // Debug logging for form submission
            $('form').submit(function() {
                console.log('Form is being submitted to: ' + $(this).attr('action'));
                return true; // Allow the form to actually submit
            });
        });
    </script>
</body>
</html>