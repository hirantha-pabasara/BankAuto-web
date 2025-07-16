<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Approve Account - BankAuto Admin</title>
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
            
            <li class="nav-item active">
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
                        <h1 class="h3 mb-0 text-gray-800">Account Approval</h1>
                    </div>
                    
                    <!-- Search Section -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Search Account</h6>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="searchType">Search By:</label>
                                            <select class="form-control" id="searchType">
                                                <option value="accountId">Account ID</option>
                                                <option value="email">Email</option>
                                                <option value="phone">Phone Number</option>
                                                <option value="name">Full Name</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="searchValue">Search Value:</label>
                                            <input type="text" class="form-control" id="searchValue" placeholder="Enter search value...">
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary" onclick="searchAccount()">
                                    <i class="fas fa-search"></i> Search
                                </button>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Account Details Section -->
                    <div class="card shadow mb-4" id="accountDetailsCard" style="display: none;">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Account Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Personal Information</h5>
                                    <table class="table table-borderless">
                                        <tr>
                                            <td><strong>Account ID:</strong></td>
                                            <td id="accountId">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Full Name:</strong></td>
                                            <td id="fullName">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Email:</strong></td>
                                            <td id="email">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Phone:</strong></td>
                                            <td id="phone">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Date of Birth:</strong></td>
                                            <td id="dob">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Address:</strong></td>
                                            <td id="address">-</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h5>Account Information</h5>
                                    <table class="table table-borderless">
                                        <tr>
                                            <td><strong>Account Type:</strong></td>
                                            <td id="accountType">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Registration Date:</strong></td>
                                            <td id="registrationDate">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Current Status:</strong></td>
                                            <td id="currentStatus">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Initial Deposit:</strong></td>
                                            <td id="initialDeposit">-</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Identity Verification:</strong></td>
                                            <td id="identityVerification">-</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            
                            <hr>
                            
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Actions</h5>
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-success" onclick="approveAccount()">
                                            <i class="fas fa-check"></i> Approve Account
                                        </button>
                                        <button type="button" class="btn btn-danger" onclick="rejectAccount()">
                                            <i class="fas fa-times"></i> Reject Account
                                        </button>
                                        <button type="button" class="btn btn-warning" onclick="requestMoreInfo()">
                                            <i class="fas fa-info-circle"></i> Request More Info
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Comments Section -->
                    <div class="card shadow mb-4" id="commentsCard" style="display: none;">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Add Comments</h6>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="adminComments">Admin Comments:</label>
                                <textarea class="form-control" id="adminComments" rows="4" placeholder="Enter your comments about this account..."></textarea>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="saveComments()">
                                <i class="fas fa-save"></i> Save Comments
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script>
        function searchAccount() {
            const searchType = document.getElementById('searchType').value;
            const searchValue = document.getElementById('searchValue').value;
            
            if (!searchValue.trim()) {
                alert('Please enter a search value.');
                return;
            }
            
            // TODO: Implement backend search
            // For now, showing sample data
            showSampleAccountDetails();
        }
        
        function showSampleAccountDetails() {
            // Sample data - replace with actual backend call
            document.getElementById('accountId').textContent = 'ACC001';
            document.getElementById('fullName').textContent = 'John Doe';
            document.getElementById('email').textContent = 'john.doe@email.com';
            document.getElementById('phone').textContent = '+1 234 567 8901';
            document.getElementById('dob').textContent = '1990-05-15';
            document.getElementById('address').textContent = '123 Main St, City, State 12345';
            document.getElementById('accountType').textContent = 'Savings';
            document.getElementById('registrationDate').textContent = '2025-01-15';
            document.getElementById('currentStatus').innerHTML = '<span class="badge bg-warning">Pending</span>';
            document.getElementById('initialDeposit').textContent = '$500.00';
            document.getElementById('identityVerification').innerHTML = '<span class="badge bg-success">Verified</span>';
            
            document.getElementById('accountDetailsCard').style.display = 'block';
            document.getElementById('commentsCard').style.display = 'block';
        }
        
        function approveAccount() {
            if (confirm('Are you sure you want to approve this account?')) {
                // TODO: Implement backend approval
                alert('Account has been approved successfully!');
                // Refresh or redirect
                location.reload();
            }
        }
        
        function rejectAccount() {
            const reason = prompt('Please provide a reason for rejection:');
            if (reason && reason.trim()) {
                // TODO: Implement backend rejection
                alert('Account has been rejected. Reason: ' + reason);
                // Refresh or redirect
                location.reload();
            }
        }
        
        function requestMoreInfo() {
            const info = prompt('What additional information is required?');
            if (info && info.trim()) {
                // TODO: Implement backend request for more info
                alert('Request for additional information has been sent to the customer.');
                // Refresh or redirect
                location.reload();
            }
        }
        
        function saveComments() {
            const comments = document.getElementById('adminComments').value;
            if (!comments.trim()) {
                alert('Please enter some comments.');
                return;
            }
            
            // TODO: Implement backend save comments
            alert('Comments saved successfully!');
            document.getElementById('adminComments').value = '';
        }

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
