<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Logs - BankAuto Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/admin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body id="page-top">
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion">
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="dashboard.jsp">
                <div class="sidebar-brand-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="sidebar-brand-text mx-3">BankAuto Admin</div>
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
                <a class="nav-link" href="pendingAccounts.jsp">
                    <i class="fas fa-fw fa-user-clock"></i>
                    <span>Pending Accounts</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="approveAccount.jsp">
                    <i class="fas fa-fw fa-user-check"></i>
                    <span>Approve Accounts</span>
                </a>
            </li>
            
            <li class="nav-item active">
                <a class="nav-link" href="viewLogs.jsp">
                    <i class="fas fa-fw fa-list"></i>
                    <span>View Logs</span>
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
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Admin</span>
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
                        <h1 class="h3 mb-0 text-gray-800">System Logs</h1>
                        <button class="btn btn-primary" onclick="refreshLogs()">
                            <i class="fas fa-sync-alt"></i> Refresh Logs
                        </button>
                    </div>
                    
                    <!-- Filter Section -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Filter Logs</h6>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="logType">Log Type:</label>
                                            <select class="form-control" id="logType">
                                                <option value="all">All Types</option>
                                                <option value="login">Login</option>
                                                <option value="transaction">Transaction</option>
                                                <option value="account">Account</option>
                                                <option value="error">Error</option>
                                                <option value="system">System</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="logLevel">Log Level:</label>
                                            <select class="form-control" id="logLevel">
                                                <option value="all">All Levels</option>
                                                <option value="info">Info</option>
                                                <option value="warning">Warning</option>
                                                <option value="error">Error</option>
                                                <option value="critical">Critical</option>
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
                                    <i class="fas fa-times"></i> Clear Filters
                                </button>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Logs Table -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">System Activity Logs</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="logsTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Timestamp</th>
                                            <th>Log Type</th>
                                            <th>Level</th>
                                            <th>User/Account</th>
                                            <th>Action</th>
                                            <th>Details</th>
                                            <th>IP Address</th>
                                        </tr>
                                    </thead>
                                    <tbody id="logsTableBody">
                                        <tr>
                                            <td>2025-01-15 14:30:25</td>
                                            <td><span class="badge bg-primary">Login</span></td>
                                            <td><span class="badge bg-info">Info</span></td>
                                            <td>john.doe@email.com</td>
                                            <td>User Login</td>
                                            <td>Successful login to user dashboard</td>
                                            <td>192.168.1.100</td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-15 14:25:10</td>
                                            <td><span class="badge bg-success">Transaction</span></td>
                                            <td><span class="badge bg-info">Info</span></td>
                                            <td>ACC001</td>
                                            <td>Fund Transfer</td>
                                            <td>$500.00 transferred to ACC002</td>
                                            <td>192.168.1.100</td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-15 14:20:15</td>
                                            <td><span class="badge bg-warning">Account</span></td>
                                            <td><span class="badge bg-warning">Warning</span></td>
                                            <td>ACC003</td>
                                            <td>Account Creation</td>
                                            <td>New account pending approval</td>
                                            <td>192.168.1.150</td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-15 14:15:30</td>
                                            <td><span class="badge bg-danger">Error</span></td>
                                            <td><span class="badge bg-danger">Error</span></td>
                                            <td>System</td>
                                            <td>Database Connection</td>
                                            <td>Failed to connect to database - retrying</td>
                                            <td>localhost</td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-15 14:10:45</td>
                                            <td><span class="badge bg-secondary">System</span></td>
                                            <td><span class="badge bg-info">Info</span></td>
                                            <td>Admin</td>
                                            <td>System Backup</td>
                                            <td>Daily backup completed successfully</td>
                                            <td>localhost</td>
                                        </tr>
                                        <tr>
                                            <td>2025-01-15 14:05:20</td>
                                            <td><span class="badge bg-primary">Login</span></td>
                                            <td><span class="badge bg-warning">Warning</span></td>
                                            <td>unknown</td>
                                            <td>Failed Login</td>
                                            <td>Multiple failed login attempts detected</td>
                                            <td>192.168.1.200</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Pagination -->
                            <nav aria-label="Logs pagination">
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
                    
                    <!-- Statistics Cards -->
                    <div class="row">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Logs Today</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">2,547</div>
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
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Warnings</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">12</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
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
                                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Errors</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">3</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-times-circle fa-2x text-gray-300"></i>
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
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Successful Actions</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">2,532</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-check-circle fa-2x text-gray-300"></i>
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
    <script>
        function refreshLogs() {
            // TODO: Implement backend call to refresh logs
            alert('Logs refreshed successfully!');
            location.reload();
        }
        
        function applyFilters() {
            const logType = document.getElementById('logType').value;
            const logLevel = document.getElementById('logLevel').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            // TODO: Implement backend filtering
            alert('Filters applied: ' + logType + ', ' + logLevel + ', ' + startDate + ' to ' + endDate);
            // For now, just refresh the table
            location.reload();
        }
        
        function clearFilters() {
            document.getElementById('logType').value = 'all';
            document.getElementById('logLevel').value = 'all';
            document.getElementById('startDate').value = '';
            document.getElementById('endDate').value = '';
            
            // TODO: Implement backend filter clearing
            alert('Filters cleared!');
            location.reload();
        }
        
        // Auto-refresh logs every 30 seconds
        setInterval(function() {
            // TODO: Implement silent refresh without page reload
            console.log('Auto-refreshing logs...');
        }, 30000);

        // Logout function for admin
        function performLogout() {
            if (confirm('Are you sure you want to logout?')) {
                // Show loading indicator
                const logoutBtns = document.querySelectorAll('a[onclick="performLogout()"]');
                logoutBtns.forEach(btn => {
                    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>Logging out...</span>';
                    btn.style.pointerEvents = 'none';
                });

                // Create a form and submit it to the servlet with admin parameter
                const form = document.createElement('form');
                form.method = 'GET';
                form.action = '../user/logout';
                
                // Add a parameter to indicate this is an admin logout
                const adminParam = document.createElement('input');
                adminParam.type = 'hidden';
                adminParam.name = 'admin';
                adminParam.value = 'true';
                form.appendChild(adminParam);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
