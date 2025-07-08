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
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <div class="dropdown-divider"></div>
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
    <script>
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
