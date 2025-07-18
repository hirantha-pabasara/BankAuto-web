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
    <div class="d-flex">
        <!-- Sidebar -->
        <nav class="sidebar d-none d-lg-block position-fixed" style="width: 250px;">
            <div class="sidebar-header mb-4">
                <i class="fas fa-university me-2"></i>BankAuto Admin
            </div>
            <ul class="nav flex-column px-2">
                <li class="nav-item mb-2">
                    <a class="nav-link" href="../admin/dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                </li>
                <li class="nav-item mb-2">
                    <a class="nav-link" href="pendingAccounts.jsp"><i class="fas fa-user-clock me-2"></i>Pending Accounts</a>
                </li>
                <li class="nav-item mb-2">
                    <a class="nav-link active" href="approveAccount.jsp"><i class="fas fa-user-check me-2"></i>Approve Accounts</a>
                </li>
                <li class="nav-item mb-2">
                    <a class="nav-link" href="viewLogs.jsp"><i class="fas fa-list me-2"></i>View Logs</a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link" href="javascript:void(0)" onclick="performLogout()"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                </li>
            </ul>
        </nav>
        <!-- Main Content -->
        <div class="main-content flex-grow-1">
            <!-- Header -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm rounded mb-4">
                <div class="container-fluid">
                    <span class="navbar-brand mb-0 h1"><i class="fas fa-user-shield me-2"></i>Account Approval</span>
                    <button class="btn btn-outline-secondary d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas" aria-controls="sidebarOffcanvas">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="d-none d-lg-block">
                        <span class="me-3 text-muted">Admin</span>
                        <button class="btn btn-outline-danger btn-sm" onclick="performLogout()"><i class="fas fa-sign-out-alt"></i> Logout</button>
                    </div>
                </div>
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
