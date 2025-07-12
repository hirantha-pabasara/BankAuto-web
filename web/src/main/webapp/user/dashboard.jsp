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
                <a class="nav-link" href="../logout.jsp">
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
                    
                    <!-- Search Bar -->
                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search transactions, accounts..." aria-label="Search">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                    
                    <!-- Navbar Right Items -->
                    <ul class="navbar-nav ml-auto">
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
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <div class="d-flex align-items-center">
                                    <div class="mr-2 d-none d-lg-block text-right">
                                        <span class="text-gray-800 font-weight-bold d-block">
                                            <%
                                                // Get user full name from session
                                                String userFullName = (String) session.getAttribute("userFullName");
                                                if (userFullName != null && !userFullName.trim().isEmpty()) {
                                                    out.print(userFullName);
                                                } else {
                                                    out.print("Guest User");
                                                }
                                            %>
                                        </span>
                                        <div class="small text-gray-500">Premium Customer</div>
                                    </div>
                                    <div class="avatar-circle">
                                        <i class="fas fa-user text-white"></i>
                                    </div>
                                </div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right shadow-lg animated--grow-in border-0">
                                <div class="dropdown-header bg-primary text-white">
                                    <i class="fas fa-user fa-sm fa-fw mr-2"></i>
                                    Account Options
                                </div>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    My Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Account Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-shield-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Security & Privacy
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-bell fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Notification Settings
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="../logout.jsp">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2"></i>
                                    Logout
                                </a>
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
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Recent Transactions</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Description</th>
                                                    <th>Amount</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>2025-01-15</td>
                                                    <td>Transfer to John Smith</td>
                                                    <td class="text-danger">-$500.00</td>
                                                    <td><span class="badge bg-success">Completed</span></td>
                                                </tr>
                                                <tr>
                                                    <td>2025-01-14</td>
                                                    <td>Salary Deposit</td>
                                                    <td class="text-success">+$3,500.00</td>
                                                    <td><span class="badge bg-success">Completed</span></td>
                                                </tr>
                                                <tr>
                                                    <td>2025-01-13</td>
                                                    <td>Online Purchase</td>
                                                    <td class="text-danger">-$125.50</td>
                                                    <td><span class="badge bg-success">Completed</span></td>
                                                </tr>
                                                <tr>
                                                    <td>2025-01-12</td>
                                                    <td>ATM Withdrawal</td>
                                                    <td class="text-danger">-$200.00</td>
                                                    <td><span class="badge bg-warning">Pending</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
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
                                            <button class="btn btn-primary btn-block w-100" onclick="quickTransfer()">
                                                <i class="fas fa-paper-plane"></i> Quick Transfer
                                            </button>
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
    
    <!-- Quick Transfer Modal -->
    <div class="modal fade" id="quickTransferModal" tabindex="-1" aria-labelledby="quickTransferModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="quickTransferModalLabel">Quick Transfer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group mb-3">
                            <label for="fromAccount">From Account:</label>
                            <select class="form-control" id="fromAccount">
                                <option>Checking - $2,842.50</option>
                                <option>Savings - $12,500.00</option>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="toAccount">To Account/Email:</label>
                            <input type="text" class="form-control" id="toAccount" placeholder="Enter account number or email">
                        </div>
                        <div class="form-group mb-3">
                            <label for="amount">Amount:</label>
                            <input type="number" class="form-control" id="amount" placeholder="0.00" step="0.01">
                        </div>
                        <div class="form-group mb-3">
                            <label for="description">Description:</label>
                            <input type="text" class="form-control" id="description" placeholder="Optional description">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="processTransfer()">Transfer</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    
    <style>
        /* Enhanced Header Styles */
        .topbar {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fc 100%);
            border-bottom: 1px solid #e3e6f0;
            height: 70px;
            padding: 0 1.5rem;
        }
        
        .navbar-search {
            max-width: 400px;
        }
        
        .navbar-search .form-control {
            border-radius: 10rem;
            background-color: #f8f9fc;
            border: 1px solid #e3e6f0;
            transition: all 0.3s ease;
            height: 40px;
        }
        
        .navbar-search .form-control:focus {
            background-color: #ffffff;
            border-color: #4e73df;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        
        .navbar-search .btn {
            border-radius: 0 10rem 10rem 0;
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            border: none;
            height: 40px;
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
        }
        
        .badge-counter {
            position: absolute;
            top: 5px;
            right: 5px;
            font-size: 0.65rem;
            border-radius: 50%;
            min-width: 16px;
            height: 16px;
            line-height: 16px;
            text-align: center;
            color: white;
            font-weight: bold;
        }
        
        .badge-danger {
            background-color: #e74a3b;
        }
        
        .badge-primary {
            background-color: #4e73df;
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
            .navbar-search {
                display: none !important;
            }
            
            .avatar-circle {
                width: 40px;
                height: 40px;
            }
            
            .topbar-divider {
                display: none !important;
            }
            
            .topbar {
                padding: 0 1rem;
                height: 60px;
            }
            
            .badge-counter {
                top: 3px;
                right: 3px;
                min-width: 14px;
                height: 14px;
                line-height: 14px;
                font-size: 0.6rem;
            }
        }
        
        @media (max-width: 576px) {
            .dropdown-menu {
                min-width: 250px;
            }
            
            .nav-link {
                padding: 0.5rem 0.75rem;
            }
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
        
        function quickTransfer() {
            new bootstrap.Modal(document.getElementById('quickTransferModal')).show();
        }
        
        function processTransfer() {
            // TODO: Implement backend transfer
            alert('Transfer initiated successfully!');
            bootstrap.Modal.getInstance(document.getElementById('quickTransferModal')).hide();
        }
        
        function payBills() {
            // TODO: Implement bill payment
            alert('Bill payment feature coming soon!');
        }
        
        function requestCard() {
            // TODO: Implement card request
            alert('Card request submitted successfully!');
        }
    </script>
</body>
</html>
