<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Header and Navigation Menu -->
<div class="header">
    <div class="d-flex justify-content-between align-items-center">
        <h1 class="mb-0">Supply Chain Finance Platform</h1>
        
        <!-- User Status - 显示在右上角 -->
        <div class="user-status">
            <% if(session != null && session.getAttribute("isLoggedIn") != null && (Boolean)session.getAttribute("isLoggedIn")) { 
                String username = (String)session.getAttribute("username");
            %>
                <div class="dropdown">
                    <a class="dropdown-toggle text-white" href="#" role="button" id="userStatusDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-user-circle mr-1"></i> <%= username %>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userStatusDropdown">
                        <a class="dropdown-item" href="profile.jsp"><i class="fas fa-id-card mr-2"></i>Profile</a>
                        <a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog mr-2"></i>Settings</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt mr-2"></i>Logout</a>
                    </div>
                </div>
            <% } else { %>
                <div class="login-register">
                    <a href="login.jsp" class="text-white mr-3"><i class="fas fa-sign-in-alt mr-1"></i> Login</a>
                    <a href="register.jsp" class="text-white"><i class="fas fa-user-plus mr-1"></i> Register</a>
                </div>
            <% } %>
        </div>
    </div>
    
    <!-- Navigation Menu -->
    <div class="menu">
        <a href="index.jsp">Home</a>
        
        <!-- User dropdown menu -->
        <div class="dropdown d-inline-block">
            <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                User
            </a>
            <div class="dropdown-menu" aria-labelledby="userDropdown">
                <% if(session != null && session.getAttribute("isLoggedIn") != null && (Boolean)session.getAttribute("isLoggedIn")) { %>
                    <a class="dropdown-item" href="profile.jsp">My Profile</a>
                    <a class="dropdown-item" href="settings.jsp">Account Settings</a>
                <% } else { %>
                    <a class="dropdown-item" href="login.jsp">Login</a>
                    <a class="dropdown-item" href="register.jsp">Register</a>
                <% } %>
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