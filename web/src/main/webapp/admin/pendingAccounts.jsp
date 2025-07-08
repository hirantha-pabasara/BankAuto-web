<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Accounts - BankAuto Admin</title>
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
            
            <li class="nav-item active">
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
            
            <li class="nav-item">
                <a class="nav-link" href="viewLogs.jsp">
                    <i class="fas fa-fw fa-list"></i>
                    <span>View Logs</span>
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
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Admin</span>
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
                        <h1 class="h3 mb-0 text-gray-800">Pending Account Approvals</h1>
                    </div>
                    
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Pending Accounts</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Account ID</th>
                                            <th>Full Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Account Type</th>
                                            <th>Registration Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>ACC001</td>
                                            <td>John Doe</td>
                                            <td>john.doe@email.com</td>
                                            <td>+1 234 567 8901</td>
                                            <td>Savings</td>
                                            <td>2025-01-15</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-success me-1" onclick="approveAccount('ACC001')">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                                <button class="btn btn-sm btn-danger" onclick="rejectAccount('ACC001')">
                                                    <i class="fas fa-times"></i> Reject
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>ACC002</td>
                                            <td>Jane Smith</td>
                                            <td>jane.smith@email.com</td>
                                            <td>+1 234 567 8902</td>
                                            <td>Checking</td>
                                            <td>2025-01-14</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-success me-1" onclick="approveAccount('ACC002')">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                                <button class="btn btn-sm btn-danger" onclick="rejectAccount('ACC002')">
                                                    <i class="fas fa-times"></i> Reject
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>ACC003</td>
                                            <td>Mike Johnson</td>
                                            <td>mike.johnson@email.com</td>
                                            <td>+1 234 567 8903</td>
                                            <td>Business</td>
                                            <td>2025-01-13</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-success me-1" onclick="approveAccount('ACC003')">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                                <button class="btn btn-sm btn-danger" onclick="rejectAccount('ACC003')">
                                                    <i class="fas fa-times"></i> Reject
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Approve Modal -->
    <div class="modal fade" id="approveModal" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="approveModalLabel">Approve Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to approve this account?</p>
                    <p><strong>Account ID:</strong> <span id="approveAccountId"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-success" onclick="confirmApprove()">Approve Account</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="rejectModalLabel">Reject Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to reject this account?</p>
                    <p><strong>Account ID:</strong> <span id="rejectAccountId"></span></p>
                    <div class="form-group">
                        <label for="rejectReason">Reason for rejection:</label>
                        <textarea class="form-control" id="rejectReason" rows="3" placeholder="Enter reason..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="confirmReject()">Reject Account</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script>
        let currentAccountId = '';
        
        function approveAccount(accountId) {
            currentAccountId = accountId;
            document.getElementById('approveAccountId').textContent = accountId;
            new bootstrap.Modal(document.getElementById('approveModal')).show();
        }
        
        function rejectAccount(accountId) {
            currentAccountId = accountId;
            document.getElementById('rejectAccountId').textContent = accountId;
            new bootstrap.Modal(document.getElementById('rejectModal')).show();
        }
        
        function confirmApprove() {
            // TODO: Implement backend call to approve account
            alert('Account ' + currentAccountId + ' has been approved successfully!');
            bootstrap.Modal.getInstance(document.getElementById('approveModal')).hide();
            location.reload();
        }
        
        function confirmReject() {
            const reason = document.getElementById('rejectReason').value;
            if (!reason.trim()) {
                alert('Please provide a reason for rejection.');
                return;
            }
            
            // TODO: Implement backend call to reject account
            alert('Account ' + currentAccountId + ' has been rejected. Reason: ' + reason);
            bootstrap.Modal.getInstance(document.getElementById('rejectModal')).hide();
            location.reload();
        }
    </script>
</body>
</html>
