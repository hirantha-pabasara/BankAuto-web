<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>User Dashboard - BankAuto</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="../css/user.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--    <style>--%>
<%--        .transfer-status-pending { color: #ffc107; }--%>
<%--        .transfer-status-completed { color: #198754; }--%>
<%--        .transfer-status-failed { color: #dc3545; }--%>
<%--        .transfer-status-scheduled { color: #0dcaf0; }--%>

<%--        /* Modern Sidebar Design */--%>
<%--        .sidebar {--%>
<%--            width: 280px;--%>
<%--            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);--%>
<%--            box-shadow: 2px 0 10px rgba(0,0,0,0.1);--%>
<%--            transition: all 0.3s ease;--%>
<%--            position: fixed;--%>
<%--            height: 100vh;--%>
<%--            overflow-y: auto;--%>
<%--            z-index: 1000;--%>
<%--        }--%>

<%--        .sidebar-brand {--%>
<%--            padding: 2rem 1.5rem;--%>
<%--            background: rgba(255,255,255,0.1);--%>
<%--            border-bottom: 1px solid rgba(255,255,255,0.1);--%>
<%--            transition: all 0.3s ease;--%>
<%--        }--%>

<%--        .sidebar-brand:hover {--%>
<%--            background: rgba(255,255,255,0.15);--%>
<%--            text-decoration: none;--%>
<%--        }--%>

<%--        .sidebar-brand-icon {--%>
<%--            width: 45px;--%>
<%--            height: 45px;--%>
<%--            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);--%>
<%--            border-radius: 12px;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            margin-right: 1rem;--%>
<%--            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);--%>
<%--        }--%>

<%--        .sidebar-brand-icon i {--%>
<%--            color: white;--%>
<%--            font-size: 1.3rem;--%>
<%--        }--%>

<%--        .sidebar-brand-text {--%>
<%--            color: white;--%>
<%--            font-size: 1.4rem;--%>
<%--            font-weight: 700;--%>
<%--            letter-spacing: 1px;--%>
<%--        }--%>

<%--        .sidebar-divider {--%>
<%--            border-color: rgba(255,255,255,0.15);--%>
<%--            margin: 0.5rem 0;--%>
<%--        }--%>

<%--        .nav-item {--%>
<%--            margin: 0.2rem 1rem;--%>
<%--        }--%>

<%--        .nav-item .nav-link {--%>
<%--            color: rgba(255,255,255,0.8);--%>
<%--            padding: 1rem 1.5rem;--%>
<%--            border-radius: 12px;--%>
<%--            font-weight: 500;--%>
<%--            transition: all 0.3s ease;--%>
<%--            position: relative;--%>
<%--            overflow: hidden;--%>
<%--        }--%>

<%--        .nav-item .nav-link::before {--%>
<%--            content: '';--%>
<%--            position: absolute;--%>
<%--            top: 0;--%>
<%--            left: -100%;--%>
<%--            width: 100%;--%>
<%--            height: 100%;--%>
<%--            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);--%>
<%--            transition: left 0.5s ease;--%>
<%--        }--%>

<%--        .nav-item .nav-link:hover::before {--%>
<%--            left: 100%;--%>
<%--        }--%>

<%--        .nav-item .nav-link:hover {--%>
<%--            color: white;--%>
<%--            background: rgba(255,255,255,0.1);--%>
<%--            transform: translateX(5px);--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.1);--%>
<%--        }--%>

<%--        .nav-item.active .nav-link {--%>
<%--            color: white;--%>
<%--            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);--%>
<%--            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);--%>
<%--        }--%>

<%--        .nav-item .nav-link i {--%>
<%--            width: 20px;--%>
<%--            margin-right: 0.8rem;--%>
<%--            font-size: 1.1rem;--%>
<%--        }--%>

<%--        .nav-item .nav-link span {--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        /* Content wrapper adjustment */--%>
<%--        #content-wrapper {--%>
<%--            margin-left: 280px;--%>
<%--            transition: margin-left 0.3s ease;--%>
<%--        }--%>

<%--        /* Sidebar collapsed state */--%>
<%--        .sidebar-toggled .sidebar {--%>
<%--            width: 80px;--%>
<%--        }--%>

<%--        .sidebar-toggled #content-wrapper {--%>
<%--            margin-left: 80px;--%>
<%--        }--%>

<%--        .sidebar-toggled .sidebar-brand-text,--%>
<%--        .sidebar-toggled .nav-item .nav-link span {--%>
<%--            display: none;--%>
<%--        }--%>

<%--        .sidebar-toggled .sidebar-brand {--%>
<%--            padding: 1.5rem 1rem;--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        .sidebar-toggled .sidebar-brand-icon {--%>
<%--            margin-right: 0;--%>
<%--        }--%>

<%--        .sidebar-toggled .nav-item {--%>
<%--            margin: 0.2rem 0.5rem;--%>
<%--        }--%>

<%--        .sidebar-toggled .nav-item .nav-link {--%>
<%--            text-align: center;--%>
<%--            padding: 1rem 0.5rem;--%>
<%--        }--%>

<%--        .sidebar-toggled .nav-item .nav-link i {--%>
<%--            margin-right: 0;--%>
<%--        }--%>

<%--        /* Mobile responsiveness */--%>
<%--        @media (max-width: 768px) {--%>
<%--            .sidebar {--%>
<%--                margin-left: -280px;--%>
<%--            }--%>

<%--            .sidebar.show {--%>
<%--                margin-left: 0;--%>
<%--            }--%>

<%--            #content-wrapper {--%>
<%--                margin-left: 0;--%>
<%--            }--%>

<%--            .sidebar-toggled .sidebar {--%>
<%--                margin-left: -80px;--%>
<%--            }--%>
<%--        }--%>

<%--        /* Enhanced Header Styles - Remove opacity */--%>
<%--        .topbar {--%>
<%--            background: #ffffff;--%>
<%--            border-bottom: 1px solid #e3e6f0;--%>
<%--            height: 80px;--%>
<%--            padding: 0 2rem;--%>
<%--            box-shadow: 0 2px 4px rgba(0,0,0,0.1);--%>
<%--        }--%>

<%--        .welcome-message h5 {--%>
<%--            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);--%>
<%--            -webkit-background-clip: text;--%>
<%--            -webkit-text-fill-color: transparent;--%>
<%--            background-clip: text;--%>
<%--            margin-bottom: 2px;--%>
<%--        }--%>

<%--        .user-profile-display {--%>
<%--            padding: 0.75rem 1.5rem !important;--%>
<%--            border-radius: 1rem;--%>
<%--            transition: all 0.3s ease;--%>
<%--            background: #ffffff;--%>
<%--            border: 1px solid #e3e6f0;--%>
<%--        }--%>

<%--        .user-profile-display:hover {--%>
<%--            background: #f8f9fc;--%>
<%--            border-color: #4e73df;--%>
<%--            transform: translateY(-1px);--%>
<%--            box-shadow: 0 4px 8px rgba(78, 115, 223, 0.15);--%>
<%--        }--%>

<%--        .avatar-circle-enhanced {--%>
<%--            width: 55px;--%>
<%--            height: 55px;--%>
<%--            border-radius: 50%;--%>
<%--            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            border: 3px solid #ffffff;--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.15);--%>
<%--            position: relative;--%>
<%--            transition: all 0.3s ease;--%>
<%--        }--%>

<%--        .avatar-initials {--%>
<%--            color: white;--%>
<%--            font-weight: bold;--%>
<%--            font-size: 1.1rem;--%>
<%--            letter-spacing: 0.5px;--%>
<%--        }--%>

<%--        .online-indicator {--%>
<%--            position: absolute;--%>
<%--            bottom: 2px;--%>
<%--            right: 2px;--%>
<%--            width: 16px;--%>
<%--            height: 16px;--%>
<%--            background-color: #1cc88a;--%>
<%--            border: 2px solid #ffffff;--%>
<%--            border-radius: 50%;--%>
<%--            animation: pulse 2s infinite;--%>
<%--        }--%>

<%--        @keyframes pulse {--%>
<%--            0% { box-shadow: 0 0 0 0 rgba(28, 200, 138, 0.7); }--%>
<%--            70% { box-shadow: 0 0 0 6px rgba(28, 200, 138, 0); }--%>
<%--            100% { box-shadow: 0 0 0 0 rgba(28, 200, 138, 0); }--%>
<%--        }--%>

<%--        .logout-btn {--%>
<%--            transition: all 0.3s ease;--%>
<%--            border-radius: 0.5rem;--%>
<%--            padding: 0.5rem 1rem;--%>
<%--        }--%>

<%--        .logout-btn:hover {--%>
<%--            background-color: #dc3545;--%>
<%--            border-color: #dc3545;--%>
<%--            color: white !important;--%>
<%--            transform: translateY(-1px);--%>
<%--            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);--%>
<%--        }--%>

<%--        @media (max-width: 768px) {--%>
<%--            .user-info {--%>
<%--                display: none !important;--%>
<%--            }--%>

<%--            .avatar-circle-enhanced {--%>
<%--                width: 45px;--%>
<%--                height: 45px;--%>
<%--            }--%>

<%--            .welcome-message {--%>
<%--                display: none !important;--%>
<%--            }--%>

<%--            .topbar {--%>
<%--                padding: 0 1rem;--%>
<%--                height: 65px;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body id="page-top">--%>
<%--<div id="wrapper">--%>
<%--    <!-- Modern Sidebar -->--%>
<%--    <ul class="navbar-nav sidebar sidebar-dark accordion">--%>
<%--        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="dashboard.jsp">--%>
<%--            <div class="sidebar-brand-icon">--%>
<%--                <i class="fas fa-university"></i>--%>
<%--            </div>--%>
<%--            <div class="sidebar-brand-text mx-3">BankAuto</div>--%>
<%--        </a>--%>

<%--        <hr class="sidebar-divider my-0">--%>

<%--        <li class="nav-item active">--%>
<%--            <a class="nav-link" href="dashboard.jsp">--%>
<%--                <i class="fas fa-fw fa-tachometer-alt"></i>--%>
<%--                <span>Dashboard</span>--%>
<%--            </a>--%>
<%--        </li>--%>

<%--        <hr class="sidebar-divider">--%>

<%--        <li class="nav-item">--%>
<%--            <a class="nav-link" href="createAccount.jsp">--%>
<%--                <i class="fas fa-fw fa-plus-circle"></i>--%>
<%--                <span>Create Account</span>--%>
<%--            </a>--%>
<%--        </li>--%>

<%--        <li class="nav-item">--%>
<%--            <a class="nav-link" href="viewAccounts.jsp">--%>
<%--                <i class="fas fa-fw fa-credit-card"></i>--%>
<%--                <span>My Accounts</span>--%>
<%--            </a>--%>
<%--        </li>--%>

<%--        <li class="nav-item">--%>
<%--            <a class="nav-link" href="transactions.jsp">--%>
<%--                <i class="fas fa-fw fa-exchange-alt"></i>--%>
<%--                <span>Transactions</span>--%>
<%--            </a>--%>
<%--        </li>--%>

<%--        <hr class="sidebar-divider">--%>

<%--        <li class="nav-item">--%>
<%--            <a class="nav-link" href="javascript:void(0)" onclick="performLogout()">--%>
<%--                <i class="fas fa-fw fa-sign-out-alt"></i>--%>
<%--                <span>Logout</span>--%>
<%--            </a>--%>
<%--        </li>--%>
<%--    </ul>--%>

<%--    <!-- Content Wrapper -->--%>
<%--    <div id="content-wrapper" class="d-flex flex-column">--%>
<%--        <div id="content">--%>
<%--            <!-- Topbar -->--%>
<%--            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow-lg">--%>
<%--                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">--%>
<%--                    <i class="fa fa-bars"></i>--%>
<%--                </button>--%>

<%--                <button id="sidebarToggle" class="btn btn-link d-none d-md-inline-block mr-3">--%>
<%--                    <i class="fa fa-bars"></i>--%>
<%--                </button>--%>

<%--                <div class="d-none d-md-flex align-items-center mr-auto ml-3">--%>
<%--                    <div class="welcome-message">--%>
<%--                        <h5 class="mb-0 text-primary font-weight-bold">BankAuto</h5>--%>
<%--                        <small class="text-muted">Digital Banking Platform</small>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <ul class="navbar-nav ml-auto d-flex align-items-center justify-content-end w-100">--%>
<%--                    <div class="topbar-divider d-none d-sm-block"></div>--%>

<%--                    <li class="nav-item">--%>
<%--                        <div class="nav-link user-profile-display">--%>
<%--                            <div class="d-flex align-items-center justify-content-end">--%>
<%--                                <div class="mr-3 d-none d-lg-block text-right user-info">--%>
<%--                                        <span class="text-gray-800 font-weight-bold d-block user-name" id="userDisplayName">--%>
<%--                                            User--%>
<%--                                        </span>--%>
<%--                                    <div class="small text-primary font-weight-medium user-status">Premium Customer</div>--%>
<%--                                    <div class="small text-muted user-last-login">--%>
<%--                                        <i class="fas fa-clock fa-sm mr-1"></i>Last login: Today--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="avatar-circle-enhanced">--%>
<%--                                    <span class="avatar-initials" id="userInitials">U</span>--%>
<%--                                    <div class="online-indicator"></div>--%>
<%--                                </div>--%>
<%--                                <div class="ml-3">--%>
<%--                                    <button onclick="performLogout()" class="btn btn-outline-danger btn-sm logout-btn">--%>
<%--                                        <i class="fas fa-sign-out-alt fa-sm"></i>--%>
<%--                                        <span class="d-none d-md-inline ml-1">Logout</span>--%>
<%--                                    </button>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </nav>--%>

<%--            <!-- Begin Page Content -->--%>
<%--            <div class="container-fluid">--%>
<%--                <div class="d-sm-flex align-items-center justify-content-between mb-4">--%>
<%--                    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>--%>
<%--                    <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">--%>
<%--                        <i class="fas fa-download fa-sm text-white-50"></i> Generate Report--%>
<%--                    </a>--%>
<%--                </div>--%>

<%--                <div class="alert alert-success mb-4">--%>
<%--                    <h4 class="alert-heading">--%>
<%--                        <i class="fas fa-check-circle"></i> Welcome to Your BankAuto Dashboard!--%>
<%--                    </h4>--%>
<%--                    <p>Your user account has been successfully created. To get started with banking services, please create your first bank account.</p>--%>
<%--                    <hr>--%>
<%--                    <p class="mb-0">--%>
<%--                        <a href="createAccount.jsp" class="btn btn-success">--%>
<%--                            <i class="fas fa-plus-circle"></i> Create Your First Bank Account--%>
<%--                        </a>--%>
<%--                    </p>--%>
<%--                </div>--%>

<%--                <div class="row">--%>
<%--                    <div class="col-xl-3 col-md-6 mb-4">--%>
<%--                        <div class="card border-left-primary shadow h-100 py-2">--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="row no-gutters align-items-center">--%>
<%--                                    <div class="col mr-2">--%>
<%--                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Balance</div>--%>
<%--                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="totalBalance">$0.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-auto">--%>
<%--                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-xl-3 col-md-6 mb-4">--%>
<%--                        <div class="card border-left-success shadow h-100 py-2">--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="row no-gutters align-items-center">--%>
<%--                                    <div class="col mr-2">--%>
<%--                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Savings Account</div>--%>
<%--                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="savingsBalance">$0.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-auto">--%>
<%--                                        <i class="fas fa-piggy-bank fa-2x text-gray-300"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-xl-3 col-md-6 mb-4">--%>
<%--                        <div class="card border-left-info shadow h-100 py-2">--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="row no-gutters align-items-center">--%>
<%--                                    <div class="col mr-2">--%>
<%--                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Checking Account</div>--%>
<%--                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="checkingBalance">$0.00</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-auto">--%>
<%--                                        <i class="fas fa-credit-card fa-2x text-gray-300"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-xl-3 col-md-6 mb-4">--%>
<%--                        <div class="card border-left-warning shadow h-100 py-2">--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="row no-gutters align-items-center">--%>
<%--                                    <div class="col mr-2">--%>
<%--                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Transactions</div>--%>
<%--                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="pendingTransactions">0</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-auto">--%>
<%--                                        <i class="fas fa-clock fa-2x text-gray-300"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="row">--%>
<%--                    <div class="col-lg-8 mb-4">--%>
<%--                        <div class="card shadow mb-4">--%>
<%--                            <div class="card-header py-3">--%>
<%--                                <h6 class="m-0 font-weight-bold text-primary">Recent Transactions</h6>--%>
<%--                            </div>--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="table-responsive">--%>
<%--                                    <table class="table table-bordered" width="100%" cellspacing="0">--%>
<%--                                        <thead>--%>
<%--                                        <tr>--%>
<%--                                            <th>Date</th>--%>
<%--                                            <th>Type</th>--%>
<%--                                            <th>Description</th>--%>
<%--                                            <th>Amount</th>--%>
<%--                                            <th>Status</th>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody id="recentTransactionsTableBody">--%>
<%--                                        <tr>--%>
<%--                                            <td colspan="5" class="text-center">No transactions found</td>--%>
<%--                                        </tr>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-lg-4 mb-4">--%>
<%--                        <div class="card shadow mb-4">--%>
<%--                            <div class="card-header py-3">--%>
<%--                                <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>--%>
<%--                            </div>--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="row">--%>
<%--                                    <div class="col-12 mb-3">--%>
<%--                                        <a href="transactions.jsp" class="btn btn-primary btn-block w-100">--%>
<%--                                            <i class="fas fa-paper-plane"></i> New Transfer--%>
<%--                                        </a>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-12 mb-3">--%>
<%--                                        <a href="createAccount.jsp" class="btn btn-success btn-block w-100">--%>
<%--                                            <i class="fas fa-plus"></i> Open New Account--%>
<%--                                        </a>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--<script src="../js/main.js"></script>--%>
<%--<script src="../js/loadDashboardData.js"></script>--%>

<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        const sidebarToggle = document.getElementById('sidebarToggle');--%>
<%--        const sidebarToggleTop = document.getElementById('sidebarToggleTop');--%>

<%--        if (sidebarToggle) {--%>
<%--            sidebarToggle.addEventListener('click', function() {--%>
<%--                document.body.classList.toggle('sidebar-toggled');--%>
<%--                const sidebar = document.querySelector('.sidebar');--%>
<%--                if (sidebar) {--%>
<%--                    sidebar.classList.toggle('toggled');--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>

<%--        if (sidebarToggleTop) {--%>
<%--            sidebarToggleTop.addEventListener('click', function() {--%>
<%--                const sidebar = document.querySelector('.sidebar');--%>
<%--                if (sidebar) {--%>
<%--                    sidebar.classList.toggle('show');--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>

<%--        loadRecentTransactions();--%>
<%--        loadUserInformation();--%>
<%--    });--%>

<%--    async function loadRecentTransactions() {--%>
<%--        try {--%>
<%--            const response = await fetch('/bankauto/user/api/transfers/history', {--%>
<%--                method: 'GET',--%>
<%--                headers: {--%>
<%--                    'Content-Type': 'application/json',--%>
<%--                    'Authorization': 'Bearer ' + localStorage.getItem('token')--%>
<%--                }--%>
<%--            });--%>

<%--            if (!response.ok) {--%>
<%--                throw new Error('Network response was not ok');--%>
<%--            }--%>

<%--            const data = await response.json();--%>
<%--            const transactions = data.transactions || [];--%>
<%--            const tableBody = document.getElementById('recentTransactionsTableBody');--%>

<%--            tableBody.innerHTML = '';--%>

<%--            if (transactions.length === 0) {--%>
<%--                tableBody.innerHTML = '<tr><td colspan="5" class="text-center">No transactions found</td></tr>';--%>
<%--                return;--%>
<%--            }--%>

<%--            transactions.forEach(transaction => {--%>
<%--                const row = document.createElement('tr');--%>
<%--                row.innerHTML =--%>
<%--                    '<td>' + new Date(transaction.date).toLocaleString() + '</td>' +--%>
<%--                    '<td>' + transaction.type + '</td>' +--%>
<%--                    '<td>' + transaction.description + '</td>' +--%>
<%--                    '<td>$' + transaction.amount.toFixed(2) + '</td>' +--%>
<%--                    '<td class="transfer-status-' + transaction.status.toLowerCase() + '">' + transaction.status + '</td>';--%>
<%--                tableBody.appendChild(row);--%>
<%--            });--%>
<%--        } catch (error) {--%>
<%--            console.error('Error loading transactions:', error);--%>
<%--            const tableBody = document.getElementById('recentTransactionsTableBody');--%>
<%--            tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">Error loading transactions</td></tr>';--%>
<%--        }--%>
<%--    }--%>

<%--    async function loadUserInformation() {--%>
<%--        try {--%>
<%--            const response = await fetch('account-details', {--%>
<%--                method: 'GET',--%>
<%--                headers: {--%>
<%--                    'Content-Type': 'application/json',--%>
<%--                    'X-Requested-With': 'XMLHttpRequest'--%>
<%--                },--%>
<%--                credentials: 'same-origin'--%>
<%--            });--%>

<%--            if (response.ok) {--%>
<%--                const data = await response.json();--%>
<%--                if (data && data.length > 0 && data[0].accountHolder) {--%>
<%--                    const fullName = data[0].accountHolder;--%>
<%--                    updateUserDisplay(fullName);--%>
<%--                }--%>
<%--            }--%>
<%--        } catch (error) {--%>
<%--            console.log('Could not load user information:', error);--%>
<%--        }--%>
<%--    }--%>

<%--    function updateUserDisplay(fullName) {--%>
<%--        const userDisplayName = document.getElementById('userDisplayName');--%>
<%--        if (userDisplayName) {--%>
<%--            userDisplayName.textContent = fullName;--%>
<%--        }--%>

<%--        const userInitials = document.getElementById('userInitials');--%>
<%--        if (userInitials && fullName) {--%>
<%--            const names = fullName.split(' ');--%>
<%--            let initials = 'U';--%>
<%--            if (names.length >= 2) {--%>
<%--                initials = names[0].substring(0, 1).toUpperCase() + names[names.length - 1].substring(0, 1).toUpperCase();--%>
<%--            } else if (names.length === 1) {--%>
<%--                initials = names[0].substring(0, Math.min(2, names[0].length)).toUpperCase();--%>
<%--            }--%>
<%--            userInitials.textContent = initials;--%>
<%--        }--%>
<%--    }--%>

<%--    function performLogout() {--%>
<%--        if (confirm('Are you sure you want to logout?')) {--%>
<%--            try {--%>
<%--                localStorage.removeItem('token');--%>
<%--                localStorage.removeItem('userSession');--%>
<%--                window.location.href = '../logout.jsp';--%>
<%--            } catch (error) {--%>
<%--                console.error('Error during logout:', error);--%>
<%--                window.location.href = '../logout.jsp';--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/user.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .transfer-status-pending { color: #ffc107; }
        .transfer-status-completed { color: #198754; }
        .transfer-status-failed { color: #dc3545; }
        .transfer-status-scheduled { color: #0dcaf0; }

        /* Modern Sidebar Design */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-brand {
            padding: 2rem 1.5rem;
            background: rgba(255,255,255,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
            transition: all 0.3s ease;
        }

        .sidebar-brand:hover {
            background: rgba(255,255,255,0.15);
            text-decoration: none;
        }

        .sidebar-brand-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
        }

        .sidebar-brand-icon i {
            color: white;
            font-size: 1.3rem;
        }

        .sidebar-brand-text {
            color: white;
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .sidebar-divider {
            border-color: rgba(255,255,255,0.15);
            margin: 0.5rem 0;
        }

        .nav-item {
            margin: 0.2rem 1rem;
        }

        .nav-item .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 1rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-item .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            transition: left 0.5s ease;
        }

        .nav-item .nav-link:hover::before {
            left: 100%;
        }

        .nav-item .nav-link:hover {
            color: white;
            background: rgba(255,255,255,0.1);
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .nav-item.active .nav-link {
            color: white;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }

        .nav-item .nav-link i {
            width: 20px;
            margin-right: 0.8rem;
            font-size: 1.1rem;
        }

        .nav-item .nav-link span {
            font-size: 0.95rem;
        }

        /* Content wrapper adjustment */
        #content-wrapper {
            margin-left: 280px;
            transition: margin-left 0.3s ease;
        }

        /* Sidebar collapsed state */
        .sidebar-toggled .sidebar {
            width: 80px;
        }

        .sidebar-toggled #content-wrapper {
            margin-left: 80px;
        }

        .sidebar-toggled .sidebar-brand-text,
        .sidebar-toggled .nav-item .nav-link span {
            display: none;
        }

        .sidebar-toggled .sidebar-brand {
            padding: 1.5rem 1rem;
            text-align: center;
        }

        .sidebar-toggled .sidebar-brand-icon {
            margin-right: 0;
        }

        .sidebar-toggled .nav-item {
            margin: 0.2rem 0.5rem;
        }

        .sidebar-toggled .nav-item .nav-link {
            text-align: center;
            padding: 1rem 0.5rem;
        }

        .sidebar-toggled .nav-item .nav-link i {
            margin-right: 0;
        }

        /* Mobile responsiveness */
        @media (max-width: 768px) {
            .sidebar {
                margin-left: -280px;
            }

            .sidebar.show {
                margin-left: 0;
            }

            #content-wrapper {
                margin-left: 0;
            }

            .sidebar-toggled .sidebar {
                margin-left: -80px;
            }
        }

        /* Enhanced Header Styles */
        .topbar {
            background: #ffffff;
            border-bottom: 1px solid #e3e6f0;
            height: 80px;
            padding: 0 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .welcome-message h5 {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 2px;
        }

        .user-profile-display {
            padding: 0.75rem 1.5rem !important;
            border-radius: 1rem;
            transition: all 0.3s ease;
            background: #ffffff;
            border: 1px solid #e3e6f0;
        }

        .user-profile-display:hover {
            background: #f8f9fc;
            border-color: #4e73df;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(78, 115, 223, 0.15);
        }

        .avatar-circle-enhanced {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid #ffffff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            position: relative;
            transition: all 0.3s ease;
        }

        .avatar-initials {
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }

        .online-indicator {
            position: absolute;
            bottom: 2px;
            right: 2px;
            width: 16px;
            height: 16px;
            background-color: #1cc88a;
            border: 2px solid #ffffff;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(28, 200, 138, 0.7); }
            70% { box-shadow: 0 0 0 6px rgba(28, 200, 138, 0); }
            100% { box-shadow: 0 0 0 0 rgba(28, 200, 138, 0); }
        }

        .logout-btn {
            transition: all 0.3s ease;
            border-radius: 0.5rem;
            padding: 0.5rem 1rem;
        }

        .logout-btn:hover {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }

        @media (max-width: 768px) {
            .user-info {
                display: none !important;
            }

            .avatar-circle-enhanced {
                width: 45px;
                height: 45px;
            }

            .welcome-message {
                display: none !important;
            }

            .topbar {
                padding: 0 1rem;
                height: 65px;
            }
        }
    </style>
</head>
<body id="page-top">
<div id="wrapper">
    <!-- Modern Sidebar -->
    <ul class="navbar-nav sidebar sidebar-dark accordion">
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="dashboard.jsp">
            <div class="sidebar-brand-icon">
                <i class="fas fa-university"></i>
            </div>
            <div class="sidebar-brand-text mx-3">BankAuto</div>
        </a>

        <hr class="sidebar-divider my-0">

        <li class="nav-item active">
            <a class="nav-link" href="dashboard.jsp">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <hr class="sidebar-divider">

        <li class="nav-item">
            <a class="nav-link" href="createAccount.jsp">
                <i class="fas fa-fw fa-plus-circle"></i>
                <span>Create Account</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="viewAccounts.jsp">
                <i class="fas fa-fw fa-credit-card"></i>
                <span>My Accounts</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="transactions.jsp">
                <i class="fas fa-fw fa-exchange-alt"></i>
                <span>Transactions</span>
            </a>
        </li>

        <hr class="sidebar-divider">

        <li class="nav-item">
            <a class="nav-link" href="javascript:void(0)" onclick="performLogout()">
                <i class="fas fa-fw fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </li>
    </ul>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow-lg">
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <button id="sidebarToggle" class="btn btn-link d-none d-md-inline-block mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <div class="d-none d-md-flex align-items-center mr-auto ml-3">
                    <div class="welcome-message">
                        <h5 class="mb-0 text-primary font-weight-bold">BankAuto</h5>
                        <small class="text-muted">Digital Banking Platform</small>
                    </div>
                </div>

                <ul class="navbar-nav ml-auto d-flex align-items-center justify-content-end w-100">
                    <div class="topbar-divider d-none d-sm-block"></div>

                    <li class="nav-item">
                        <div class="nav-link user-profile-display">
                            <div class="d-flex align-items-center justify-content-end">
                                <div class="mr-3 d-none d-lg-block text-right user-info">
                                        <span class="text-gray-800 font-weight-bold d-block user-name" id="userDisplayName">
                                            User
                                        </span>
                                    <div class="small text-primary font-weight-medium user-status">Premium Customer</div>
                                    <div class="small text-muted user-last-login">
                                        <i class="fas fa-clock fa-sm mr-1"></i>Last login: Today
                                    </div>
                                </div>
                                <div class="avatar-circle-enhanced">
                                    <span class="avatar-initials" id="userInitials">U</span>
                                    <div class="online-indicator"></div>
                                </div>
                                <div class="ml-3">
                                    <button onclick="performLogout()" class="btn btn-outline-danger btn-sm logout-btn">
                                        <i class="fas fa-sign-out-alt fa-sm"></i>
                                        <span class="d-none d-md-inline ml-1">Logout</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </nav>

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                        <i class="fas fa-download fa-sm text-white-50"></i> Generate Report
                    </a>
                </div>

                <div class="alert alert-success mb-4">
                    <h4 class="alert-heading">
                        <i class="fas fa-check-circle"></i> Welcome to Your BankAuto Dashboard!
                    </h4>
                    <p>Your user account has been successfully created. To get started with banking services, please create your first bank account.</p>
                    <hr>
                    <p class="mb-0">
                        <a href="createAccount.jsp" class="btn btn-success">
                            <i class="fas fa-plus-circle"></i> Create Your First Bank Account
                        </a>
                    </p>
                </div>

                <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Balance</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="totalBalance">$0.00</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Savings Account</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="savingsBalance">$0.00</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-piggy-bank fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Checking Account</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="checkingBalance">$0.00</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-credit-card fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Transactions</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="pendingTransactions">0</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Recent Transactions</h6>
                            </div>
                            <div class="card-body">
                                <div id="transactionsLoadingSpinner" class="text-center" style="display: none;">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                    <p class="mt-2">Loading transactions...</p>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Description</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                        </tr>
                                        </thead>
                                        <tbody id="recentTransactionsTableBody">
                                        <tr>
                                            <td colspan="5" class="text-center">Loading transactions...</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12 mb-3">
                                        <a href="transactions.jsp" class="btn btn-primary btn-block w-100">
                                            <i class="fas fa-paper-plane"></i> New Transfer
                                        </a>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <a href="createAccount.jsp" class="btn btn-success btn-block w-100">
                                            <i class="fas fa-plus"></i> Open New Account
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarToggleTop = document.getElementById('sidebarToggleTop');

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                document.body.classList.toggle('sidebar-toggled');
                const sidebar = document.querySelector('.sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('toggled');
                }
            });
        }

        if (sidebarToggleTop) {
            sidebarToggleTop.addEventListener('click', function() {
                const sidebar = document.querySelector('.sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('show');
                }
            });
        }

        // Initialize dashboard
        initializeDashboard();
    });

    function initializeDashboard() {
        loadUserInformation();
        loadAccountBalances();
        loadRecentTransactions();
        loadPendingTransactions();
    }

    async function loadUserInformation() {
        try {
            const response = await fetch('account-details', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'same-origin'
            });

            if (response.ok) {
                const data = await response.json();
                if (data && data.length > 0 && data[0].accountHolder) {
                    const fullName = data[0].accountHolder;
                    updateUserDisplay(fullName);
                }
            }
        } catch (error) {
            console.log('Could not load user information:', error);
        }
    }

    function updateUserDisplay(fullName) {
        const userDisplayName = document.getElementById('userDisplayName');
        if (userDisplayName) {
            userDisplayName.textContent = fullName;
        }

        const userInitials = document.getElementById('userInitials');
        if (userInitials && fullName) {
            const names = fullName.split(' ');
            let initials = 'U';
            if (names.length >= 2) {
                initials = names[0].substring(0, 1).toUpperCase() + names[names.length - 1].substring(0, 1).toUpperCase();
            } else if (names.length === 1) {
                initials = names[0].substring(0, Math.min(2, names[0].length())).toUpperCase();
            }
            userInitials.textContent = initials;
        }
    }

    async function loadAccountBalances() {
        try {
            const response = await fetch('account-details', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'same-origin'
            });

            if (response.ok) {
                const accounts = await response.json();

                let totalBalance = 0;
                let savingsBalance = 0;
                let checkingBalance = 0;

                accounts.forEach(account => {
                    const balance = parseFloat(account.balance) || 0;
                    totalBalance += balance;

                    if (account.accountType === 'SAVINGS') {
                        savingsBalance += balance;
                    } else if (account.accountType === 'CHECKING') {
                        checkingBalance += balance;
                    }
                });

                updateBalanceCard('totalBalance', totalBalance);
                updateBalanceCard('savingsBalance', savingsBalance);
                updateBalanceCard('checkingBalance', checkingBalance);
            } else {
                console.log('Could not load account balances');
            }
        } catch (error) {
            console.error('Error loading account balances:', error);
        }
    }

    function updateBalanceCard(elementId, balance) {
        const element = document.getElementById(elementId);
        if (element) {
            element.textContent = '$' + balance.toFixed(2);
        }
    }
9
    async function loadRecentTransactions() {
        const tableBody = document.getElementById('recentTransactionsTableBody');
        const loadingSpinner = document.getElementById('transactionsLoadingSpinner');

        showTransactionsLoading(true);

        try {
            const response = await fetch('api/transfers/history', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'same-origin'
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const data = await response.json();

            if (data.success) {
                displayTransactions(data.transactions || []);
            } else {
                throw new Error(data.message || 'Failed to load transactions');
            }

        } catch (error) {
            console.error('Error loading transactions:', error);
            displayTransactionsError('Unable to load transactions at this time.');
        } finally {
            showTransactionsLoading(false);
        }
    }

    function displayTransactions(transactions) {
        const tableBody = document.getElementById('recentTransactionsTableBody');

        if (!transactions || transactions.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No recent transactions found</td></tr>';
            return;
        }

        tableBody.innerHTML = '';

        transactions.forEach(transaction => {
            const row = document.createElement('tr');

            const transactionDate = new Date(transaction.date);
            const formattedDate = transactionDate.toLocaleDateString() + ' ' + transactionDate.toLocaleTimeString();

            row.innerHTML =
                '<td>' + formattedDate + '</td>' +
                '<td><span class="badge badge-info">' + transaction.type + '</span></td>' +
                '<td>' + transaction.description + '</td>' +
                '<td class="' + (transaction.amount >= 0 ? 'text-success' : 'text-danger') + '">' +
                (transaction.amount >= 0 ? '+' : '') + '$' + Math.abs(transaction.amount).toFixed(2) +
                '</td>' +
                '<td>' +
                '<span class="badge badge-' + getStatusBadgeClass(transaction.status) + ' transfer-status-' + transaction.status.toLowerCase() + '">' +
                transaction.status +
                '</span>' +
                '</td>';

            tableBody.appendChild(row);
        });
    }

    function getStatusBadgeClass(status) {
        switch (status.toLowerCase()) {
            case 'completed':
                return 'success';
            case 'pending':
            case 'processing':
                return 'warning';
            case 'failed':
            case 'cancelled':
                return 'danger';
            case 'scheduled':
            case 'active':
                return 'info';
            default:
                return 'secondary';
        }
    }

    function displayTransactionsError(errorMessage) {
        const tableBody = document.getElementById('recentTransactionsTableBody');
        tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">' + errorMessage + '</td></tr>';
    }

    function showTransactionsLoading(isLoading) {
        const spinner = document.getElementById('transactionsLoadingSpinner');
        const tableContainer = document.querySelector('.table-responsive');

        if (isLoading) {
            if (spinner) spinner.style.display = 'block';
            if (tableContainer) tableContainer.style.display = 'none';
        } else {
            if (spinner) spinner.style.display = 'none';
            if (tableContainer) tableContainer.style.display = 'block';
        }
    }

    async function loadPendingTransactions() {
        try {
            const response = await fetch('api/transfers/pending', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'same-origin'
            });

            if (response.ok) {
                const data = await response.json();
                if (data.success) {
                    const pendingCount = data.pendingCount || 0;
                    const pendingElement = document.getElementById('pendingTransactions');
                    if (pendingElement) {
                        pendingElement.textContent = pendingCount;
                    }
                }
            }
        } catch (error) {
            console.error('Error loading pending transactions:', error);
        }
    }

    function performLogout() {
        if (confirm('Are you sure you want to logout?')) {
            try {
                localStorage.removeItem('token');
                localStorage.removeItem('userSession');
                window.location.href = '../logout.jsp';
            } catch (error) {
                console.error('Error during logout:', error);
                window.location.href = '../logout.jsp';
            }
        }
    }
</script>
</body>
</html>
