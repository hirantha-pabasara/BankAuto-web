<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - BankAuto</title>
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
            
            <li class="nav-item">
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
            
            <li class="nav-item active">
                <a class="nav-link" href="notifications.jsp">
                    <i class="fas fa-fw fa-bell"></i>
                    <span>Notifications</span>
                    <span class="badge bg-danger ms-2">3</span>
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
                        <h1 class="h3 mb-0 text-gray-800">Notifications</h1>
                        <div>
                            <button class="btn btn-primary btn-sm" onclick="markAllAsRead()">
                                <i class="fas fa-check-double"></i> Mark All as Read
                            </button>
                            <button class="btn btn-outline-secondary btn-sm" onclick="clearAll()">
                                <i class="fas fa-trash"></i> Clear All
                            </button>
                        </div>
                    </div>
                    
                    <!-- Notification Categories -->
                    <div class="row mb-4">
                        <div class="col-md-12">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-primary active" onclick="filterNotifications('all')">
                                    All <span class="badge bg-light text-dark ms-1">8</span>
                                </button>
                                <button type="button" class="btn btn-outline-primary" onclick="filterNotifications('unread')">
                                    Unread <span class="badge bg-danger ms-1">3</span>
                                </button>
                                <button type="button" class="btn btn-outline-primary" onclick="filterNotifications('transactions')">
                                    Transactions <span class="badge bg-success ms-1">4</span>
                                </button>
                                <button type="button" class="btn btn-outline-primary" onclick="filterNotifications('alerts')">
                                    Alerts <span class="badge bg-warning ms-1">2</span>
                                </button>
                                <button type="button" class="btn btn-outline-primary" onclick="filterNotifications('system')">
                                    System <span class="badge bg-info ms-1">2</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Notifications List -->
                    <div class="row">
                        <div class="col-lg-12">
                            
                            <!-- Unread Notifications -->
                            <div class="card shadow mb-4 notification-card unread" data-type="transactions">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-exclamation-circle fa-2x text-danger"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-danger mb-1">Transaction Alert</h6>
                                            <p class="mb-1">ATM withdrawal of $200.00 is pending approval</p>
                                            <small class="text-muted">2 hours ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-primary" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card shadow mb-4 notification-card unread" data-type="alerts">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-shield-alt fa-2x text-warning"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-warning mb-1">Security Alert</h6>
                                            <p class="mb-1">New login detected from unusual location</p>
                                            <small class="text-muted">5 hours ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-primary" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card shadow mb-4 notification-card unread" data-type="system">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-bell fa-2x text-info"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-info mb-1">System Update</h6>
                                            <p class="mb-1">New features are now available in your dashboard</p>
                                            <small class="text-muted">1 day ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-primary" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Read Notifications -->
                            <div class="card shadow mb-4 notification-card read" data-type="transactions">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-check-circle fa-2x text-success"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-success mb-1">Transaction Completed</h6>
                                            <p class="mb-1">Your salary of $3,500.00 has been deposited</p>
                                            <small class="text-muted">1 day ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card shadow mb-4 notification-card read" data-type="transactions">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-exchange-alt fa-2x text-primary"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-primary mb-1">Transfer Completed</h6>
                                            <p class="mb-1">$500.00 transferred to John Smith successfully</p>
                                            <small class="text-muted">2 days ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card shadow mb-4 notification-card read" data-type="transactions">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-credit-card fa-2x text-info"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-info mb-1">Payment Processed</h6>
                                            <p class="mb-1">Amazon purchase of $125.50 has been processed</p>
                                            <small class="text-muted">3 days ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card shadow mb-4 notification-card read" data-type="system">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-file-alt fa-2x text-secondary"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-secondary mb-1">Statement Ready</h6>
                                            <p class="mb-1">Your monthly statement is ready for download</p>
                                            <small class="text-muted">1 week ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-primary" onclick="downloadStatement()">
                                                <i class="fas fa-download"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card shadow mb-4 notification-card read" data-type="alerts">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <i class="fas fa-percent fa-2x text-success"></i>
                                        </div>
                                        <div class="col-md-9">
                                            <h6 class="text-success mb-1">Interest Added</h6>
                                            <p class="mb-1">$25.50 interest added to your savings account</p>
                                            <small class="text-muted">1 week ago</small>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    
                    <!-- Notification Settings -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Notification Settings</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Email Notifications</h6>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="emailTransactions" checked>
                                        <label class="form-check-label" for="emailTransactions">
                                            Transaction alerts
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="emailSecurity" checked>
                                        <label class="form-check-label" for="emailSecurity">
                                            Security alerts
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="emailStatements">
                                        <label class="form-check-label" for="emailStatements">
                                            Monthly statements
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <h6>SMS Notifications</h6>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="smsTransactions" checked>
                                        <label class="form-check-label" for="smsTransactions">
                                            Transaction alerts
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="smsSecurity" checked>
                                        <label class="form-check-label" for="smsSecurity">
                                            Security alerts
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="smsLowBalance">
                                        <label class="form-check-label" for="smsLowBalance">
                                            Low balance alerts
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3">
                                <button class="btn btn-primary" onclick="saveNotificationSettings()">
                                    <i class="fas fa-save"></i> Save Settings
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script>
        function filterNotifications(type) {
            const cards = document.querySelectorAll('.notification-card');
            const buttons = document.querySelectorAll('.btn-group .btn');
            
            // Update active button
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // Filter notifications
            cards.forEach(card => {
                if (type === 'all') {
                    card.style.display = 'block';
                } else if (type === 'unread') {
                    card.style.display = card.classList.contains('unread') ? 'block' : 'none';
                } else {
                    card.style.display = card.getAttribute('data-type') === type ? 'block' : 'none';
                }
            });
        }
        
        function markAsRead(button) {
            const card = button.closest('.notification-card');
            card.classList.remove('unread');
            card.classList.add('read');
            
            // Remove mark as read button
            button.remove();
            
            // Update badge counts
            updateBadgeCounts();
        }
        
        function markAllAsRead() {
            const unreadCards = document.querySelectorAll('.notification-card.unread');
            unreadCards.forEach(card => {
                card.classList.remove('unread');
                card.classList.add('read');
                
                // Remove mark as read button
                const button = card.querySelector('.btn-outline-primary');
                if (button) button.remove();
            });
            
            updateBadgeCounts();
            alert('All notifications marked as read!');
        }
        
        function deleteNotification(button) {
            const card = button.closest('.notification-card');
            card.remove();
            updateBadgeCounts();
        }
        
        function clearAll() {
            if (confirm('Are you sure you want to clear all notifications?')) {
                const cards = document.querySelectorAll('.notification-card');
                cards.forEach(card => card.remove());
                updateBadgeCounts();
            }
        }
        
        function updateBadgeCounts() {
            const allCards = document.querySelectorAll('.notification-card');
            const unreadCards = document.querySelectorAll('.notification-card.unread');
            const transactionCards = document.querySelectorAll('.notification-card[data-type="transactions"]');
            const alertCards = document.querySelectorAll('.notification-card[data-type="alerts"]');
            const systemCards = document.querySelectorAll('.notification-card[data-type="system"]');
            
            // Update sidebar badge
            const sidebarBadge = document.querySelector('.sidebar .badge');
            if (sidebarBadge) {
                sidebarBadge.textContent = unreadCards.length;
                sidebarBadge.style.display = unreadCards.length > 0 ? 'inline' : 'none';
            }
            
            // Update filter badges
            const badges = document.querySelectorAll('.btn-group .badge');
            if (badges.length >= 5) {
                badges[0].textContent = allCards.length;
                badges[1].textContent = unreadCards.length;
                badges[2].textContent = transactionCards.length;
                badges[3].textContent = alertCards.length;
                badges[4].textContent = systemCards.length;
            }
        }
        
        function downloadStatement() {
            // TODO: Implement statement download
            alert('Statement download started!');
        }
        
        function saveNotificationSettings() {
            // TODO: Implement settings save
            alert('Notification settings saved successfully!');
        }
    </script>
    
    <style>
        .notification-card.unread {
            border-left: 4px solid #007bff;
            background-color: #f8f9fa;
        }
        
        .notification-card.read {
            opacity: 0.8;
        }
        
        .notification-card:hover {
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
    </style>
</body>
</html>
