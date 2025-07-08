<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions - BankAuto</title>
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
            
            <li class="nav-item active">
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
                        <h1 class="h3 mb-0 text-gray-800">Transactions</h1>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#transferModal">
                            <i class="fas fa-paper-plane"></i> New Transfer
                        </button>
                    </div>
                    
                    <!-- Filter Section -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Filter Transactions</h6>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="accountFilter">Account:</label>
                                            <select class="form-control" id="accountFilter">
                                                <option value="all">All Accounts</option>
                                                <option value="savings">Savings - ****1234</option>
                                                <option value="checking">Checking - ****5678</option>
                                                <option value="business">Business - ****9012</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="transactionType">Type:</label>
                                            <select class="form-control" id="transactionType">
                                                <option value="all">All Types</option>
                                                <option value="deposit">Deposit</option>
                                                <option value="withdrawal">Withdrawal</option>
                                                <option value="transfer">Transfer</option>
                                                <option value="payment">Payment</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="startDate">Start Date:</label>
                                            <input type="date" class="form-control" id="startDate">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="endDate">End Date:</label>
                                            <input type="date" class="form-control" id="endDate">
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary" onclick="applyFilters()">
                                    <i class="fas fa-filter"></i> Apply Filters
                                </button>
                                <button type="button" class="btn btn-secondary" onclick="clearFilters()">
                                    <i class="fas fa-times"></i> Clear
                                </button>
                                <button type="button" class="btn btn-success" onclick="exportTransactions()">
                                    <i class="fas fa-download"></i> Export
                                </button>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Transactions Table -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Transaction History</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="transactionsTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Description</th>
                                            <th>Account</th>
                                            <th>Type</th>
                                            <th>Amount</th>
                                            <th>Balance</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>2025-01-15 14:30</td>
                                            <td>Transfer to John Smith</td>
                                            <td>Checking ****5678</td>
                                            <td><span class="badge bg-warning">Transfer</span></td>
                                            <td class="text-danger">-$500.00</td>
                                            <td>$2,342.50</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewDetails('TXN001')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-14 09:15</td>
                                            <td>Salary Deposit - ABC Company</td>
                                            <td>Checking ****5678</td>
                                            <td><span class="badge bg-success">Deposit</span></td>
                                            <td class="text-success">+$3,500.00</td>
                                            <td>$2,842.50</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewDetails('TXN002')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-13 16:45</td>
                                            <td>Online Purchase - Amazon</td>
                                            <td>Checking ****5678</td>
                                            <td><span class="badge bg-primary">Payment</span></td>
                                            <td class="text-danger">-$125.50</td>
                                            <td>$5,842.50</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewDetails('TXN003')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-12 11:30</td>
                                            <td>ATM Withdrawal</td>
                                            <td>Checking ****5678</td>
                                            <td><span class="badge bg-danger">Withdrawal</span></td>
                                            <td class="text-danger">-$200.00</td>
                                            <td>$5,968.00</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewDetails('TXN004')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-11 13:22</td>
                                            <td>Interest Payment</td>
                                            <td>Savings ****1234</td>
                                            <td><span class="badge bg-info">Interest</span></td>
                                            <td class="text-success">+$25.50</td>
                                            <td>$12,500.00</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewDetails('TXN005')">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Pagination -->
                            <nav aria-label="Transaction pagination">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1">Previous</a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    
                    <!-- Transaction Summary -->
                    <div class="row">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Income</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$3,525.50</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-arrow-up fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-danger shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Total Expenses</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$825.50</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-arrow-down fa-2x text-gray-300"></i>
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
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Transactions</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">47</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-list fa-2x text-gray-300"></i>
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
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending</div>
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
                </div>
            </div>
        </div>
    </div>
    
    <!-- Transfer Modal -->
    <div class="modal fade" id="transferModal" tabindex="-1" aria-labelledby="transferModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="transferModalLabel">New Transfer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group mb-3">
                            <label for="fromAccount">From Account:</label>
                            <select class="form-control" id="fromAccount">
                                <option>Checking - $2,842.50</option>
                                <option>Savings - $12,500.00</option>
                                <option>Business - $8,750.25</option>
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
                        <div class="form-group mb-3">
                            <label for="transferType">Transfer Type:</label>
                            <select class="form-control" id="transferType">
                                <option value="immediate">Immediate</option>
                                <option value="scheduled">Scheduled</option>
                                <option value="recurring">Recurring</option>
                            </select>
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
        function applyFilters() {
            // TODO: Implement filter functionality
            alert('Filters applied successfully!');
        }
        
        function clearFilters() {
            document.getElementById('accountFilter').value = 'all';
            document.getElementById('transactionType').value = 'all';
            document.getElementById('startDate').value = '';
            document.getElementById('endDate').value = '';
            alert('Filters cleared!');
        }
        
        function exportTransactions() {
            // TODO: Implement export functionality
            alert('Transactions exported successfully!');
        }
        
        function viewDetails(transactionId) {
            // TODO: Implement transaction details view
            alert('Viewing details for transaction: ' + transactionId);
        }
        
        function processTransfer() {
            // TODO: Implement transfer processing
            alert('Transfer processed successfully!');
            bootstrap.Modal.getInstance(document.getElementById('transferModal')).hide();
        }
    </script>
</body>
</html>
