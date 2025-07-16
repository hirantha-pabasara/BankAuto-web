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
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion">
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
            
            <li class="nav-item">
                <a class="nav-link" href="notifications.jsp">
                    <i class="fas fa-fw fa-bell"></i>
                    <span>Notifications</span>
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
                    <!-- Sidebar Toggle -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    
                    <!-- Desktop Sidebar Toggle -->
                    <button id="sidebarToggle" class="btn btn-link d-none d-md-inline-block mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    
                    <!-- Bank Brand/Welcome Message -->
                    <div class="d-none d-md-flex align-items-center mr-auto ml-3">
                        <div class="welcome-message">
                            <h5 class="mb-0 text-primary font-weight-bold">BankAuto</h5>
                            <small class="text-muted">Digital Banking Platform</small>
                        </div>
                    </div>
                    
                    <!-- Navbar Right Items -->
                    <ul class="navbar-nav ml-auto d-flex align-items-center justify-content-end w-100">
                        <!-- Notifications Dropdown -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <span class="badge badge-danger badge-counter">3</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end shadow animated--grow-in" aria-labelledby="alertsDropdown" style="max-width: 350px;">
                                <h6 class="dropdown-header bg-primary text-white">
                                    <i class="fas fa-bell mr-2"></i>Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">Today</div>
                                        <span class="font-weight-bold">Monthly report is ready!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">Yesterday</div>
                                        $290.29 deposited to your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">2 days ago</div>
                                        Spending alert: High activity detected
                                    </div>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-center small text-gray-500" href="#">
                                    <i class="fas fa-eye mr-1"></i>View All Alerts
                                </a>
                            </div>
                        </li>
                        
                        <!-- Messages Dropdown -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <span class="badge badge-primary badge-counter">2</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end shadow animated--grow-in" aria-labelledby="messagesDropdown" style="max-width: 350px;">
                                <h6 class="dropdown-header bg-info text-white">
                                    <i class="fas fa-envelope mr-2"></i>Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <div class="status-indicator bg-success"></div>
                                        <div class="avatar-sm bg-primary rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="fas fa-user text-white"></i>
                                        </div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Account verification completed</div>
                                        <div class="small text-gray-500">Support Team · 2h</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <div class="status-indicator bg-warning"></div>
                                        <div class="avatar-sm bg-success rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="fas fa-info text-white"></i>
                                        </div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">New security feature available</div>
                                        <div class="small text-gray-500">Security Team · 1d</div>
                                    </div>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-center small text-gray-500" href="#">
                                    <i class="fas fa-envelope-open mr-1"></i>Read All Messages
                                </a>
                            </div>
                        </li>
                        
                        <!-- Divider -->
                        <div class="topbar-divider d-none d-sm-block"></div>
                        
                        <!-- User Information -->
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
                                        <!-- <a href="../logout.jsp" class="btn btn-outline-danger btn-sm logout-btn"> -->
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
                    
                    <!-- Welcome Message for New Users -->
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
                    
                    <!-- Content Row -->
                    <div class="row">
                        <!-- Total Balance Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Balance</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$15,342.50</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Savings Account Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Savings Account</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$12,500.00</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-piggy-bank fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Checking Account Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Checking Account</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$2,842.50</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-credit-card fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Pending Transactions Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Transactions</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">3</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Content Row -->
                    <div class="row">
                        <!-- Recent Transactions -->
                        <div class="col-lg-8 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex justify-content-between align-items-center">
                                    <h6 class="m-0 font-weight-bold text-primary">Recent Transactions</h6>
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="loadRecentTransactions()">
                                            <i class="fas fa-sync-alt"></i> Refresh
                                        </button>
                                        <button type="button" class="btn btn-sm btn-outline-success" onclick="filterInterestTransactions()">
                                            <i class="fas fa-filter"></i> Interest Only
                                        </button>
                                        <button type="button" class="btn btn-sm btn-outline-info" onclick="viewAllTransactions()">
                                            <i class="fas fa-list"></i> View All
                                        </button>
                                    </div>
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
                                    <div class="text-center mt-3">
                                        <small class="text-muted">Showing last 10 transactions. <a href="transactions.jsp">View all transactions</a></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Quick Actions -->
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
                                        <div class="col-12 mb-3">
                                            <button class="btn btn-info btn-block w-100" onclick="payBills()">
                                                <i class="fas fa-file-invoice-dollar"></i> Pay Bills
                                            </button>
                                        </div>
                                        <div class="col-12">
                                            <button class="btn btn-warning btn-block w-100" onclick="requestCard()">
                                                <i class="fas fa-credit-card"></i> Request Card
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Notifications -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Notifications</h6>
                                </div>
                                <div class="card-body">
                                    <div class="small text-muted">Today</div>
                                    <div class="mb-2">
                                        <i class="fas fa-info-circle text-info"></i>
                                        Your salary has been deposited
                                    </div>
                                    <div class="small text-muted">Yesterday</div>
                                    <div class="mb-2">
                                        <i class="fas fa-exclamation-triangle text-warning"></i>
                                        ATM withdrawal pending approval
                                    </div>
                                    <div class="small text-muted">3 days ago</div>
                                    <div class="mb-2">
                                        <i class="fas fa-check-circle text-success"></i>
                                        Account statement ready
                                    </div>
                                    <div class="text-center">
                                        <a href="notifications.jsp" class="btn btn-sm btn-primary">View All</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Transaction Details Modal -->
    <div class="modal fade" id="transactionDetailsModal" tabindex="-1" aria-labelledby="transactionDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="transactionDetailsModalLabel">
                        <i class="fas fa-info-circle"></i> Transaction Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="transactionDetailsContent">
                    <!-- Populated dynamically -->
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script src="../js/loadDashboardData.js"></script>
    
    <style>
        /* Enhanced Header Styles */
        .topbar {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fc 100%);
            border-bottom: 1px solid #e3e6f0;
            height: 80px;
            padding: 0 2rem;
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
            background: linear-gradient(135deg, rgba(78, 115, 223, 0.05) 0%, rgba(78, 115, 223, 0.1) 100%);
            border: 1px solid rgba(78, 115, 223, 0.1);
            margin-right: 0;
            margin-left: auto;
        }
        
        .user-profile-display:hover {
            background: linear-gradient(135deg, rgba(78, 115, 223, 0.1) 0%, rgba(78, 115, 223, 0.15) 100%);
            border-color: rgba(78, 115, 223, 0.2);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(78, 115, 223, 0.15);
        }
        
        .user-info .user-name {
            font-size: 1rem;
            margin-bottom: 2px;
            color: #2c3e50;
        }
        
        .user-info .user-status {
            font-size: 0.8rem;
            margin-bottom: 1px;
        }
        
        .user-info .user-last-login {
            font-size: 0.75rem;
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
        
        .avatar-circle-enhanced:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 16px rgba(0,0,0,0.2);
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
        
        .nav-link {
            position: relative;
            transition: all 0.3s ease;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            margin: 0 0.25rem;
        }
        
        .nav-link:hover {
            background-color: rgba(78, 115, 223, 0.1);
            transform: translateY(-1px);
        }
        
        .badge-counter {
            position: absolute;
            top: 8px;
            right: 8px;
            font-size: 0.65rem;
            border-radius: 50%;
            min-width: 18px;
            height: 18px;
            line-height: 18px;
            text-align: center;
            color: white;
            font-weight: bold;
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-3px); }
            60% { transform: translateY(-1px); }
        }
        
        .badge-danger {
            background: linear-gradient(135deg, #e74a3b 0%, #c0392b 100%);
            box-shadow: 0 2px 4px rgba(231, 74, 59, 0.3);
        }
        
        .badge-primary {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            box-shadow: 0 2px 4px rgba(78, 115, 223, 0.3);
        }
        
        .avatar-circle {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid #ffffff;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }
        
        .avatar-sm {
            width: 35px;
            height: 35px;
        }
        
        .dropdown-menu {
            border-radius: 0.75rem;
            border: none;
            box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.15);
            min-width: 280px;
            overflow: hidden;
        }
        
        .dropdown-header {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 1rem 1.5rem;
            margin: 0;
            font-size: 0.875rem;
        }
        
        .dropdown-item {
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            border: none;
        }
        
        .dropdown-item:hover {
            background-color: #f8f9fc;
            transform: translateX(3px);
        }
        
        .dropdown-item.text-danger:hover {
            background-color: #f8d7da;
            color: #721c24 !important;
        }
        
        .dropdown-divider {
            margin: 0.5rem 0;
            border-top: 1px solid #e3e6f0;
        }
        
        .topbar-divider {
            width: 0;
            border-right: 1px solid #e3e6f0;
            height: 40px;
            margin: auto 1rem;
        }
        
        .icon-circle {
            height: 35px;
            width: 35px;
            border-radius: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
        }
        
        .dropdown-list-image {
            position: relative;
        }
        
        .status-indicator {
            position: absolute;
            top: -2px;
            right: -2px;
            width: 12px;
            height: 12px;
            border-radius: 100%;
            border: 2px solid #fff;
        }
        
        .animated--grow-in {
            animation-name: growIn;
            animation-duration: 200ms;
            animation-timing-function: cubic-bezier(0.18, 1.25, 0.4, 1);
        }
        
        @keyframes growIn {
            0% {
                transform: scale(0.9);
                opacity: 0;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        /* Ensure proper navbar alignment */
        .navbar-nav {
            align-items: center;
        }
        
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
        }
        
        /* Fix dropdown positioning */
        .dropdown-menu-end {
            right: 0;
            left: auto;
        }
        
        /* User info styling */
        .text-right {
            text-align: right;
        }
        
        .font-weight-bold {
            font-weight: 600 !important;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .user-info {
                display: none !important;
            }
            
            .avatar-circle-enhanced {
                width: 45px;
                height: 45px;
            }
            
            .avatar-initials {
                font-size: 1rem;
            }
            
            .online-indicator {
                width: 14px;
                height: 14px;
            }
            
            .welcome-message {
                display: none !important;
            }
            
            .user-profile-display {
                padding: 0.5rem 1rem !important;
                margin-right: 0.5rem;
            }
            
            .topbar {
                padding: 0 1rem;
                height: 65px;
            }
            
            .badge-counter {
                top: 3px;
                right: 3px;
                min-width: 16px;
                height: 16px;
                line-height: 16px;
                font-size: 0.6rem;
            }
            
            .logout-btn span {
                display: none !important;
            }
            
            .logout-btn {
                padding: 0.4rem 0.6rem;
            }
        }
        
        @media (max-width: 576px) {
            .dropdown-menu {
                min-width: 250px;
                margin-right: 1rem;
            }
            
            .nav-link {
                padding: 0.5rem 0.75rem;
            }
            
            .topbar {
                height: 60px;
            }
            
            .avatar-circle-enhanced {
                width: 40px;
                height: 40px;
            }
            
            .avatar-initials {
                font-size: 0.9rem;
            }
            
            .user-profile-display {
                padding: 0.4rem 0.8rem !important;
            }
        }
        
        /* Fix for content wrapper to prevent overlap */
        #content-wrapper {
            padding-left: 1rem;
            padding-right: 1rem;
        }
        
        /* Improved dropdown positioning */
        .dropdown-menu-end {
            right: 0;
            left: auto;
            margin-top: 0.5rem;
        }
        
        /* Better notification alignment */
        .navbar-nav {
            align-items: center;
            padding-right: 1rem;
        }
        
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
        }
    </style>
    <script>
        // Sidebar toggle functionality
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
        });
        
        function payBills() {
            // TODO: Implement bill payment
            alert('Bill payment feature coming soon!');
        }
        
        function requestCard() {
            // TODO: Implement card request
            alert('Card request submitted successfully!');
        }
        
        // Transaction management functions
        async function loadRecentTransactions() {
            showTransactionsLoading(true);
            
            try {
                const response = await fetch('../api/transfers/history', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                    }
                });
                
                if (!response.ok) {
                    throw new Error('Network response was not ok ' + response.statusText);
                }
                
                const data = await response.json();
                const transactions = data.transactions || [];
                const tableBody = document.getElementById('recentTransactionsTableBody');
                
                // Clear existing table rows
                tableBody.innerHTML = '';
                
                // Populate table with transaction data
                transactions.forEach(transaction => {
                    const row = document.createElement('tr');
                    row.innerHTML = 
                        '<td>' + new Date(transaction.date).toLocaleString() + '</td>' +
                        '<td>' + transaction.type + '</td>' +
                        '<td>' + transaction.description + '</td>' +
                        '<td>$' + transaction.amount.toFixed(2) + '</td>' +
                        '<td class="transfer-status-' + transaction.status.toLowerCase() + '">' + transaction.status + '</td>';
                    tableBody.appendChild(row);
                });
            } catch (error) {
                console.error('Error loading transactions:', error);
                const tableBody = document.getElementById('recentTransactionsTableBody');
                tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">Error loading transactions. Please try again later.</td></tr>';
            } finally {
                showTransactionsLoading(false);
            }
        }
        
        function showTransactionsLoading(isLoading) {
            const spinner = document.getElementById('transactionsLoadingSpinner');
            const tableContainer = document.querySelector('.table-responsive');
            
            if (isLoading) {
                spinner.style.display = 'block';
                if (tableContainer) {
                    tableContainer.style.display = 'none';
                }
            } else {
                spinner.style.display = 'none';
                if (tableContainer) {
                    tableContainer.style.display = 'block';
                }
            }
        }
        
        // Initialize dashboard data
        async function initDashboard() {
            try {
                // Load recent transactions
                await loadRecentTransactions();
                
                // Load account balances and other data
                // ...
            } catch (error) {
                console.error('Error initializing dashboard:', error);
            }
        }
        
        // Call initDashboard on page load
        document.addEventListener('DOMContentLoaded', initDashboard);
        
        // Logout function
        function performLogout() {
            if (confirm('Are you sure you want to logout?')) {
                try {
                    // Clear any local storage
                    localStorage.removeItem('token');
                    localStorage.removeItem('userSession');
                    
                    // Redirect to logout page
                    window.location.href = '../logout.jsp';
                } catch (error) {
                    console.error('Error during logout:', error);
                    // Fallback: just redirect to logout page
                    window.location.href = '../logout.jsp';
                }
            }
        }
        
        // View transaction details in modal
        function viewTransactionDetails(transactionId) {
            // TODO: Load and display transaction details
            const transactionDetailsContent = document.getElementById('transactionDetailsContent');
            transactionDetailsContent.innerHTML = '<p>Loading transaction details...</p>';
            
            // Simulate loading delay
            setTimeout(() => {
                transactionDetailsContent.innerHTML = 
                    '<h5>Transaction ID: ' + transactionId + '</h5>' +
                    '<div class="mb-3">' +
                        '<strong>Date:</strong> ' + new Date().toLocaleString() +
                    '</div>' +
                    '<div class="mb-3">' +
                        '<strong>Type:</strong> Transfer' +
                    '</div>' +
                    '<div class="mb-3">' +
                        '<strong>Status:</strong> Completed' +
                    '</div>' +
                    '<div class="mb-3">' +
                        '<strong>Amount:</strong> $100.00' +
                    '</div>' +
                    '<div class="mb-3">' +
                        '<strong>From:</strong> ACC1234567890' +
                    '</div>' +
                    '<div class="mb-3">' +
                        '<strong>To:</strong> ACC0987654321' +
                    '</div>' +
                    '<div class="mb-3">' +
                        '<strong>Description:</strong> Payment for invoice #1234' +
                    '</div>';
            }, 1000);
        }
        
        // Load transactions when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Load recent transactions after other DOM content is loaded
            setTimeout(loadRecentTransactions, 1000);
            
            // Load user information
            loadUserInformation();
        });
        
        // Load user information from session/backend
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
                // Keep default values
            }
        }
        
        // Update user display elements
        function updateUserDisplay(fullName) {
            // Update display name
            const userDisplayName = document.getElementById('userDisplayName');
            if (userDisplayName) {
                userDisplayName.textContent = fullName;
            }
            
            // Update initials
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

        // Additional helper functions
        async function filterInterestTransactions() {
            showTransactionsLoading(true);
            
            try {
                const response = await fetch('../api/interest/transactions', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    credentials: 'same-origin'
                });
                
                if (!response.ok) {
                    throw new Error('Failed to load interest transactions');
                }
                
                const transactions = await response.json();
                displayTransactions(transactions, true);
                
            } catch (error) {
                console.error('Error loading interest transactions:', error);
                displayTransactionsError('Failed to load interest transactions: ' + error.message);
            } finally {
                showTransactionsLoading(false);
            }
        }
        
        function viewAllTransactions() {
            // Redirect to the transactions page
            window.location.href = 'transactions.jsp';
        }
        
        function displayTransactions(transactions, isInterestOnly) {
            const tableBody = document.getElementById('recentTransactionsTableBody');
            
            if (!transactions || transactions.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="5" class="text-center">No transactions found</td></tr>';
                return;
            }
            
            // Sort by date (newest first) and take only the first 10
            const sortedTransactions = transactions
                .sort((a, b) => new Date(b.date) - new Date(a.date))
                .slice(0, 10);
            
            tableBody.innerHTML = '';
            sortedTransactions.forEach(transaction => {
                const row = document.createElement('tr');
                row.innerHTML = 
                    '<td>' + new Date(transaction.date).toLocaleString() + '</td>' +
                    '<td>' + transaction.type + '</td>' +
                    '<td>' + transaction.description + '</td>' +
                    '<td>$' + transaction.amount.toFixed(2) + '</td>' +
                    '<td class="transfer-status-' + transaction.status.toLowerCase() + '">' + transaction.status + '</td>';
                tableBody.appendChild(row);
            });
        }
        
        function displayTransactionsError(errorMessage) {
            const tableBody = document.getElementById('recentTransactionsTableBody');
            tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">' + errorMessage + '</td></tr>';
        }
    </script>
</body>
</html>
