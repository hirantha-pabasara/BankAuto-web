<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - BankAuto</title>
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
    <div id="wrapper" class="d-flex">
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

            <li class="nav-item active">
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
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    
                    <!-- Sidebar Toggle (Desktop) -->
                    <button id="sidebarToggle" class="btn btn-link d-none d-md-inline-block mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
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
                                <i class="fas fa-user-circle fa-fw"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
                                <a class="dropdown-item" href="javascript:void(0)" onclick="performLogout()">
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
                        <h1 class="h3 mb-0 text-gray-800">Create New Bank Account</h1>
                    </div>
                    
                    <!-- Welcome Message -->
                    <div class="alert alert-info mb-4">
                        <h4 class="alert-heading">
                            <i class="fas fa-info-circle"></i> Welcome to BankAuto!
                        </h4>
                        <p>Now that you've created your user account, you can create your first bank account. Choose from our range of account types designed to meet your financial needs.</p>
                        <hr>
                        <p class="mb-0">
                            <strong>Note:</strong> Each account will require admin approval before becoming active. You'll receive a notification once your account is approved.
                        </p>
                    </div>
                    
                    <!-- Account Type Selection -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="card account-type-card" onclick="selectAccountType('savings')">
                                <div class="card-body text-center">
                                    <i class="fas fa-piggy-bank fa-3x text-success mb-3"></i>
                                    <h5 class="card-title">Savings Account</h5>
                                    <p class="card-text">Earn interest on your deposits with our competitive rates</p>
                                    <ul class="text-left">
                                        <li>2.5% Annual Interest Rate</li>
                                        <li>No Monthly Fees</li>
                                        <li>Minimum $100 Opening</li>
                                        <li>Online Banking</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card account-type-card" onclick="selectAccountType('checking')">
                                <div class="card-body text-center">
                                    <i class="fas fa-credit-card fa-3x text-primary mb-3"></i>
                                    <h5 class="card-title">Checking Account</h5>
                                    <p class="card-text">Perfect for everyday transactions and bill payments</p>
                                    <ul class="text-left">
                                        <li>Unlimited Transactions</li>
                                        <li>Free Debit Card</li>
                                        <li>No Minimum Balance</li>
                                        <li>Mobile Banking</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card account-type-card" onclick="selectAccountType('current')">
                                <div class="card-body text-center">
                                    <i class="fas fa-wallet fa-3x text-warning mb-3"></i>
                                    <h5 class="card-title">Current Account</h5>
                                    <p class="card-text">Ideal for frequent transactions and business needs</p>
                                    <ul class="text-left">
                                        <li>Overdraft Facility</li>
                                        <li>Cheque Book</li>
                                        <li>Minimum $200 Opening</li>
                                        <li>Online Banking</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card account-type-card" onclick="selectAccountType('fixed')">
                                <div class="card-body text-center">
                                    <i class="fas fa-lock fa-3x text-danger mb-3"></i>
                                    <h5 class="card-title">Fixed Deposit</h5>
                                    <p class="card-text">Grow your savings with higher interest rates</p>
                                    <ul class="text-left">
                                        <li>Up to 6% Annual Interest</li>
                                        <li>Flexible Tenure</li>
                                        <li>Minimum $1000 Opening</li>
                                        <li>Safe & Secure</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Progress Bar and Pending Review Message (hidden by default) -->
                    <div id="pendingReviewSection" style="display:none;">
                        <div class="alert alert-warning d-flex align-items-center" role="alert">
                            <i class="fas fa-hourglass-half fa-lg me-2"></i>
                            <div>
                                Please wait while our team reviews your account request. You will be notified once it is approved.
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold mb-1">Account Creation Progress</label>
                            <div class="progress" style="height: 1.5rem;">
                                <div class="progress-bar progress-bar-striped progress-bar-animated bg-info" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
                                    Step 2 of 2: Awaiting Review
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Account Creation Form -->
                    <div class="card shadow mb-4" id="accountForm" style="display: none;">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Account Details</h6>
                        </div>
                        <div class="card-body">
                            <form method="post" action="account-creation" enctype="multipart/form-data" id="createAccountForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="accountType">Account Type:</label>
                                            <input type="text" class="form-control" id="accountType" name="accountType" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="accountName">Account Name:</label>
                                            <input type="text" class="form-control" id="accountName" name="accountName" 
                                                   placeholder="Enter account name" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="initialDeposit">Initial Deposit ($):</label>
                                            <input type="number" class="form-control" id="initialDeposit" name="initialDeposit" 
                                                   placeholder="0.00" step="0.01" min="0" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="currency">Currency:</label>
                                            <select class="form-control" id="currency" name="currency">
                                                <option value="USD">USD - US Dollar</option>
                                                <option value="EUR">EUR - Euro</option>
                                                <option value="GBP">GBP - British Pound</option>
                                                <option value="CAD">CAD - Canadian Dollar</option>
                                                <option value="LKR">LKR - Sri Lankan Rupee</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="purpose">Purpose of Account:</label>
                                    <textarea class="form-control" id="purpose" name="purpose" rows="3" 
                                              placeholder="Please describe the intended use of this account"></textarea>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="documentUpload">Upload Supporting Document(s):</label>
                                    <input type="file" class="form-control" id="documentUpload" name="documentUpload" multiple required>
                                    <small class="form-text text-muted">Accepted formats: PDF, JPG, PNG. Max size: 5MB each.</small>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="paperlessStatements">
                                                <label class="custom-control-label" for="paperlessStatements">
                                                    Enroll in paperless statements
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="mobileAlerts">
                                                <label class="custom-control-label" for="mobileAlerts">
                                                    Enable mobile alerts
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="agreeTerms" name="agreeTerms" required>
                                        <label class="custom-control-label" for="agreeTerms">
                                            I agree to the <a href="#" class="text-primary">Account Terms and Conditions</a>
                                        </label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <button type="button" class="btn btn-secondary w-100" onclick="resetForm()">
                                            <i class="fas fa-times"></i> Cancel
                                        </button>
                                    </div>
                                    <div class="col-md-6">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-plus"></i> Create Account
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>&copy; 2025 BankAuto. All rights reserved.</span>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script src="../js/account-creation.js"></script>
    <script>
        let selectedAccountType = '';
        
        // Initialize sidebar toggle functionality
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
        
        function selectAccountType(type) {
            selectedAccountType = type;
            
            // Remove active class from all cards
            document.querySelectorAll('.account-type-card').forEach(card => {
                card.classList.remove('border-primary');
            });
            
            // Add active class to selected card
            event.currentTarget.classList.add('border-primary');
            
            // Show form
            document.getElementById('accountForm').style.display = 'block';
            
            // Set account type in form
            const typeNames = {
                'savings': 'Savings Account',
                'checking': 'Checking Account',
                'current': 'Current Account',
                'fixed': 'Fixed Deposit'
            };
            
            document.getElementById('accountType').value = typeNames[type];
            
            // Set minimum deposit based on account type
            const minDeposits = {
                'savings': 100,
                'checking': 0,
                'current': 200,
                'fixed': 1000
            };
            
            document.getElementById('initialDeposit').min = minDeposits[type];
            document.getElementById('initialDeposit').placeholder = `Minimum $${minDeposits[type]}`;
            
            // Scroll to form
            document.getElementById('accountForm').scrollIntoView({ behavior: 'smooth' });
        }
        
        function resetForm() {
            document.getElementById('accountForm').style.display = 'none';
            document.querySelectorAll('.account-type-card').forEach(card => {
                card.classList.remove('border-primary');
            });
            selectedAccountType = '';
        }
        
        // Show pending review section after form submission
        document.getElementById('createAccountForm').addEventListener('submit', handleAccountCreation);
    </script>
    
    <style>
        /* Additional layout fixes */
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        #wrapper {
            min-height: 100vh;
        }
        
        .topbar {
            border-bottom: 1px solid #e3e6f0;
        }
        
        .sticky-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #e3e6f0;
        }
        
        /* Account type card styling */
        .account-type-card {
            cursor: pointer;
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .account-type-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .account-type-card.border-primary {
            border-color: #007bff !important;
            border-width: 2px !important;
        }
        
        .account-type-card ul {
            list-style: none;
            padding-left: 0;
        }
        
        .account-type-card li {
            padding: 2px 0;
            font-size: 0.9rem;
        }
        
        .account-type-card li:before {
            content: "✓ ";
            color: #28a745;
            font-weight: bold;
        }
        
        /* Mobile sidebar overlay */
        @media (max-width: 576px) {
            .sidebar.show::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: -1;
            }
        }
    </style>
    
    <script>
        // Logout function
        function performLogout() {
            if (confirm('Are you sure you want to logout?')) {
                // Show loading indicator
                const logoutBtns = document.querySelectorAll('a[onclick="performLogout()"]');
                logoutBtns.forEach(btn => {
                    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>Logging out...</span>';
                    btn.style.pointerEvents = 'none';
                });

                // Create a form and submit it to the servlet
                const form = document.createElement('form');
                form.method = 'GET';
                form.action = '../user/logout';
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
