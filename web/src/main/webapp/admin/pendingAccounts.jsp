<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Pending Accounts - BankAuto Admin</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="../css/admin.css" rel="stylesheet">--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body id="page-top">--%>
<%--    <div id="wrapper">--%>
<%--        <!-- Sidebar -->--%>
<%--        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion">--%>
<%--            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="dashboard.jsp">--%>
<%--                <div class="sidebar-brand-icon">--%>
<%--                    <i class="fas fa-university"></i>--%>
<%--                </div>--%>
<%--                <div class="sidebar-brand-text mx-3">BankAuto Admin</div>--%>
<%--            </a>--%>
<%--            --%>
<%--            <hr class="sidebar-divider my-0">--%>
<%--            --%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="dashboard.jsp">--%>
<%--                    <i class="fas fa-fw fa-tachometer-alt"></i>--%>
<%--                    <span>Dashboard</span>--%>
<%--                </a>--%>
<%--            </li>--%>
<%--            --%>
<%--            <hr class="sidebar-divider">--%>
<%--            --%>
<%--            <li class="nav-item active">--%>
<%--                <a class="nav-link" href="pendingAccounts.jsp">--%>
<%--                    <i class="fas fa-fw fa-user-clock"></i>--%>
<%--                    <span>Pending Accounts</span>--%>
<%--                </a>--%>
<%--            </li>--%>
<%--            --%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="approveAccount.jsp">--%>
<%--                    <i class="fas fa-fw fa-user-check"></i>--%>
<%--                    <span>Approve Accounts</span>--%>
<%--                </a>--%>
<%--            </li>--%>
<%--            --%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="viewLogs.jsp">--%>
<%--                    <i class="fas fa-fw fa-list"></i>--%>
<%--                    <span>View Logs</span>--%>
<%--                </a>--%>
<%--            </li>--%>
<%--            --%>
<%--            <hr class="sidebar-divider">--%>
<%--            --%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="javascript:void(0)" onclick="performLogout()">--%>
<%--                    <i class="fas fa-fw fa-sign-out-alt"></i>--%>
<%--                    <span>Logout</span>--%>
<%--                </a>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--        --%>
<%--        <!-- Content Wrapper -->--%>
<%--        <div id="content-wrapper" class="d-flex flex-column">--%>
<%--            <div id="content">--%>
<%--                <!-- Topbar -->--%>
<%--                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">--%>
<%--                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">--%>
<%--                        <i class="fa fa-bars"></i>--%>
<%--                    </button>--%>
<%--                    --%>
<%--                    <ul class="navbar-nav ml-auto">--%>
<%--                        <li class="nav-item dropdown no-arrow">--%>
<%--                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">--%>
<%--                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Admin</span>--%>
<%--                                <i class="fas fa-user-circle fa-fw"></i>--%>
<%--                            </a>--%>
<%--                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">--%>
<%--                                <a class="dropdown-item" href="javascript:void(0)" onclick="performLogout()">--%>
<%--                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>--%>
<%--                                    Logout--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </nav>--%>
<%--                --%>
<%--                <!-- Begin Page Content -->--%>
<%--                <div class="container-fluid">--%>
<%--                    <div class="d-sm-flex align-items-center justify-content-between mb-4">--%>
<%--                        <h1 class="h3 mb-0 text-gray-800">Pending Account Approvals</h1>--%>
<%--                    </div>--%>
<%--                    --%>
<%--                    <!-- DataTales Example -->--%>
<%--                    <div class="card shadow mb-4">--%>
<%--                        <div class="card-header py-3">--%>
<%--                            <h6 class="m-0 font-weight-bold text-primary">Pending Accounts</h6>--%>
<%--                        </div>--%>
<%--                        <div class="card-body">--%>
<%--                            <div class="table-responsive">--%>
<%--                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">--%>
<%--                                    <thead>--%>
<%--                                        <tr>--%>
<%--                                            <th>Account ID</th>--%>
<%--                                            <th>Full Name</th>--%>
<%--                                            <th>Email</th>--%>
<%--                                            <th>Phone</th>--%>
<%--                                            <th>Account Type</th>--%>
<%--                                            <th>Registration Date</th>--%>
<%--                                            <th>Status</th>--%>
<%--                                            <th>Actions</th>--%>
<%--                                        </tr>--%>
<%--                                    </thead>--%>
<%--                                    <tbody>--%>
<%--                                        <tr>--%>
<%--                                            <td>ACC001</td>--%>
<%--                                            <td>John Doe</td>--%>
<%--                                            <td>john.doe@email.com</td>--%>
<%--                                            <td>+1 234 567 8901</td>--%>
<%--                                            <td>Savings</td>--%>
<%--                                            <td>2025-01-15</td>--%>
<%--                                            <td><span class="badge bg-warning">Pending</span></td>--%>
<%--                                            <td>--%>
<%--                                                <button class="btn btn-sm btn-success me-1" onclick="approveAccount('ACC001')">--%>
<%--                                                    <i class="fas fa-check"></i> Approve--%>
<%--                                                </button>--%>
<%--                                                <button class="btn btn-sm btn-danger" onclick="rejectAccount('ACC001')">--%>
<%--                                                    <i class="fas fa-times"></i> Reject--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                        <tr>--%>
<%--                                            <td>ACC002</td>--%>
<%--                                            <td>Jane Smith</td>--%>
<%--                                            <td>jane.smith@email.com</td>--%>
<%--                                            <td>+1 234 567 8902</td>--%>
<%--                                            <td>Checking</td>--%>
<%--                                            <td>2025-01-14</td>--%>
<%--                                            <td><span class="badge bg-warning">Pending</span></td>--%>
<%--                                            <td>--%>
<%--                                                <button class="btn btn-sm btn-success me-1" onclick="approveAccount('ACC002')">--%>
<%--                                                    <i class="fas fa-check"></i> Approve--%>
<%--                                                </button>--%>
<%--                                                <button class="btn btn-sm btn-danger" onclick="rejectAccount('ACC002')">--%>
<%--                                                    <i class="fas fa-times"></i> Reject--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                        <tr>--%>
<%--                                            <td>ACC003</td>--%>
<%--                                            <td>Mike Johnson</td>--%>
<%--                                            <td>mike.johnson@email.com</td>--%>
<%--                                            <td>+1 234 567 8903</td>--%>
<%--                                            <td>Business</td>--%>
<%--                                            <td>2025-01-13</td>--%>
<%--                                            <td><span class="badge bg-warning">Pending</span></td>--%>
<%--                                            <td>--%>
<%--                                                <button class="btn btn-sm btn-success me-1" onclick="approveAccount('ACC003')">--%>
<%--                                                    <i class="fas fa-check"></i> Approve--%>
<%--                                                </button>--%>
<%--                                                <button class="btn btn-sm btn-danger" onclick="rejectAccount('ACC003')">--%>
<%--                                                    <i class="fas fa-times"></i> Reject--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                    </tbody>--%>
<%--                                </table>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    --%>
<%--    <!-- Approve Modal -->--%>
<%--    <div class="modal fade" id="approveModal" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true">--%>
<%--        <div class="modal-dialog">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <h5 class="modal-title" id="approveModalLabel">Approve Account</h5>--%>
<%--                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                </div>--%>
<%--                <div class="modal-body">--%>
<%--                    <p>Are you sure you want to approve this account?</p>--%>
<%--                    <p><strong>Account ID:</strong> <span id="approveAccountId"></span></p>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>--%>
<%--                    <button type="button" class="btn btn-success" onclick="confirmApprove()">Approve Account</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    --%>
<%--    <!-- Reject Modal -->--%>
<%--    <div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">--%>
<%--        <div class="modal-dialog">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <h5 class="modal-title" id="rejectModalLabel">Reject Account</h5>--%>
<%--                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                </div>--%>
<%--                <div class="modal-body">--%>
<%--                    <p>Are you sure you want to reject this account?</p>--%>
<%--                    <p><strong>Account ID:</strong> <span id="rejectAccountId"></span></p>--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="rejectReason">Reason for rejection:</label>--%>
<%--                        <textarea class="form-control" id="rejectReason" rows="3" placeholder="Enter reason..."></textarea>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>--%>
<%--                    <button type="button" class="btn btn-danger" onclick="confirmReject()">Reject Account</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    --%>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--    <script src="../js/main.js"></script>--%>
<%--    <script>--%>
<%--        let currentAccountId = '';--%>
<%--        --%>
<%--        function approveAccount(accountId) {--%>
<%--            currentAccountId = accountId;--%>
<%--            document.getElementById('approveAccountId').textContent = accountId;--%>
<%--            new bootstrap.Modal(document.getElementById('approveModal')).show();--%>
<%--        }--%>
<%--        --%>
<%--        function rejectAccount(accountId) {--%>
<%--            currentAccountId = accountId;--%>
<%--            document.getElementById('rejectAccountId').textContent = accountId;--%>
<%--            new bootstrap.Modal(document.getElementById('rejectModal')).show();--%>
<%--        }--%>
<%--        --%>
<%--        function confirmApprove() {--%>
<%--            // TODO: Implement backend call to approve account--%>
<%--            alert('Account ' + currentAccountId + ' has been approved successfully!');--%>
<%--            bootstrap.Modal.getInstance(document.getElementById('approveModal')).hide();--%>
<%--            location.reload();--%>
<%--        }--%>
<%--        --%>
<%--        function confirmReject() {--%>
<%--            const reason = document.getElementById('rejectReason').value;--%>
<%--            if (!reason.trim()) {--%>
<%--                alert('Please provide a reason for rejection.');--%>
<%--                return;--%>
<%--            }--%>
<%--            --%>
<%--            // TODO: Implement backend call to reject account--%>
<%--            alert('Account ' + currentAccountId + ' has been rejected. Reason: ' + reason);--%>
<%--            bootstrap.Modal.getInstance(document.getElementById('rejectModal')).hide();--%>
<%--            location.reload();--%>
<%--        }--%>

<%--        // Logout function for admin--%>
<%--        function performLogout() {--%>
<%--            if (confirm('Are you sure you want to logout?')) {--%>
<%--                // Show loading indicator--%>
<%--                const logoutBtns = document.querySelectorAll('a[onclick="performLogout()"]');--%>
<%--                logoutBtns.forEach(btn => {--%>
<%--                    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>Logging out...</span>';--%>
<%--                    btn.style.pointerEvents = 'none';--%>
<%--                });--%>

<%--                // Create a form and submit it to the servlet with admin parameter--%>
<%--                const form = document.createElement('form');--%>
<%--                form.method = 'GET';--%>
<%--                form.action = '../user/logout';--%>
<%--                --%>
<%--                // Add a parameter to indicate this is an admin logout--%>
<%--                const adminParam = document.createElement('input');--%>
<%--                adminParam.type = 'hidden';--%>
<%--                adminParam.name = 'admin';--%>
<%--                adminParam.value = 'true';--%>
<%--                form.appendChild(adminParam);--%>
<%--                --%>
<%--                document.body.appendChild(form);--%>
<%--                form.submit();--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pending Account Approvals</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            display: none;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .loading {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 8px 16px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }
        .status-active {
            color: #28a745;
            font-weight: bold;
        }
        .status-closed {
            color: #dc3545;
            font-weight: bold;
        }
        .no-accounts {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 40px;
        }
        .account-info {
            font-size: 12px;
            color: #6c757d;
        }
        .processed-row {
            background-color: #f8f9fa;
            opacity: 0.7;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Pending Account Approvals</h1>

    <div id="successAlert" class="alert alert-success"></div>
    <div id="errorAlert" class="alert alert-error"></div>

    <div id="loadingDiv" class="loading">
        <p>Loading pending accounts...</p>
    </div>

    <div id="accountsContainer" style="display: none;">
        <table id="accountsTable">
            <thead>
            <tr>
                <th>Account ID</th>
                <th>Account Number</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Account Type</th>
                <th>Account Name</th>
                <th>Balance</th>
                <th>Registration Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="accountsTableBody">
            </tbody>
        </table>
    </div>

    <div id="noAccountsDiv" class="no-accounts" style="display: none;">
        <h3>No pending accounts found</h3>
        <p>All accounts have been processed or no new account requests are available.</p>
    </div>

    <div style="margin-top: 30px; text-align: center;">
        <%
            String contextPath = request.getContextPath();
        %>
        <a href="<%= contextPath %>/admin/dashboard" class="btn" style="background-color: #6c757d; color: white;">
            Back to Dashboard
        </a>
    </div>
</div>

<script>
    // Global variables
    let pendingAccounts = [];
    <%
        String jsContextPath = request.getContextPath();
    %>
    const contextPath = '<%= jsContextPath %>';

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        loadPendingAccounts();
    });

    // Load pending accounts using fetch
    function loadPendingAccounts() {
        fetch(contextPath + '/api/pendingAccounts')
            .then(response => response.json())
            .then(data => {
                document.getElementById('loadingDiv').style.display = 'none';

                if (data.success) {
                    pendingAccounts = data.data;
                    displayAccounts();
                } else {
                    showError('Failed to load pending accounts: ' + data.message);
                }
            })
            .catch(error => {
                document.getElementById('loadingDiv').style.display = 'none';
                showError('Error loading pending accounts: ' + error.message);
            });
    }

    // Display accounts in table
    function displayAccounts() {
        const tbody = document.getElementById('accountsTableBody');
        tbody.innerHTML = '';

        if (pendingAccounts.length === 0) {
            document.getElementById('noAccountsDiv').style.display = 'block';
            return;
        }

        document.getElementById('accountsContainer').style.display = 'block';

        pendingAccounts.forEach(account => {
            const row = createAccountRow(account);
            tbody.appendChild(row);
        });
    }

    // Create table row for account
    function createAccountRow(account) {
        const row = document.createElement('tr');
        row.id = 'account-row-' + account.accountId;

        // Apply processed row style if not pending
        if (account.status !== 'PENDING_APPROVAL') {
            row.classList.add('processed-row');
        }

        // Create cell content
        const accountIdCell = document.createElement('td');
        accountIdCell.textContent = account.accountId;

        const accountNumberCell = document.createElement('td');
        accountNumberCell.innerHTML = '<strong>' + account.accountNumber + '</strong>' +
            '<div class="account-info">Currency: ' + account.currency + '</div>';

        const fullNameCell = document.createElement('td');
        fullNameCell.textContent = account.fullName;

        const emailCell = document.createElement('td');
        emailCell.textContent = account.email;

        const phoneCell = document.createElement('td');
        phoneCell.textContent = account.phoneNumber;

        const accountTypeCell = document.createElement('td');
        accountTypeCell.textContent = account.accountType;

        const accountNameCell = document.createElement('td');
        accountNameCell.textContent = account.accountName;

        const balanceCell = document.createElement('td');
        balanceCell.textContent = '$' + account.balance;

        const dateCell = document.createElement('td');
        dateCell.textContent = account.createdAt;

        const statusCell = document.createElement('td');
        statusCell.innerHTML = '<span class="status-' + account.status.toLowerCase() + '">' + account.status + '</span>';

        const actionsCell = document.createElement('td');

        if (account.status === 'PENDING_APPROVAL') {
            const approveBtn = document.createElement('button');
            approveBtn.className = 'btn btn-approve';
            approveBtn.textContent = 'Approve';
            approveBtn.onclick = function() { processAccount(account.accountId, 'approve'); };

            const rejectBtn = document.createElement('button');
            rejectBtn.className = 'btn btn-reject';
            rejectBtn.textContent = 'Reject';
            rejectBtn.onclick = function() { processAccount(account.accountId, 'reject'); };

            actionsCell.appendChild(approveBtn);
            actionsCell.appendChild(rejectBtn);
        } else {
            actionsCell.innerHTML = '<span style="color: #6c757d; font-style: italic;">Processed</span>';
        }

        // Append all cells to row
        row.appendChild(accountIdCell);
        row.appendChild(accountNumberCell);
        row.appendChild(fullNameCell);
        row.appendChild(emailCell);
        row.appendChild(phoneCell);
        row.appendChild(accountTypeCell);
        row.appendChild(accountNameCell);
        row.appendChild(balanceCell);
        row.appendChild(dateCell);
        row.appendChild(statusCell);
        row.appendChild(actionsCell);

        return row;
    }

    // Process account (approve/reject)
    function processAccount(accountId, action) {
        const actionText = action === 'approve' ? 'approve' : 'reject';

        if (!confirm('Are you sure you want to ' + actionText + ' this account?')) {
            return;
        }

        // Disable buttons
        const row = document.getElementById('account-row-' + accountId);
        const buttons = row.querySelectorAll('button');
        buttons.forEach(function(btn) {
            btn.disabled = true;
        });

        // Show loading state
        buttons.forEach(function(btn) {
            if (btn.textContent.toLowerCase().includes(actionText)) {
                btn.textContent = action === 'approve' ? 'Approving...' : 'Rejecting...';
            }
        });

        // Make API call
        const formData = new FormData();
        formData.append('accountId', accountId);
        formData.append('action', action);

        fetch(contextPath + '/api/pendingAccounts', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update account status in local array
                    const accountIndex = pendingAccounts.findIndex(function(acc) {
                        return acc.accountId === accountId;
                    });
                    if (accountIndex !== -1) {
                        pendingAccounts[accountIndex].status = data.newStatus;
                    }

                    // Update the row
                    updateAccountRow(accountId, data.newStatus);

                    // Show success message
                    showSuccess(data.message);
                } else {
                    showError(data.message);

                    // Re-enable buttons
                    buttons.forEach(function(btn) {
                        btn.disabled = false;
                        if (btn.textContent.toLowerCase().includes('approving')) {
                            btn.textContent = 'Approve';
                        } else if (btn.textContent.toLowerCase().includes('rejecting')) {
                            btn.textContent = 'Reject';
                        }
                    });
                }
            })
            .catch(error => {
                showError('Error processing account: ' + error.message);

                // Re-enable buttons
                buttons.forEach(function(btn) {
                    btn.disabled = false;
                    if (btn.textContent.toLowerCase().includes('approving')) {
                        btn.textContent = 'Approve';
                    } else if (btn.textContent.toLowerCase().includes('rejecting')) {
                        btn.textContent = 'Reject';
                    }
                });
            });
    }

    // Update account row after processing
    function updateAccountRow(accountId, newStatus) {
        const row = document.getElementById('account-row-' + accountId);

        // Update status cell
        const statusCell = row.cells[9];
        statusCell.innerHTML = '<span class="status-' + newStatus.toLowerCase() + '">' + newStatus + '</span>';

        // Update actions cell
        const actionsCell = row.cells[10];
        actionsCell.innerHTML = '<span style="color: #6c757d; font-style: italic;">Processed</span>';

        // Add processed row styling
        row.classList.add('processed-row');
    }

    // Show success message
    function showSuccess(message) {
        const alert = document.getElementById('successAlert');
        alert.textContent = message;
        alert.style.display = 'block';

        // Hide after 5 seconds
        setTimeout(function() {
            alert.style.display = 'none';
        }, 5000);
    }

    // Show error message
    function showError(message) {
        const alert = document.getElementById('errorAlert');
        alert.textContent = message;
        alert.style.display = 'block';

        // Hide after 5 seconds
        setTimeout(function() {
            alert.style.display = 'none';
        }, 5000);
    }
</script>
</body>
</html>
