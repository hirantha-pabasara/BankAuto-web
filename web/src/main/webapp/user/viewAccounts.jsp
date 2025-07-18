<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Accounts - BankAuto</title>
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

        /* Enhanced Header Styles - Remove opacity */
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
        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion">
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="dashboard.jsp">
                <div class="sidebar-brand-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="sidebar-brand-text mx-3">BankAuto</div>
            </a>

            <hr class="sidebar-divider my-0">

            <li class="nav-item ">
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

            <li class="nav-item active">
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
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">John Doe</span>
                                <i class="fas fa-user-circle fa-fw"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
                                <a class="dropdown-item" href="../logout.jsp">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                
                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">My Accounts</h1>
                        <a href="createAccount.jsp" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                            <i class="fas fa-plus fa-sm text-white-50"></i> Create New Account
                        </a>
                    </div>
                    
                    <!-- Account Cards -->
                    <div class="row">
                        <!-- Savings Account -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Savings Account</div>
                                            <div class="text-xs text-gray-500 mb-1">Account #: ****-1234</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$12,500.00</div>
                                            <div class="text-xs text-gray-500">Available Balance</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-piggy-bank fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <small class="text-muted">Interest Rate: 2.5% APY</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Checking Account -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Checking Account</div>
                                            <div class="text-xs text-gray-500 mb-1">Account #: ****-5678</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$2,842.50</div>
                                            <div class="text-xs text-gray-500">Available Balance</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-credit-card fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <small class="text-muted">Monthly Fee: $0.00</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Business Account -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Business Account</div>
                                            <div class="text-xs text-gray-500 mb-1">Account #: ****-9012</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$8,750.25</div>
                                            <div class="text-xs text-gray-500">Available Balance</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-briefcase fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <small class="text-muted">Business Services Available</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Account Details Table -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Account Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Account Type</th>
                                            <th>Account Number</th>
                                            <th>Balance</th>
                                            <th>Status</th>
                                            <th>Last Activity</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <i class="fas fa-piggy-bank text-success"></i>
                                                Savings Account
                                            </td>
                                            <td>****-****-****-1234</td>
                                            <td>$12,500.00</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>2025-01-15 14:30</td>
                                            <td>
                                                <button class="btn btn-sm btn-primary" onclick="viewDetails('savings')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="transfer('savings')">
                                                    <i class="fas fa-paper-plane"></i>
                                                </button>
                                                <button class="btn btn-sm btn-info" onclick="statement('savings')">
                                                    <i class="fas fa-file-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <i class="fas fa-credit-card text-primary"></i>
                                                Checking Account
                                            </td>
                                            <td>****-****-****-5678</td>
                                            <td>$2,842.50</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>2025-01-15 12:15</td>
                                            <td>
                                                <button class="btn btn-sm btn-primary" onclick="viewDetails('checking')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="transfer('checking')">
                                                    <i class="fas fa-paper-plane"></i>
                                                </button>
                                                <button class="btn btn-sm btn-info" onclick="statement('checking')">
                                                    <i class="fas fa-file-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <i class="fas fa-briefcase text-info"></i>
                                                Business Account
                                            </td>
                                            <td>****-****-****-9012</td>
                                            <td>$8,750.25</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>2025-01-14 16:45</td>
                                            <td>
                                                <button class="btn btn-sm btn-primary" onclick="viewDetails('business')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="transfer('business')">
                                                    <i class="fas fa-paper-plane"></i>
                                                </button>
                                                <button class="btn btn-sm btn-info" onclick="statement('business')">
                                                    <i class="fas fa-file-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Account Services -->
                    <div class="row">
                        <div class="col-lg-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Account Services</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-6 mb-3">
                                            <button class="btn btn-outline-primary btn-block w-100" onclick="orderChecks()">
                                                <i class="fas fa-clipboard-check"></i><br>
                                                Order Checks
                                            </button>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <button class="btn btn-outline-success btn-block w-100" onclick="requestCard()">
                                                <i class="fas fa-credit-card"></i><br>
                                                Request Card
                                            </button>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <button class="btn btn-outline-info btn-block w-100" onclick="directDeposit()">
                                                <i class="fas fa-download"></i><br>
                                                Direct Deposit
                                            </button>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <button class="btn btn-outline-warning btn-block w-100" onclick="autoTransfer()">
                                                <i class="fas fa-sync-alt"></i><br>
                                                Auto Transfer
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Account Summary</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="text-center">
                                                <div class="h2 mb-0 text-gray-800">$24,092.75</div>
                                                <div class="text-sm text-gray-500">Total Balance</div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-center">
                                                <div class="h2 mb-0 text-gray-800">3</div>
                                                <div class="text-sm text-gray-500">Active Accounts</div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="text-center">
                                                <div class="h4 mb-0 text-success">+$3,500.00</div>
                                                <div class="text-sm text-gray-500">This Month</div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-center">
                                                <div class="h4 mb-0 text-info">$125.50</div>
                                                <div class="text-sm text-gray-500">Interest Earned</div>
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
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script src="../js/loadAccountData.js"></script>
</body>
</html>
