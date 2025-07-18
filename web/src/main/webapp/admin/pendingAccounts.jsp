<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Account Approvals</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8fafc;
        }
        .sidebar {
            min-height: 100vh;
            background: #212529;
            color: #fff;
        }
        .sidebar .nav-link {
            color: #adb5bd;
        }
        .sidebar .nav-link.active, .sidebar .nav-link:hover {
            color: #fff;
            background: #343a40;
        }
        .sidebar .sidebar-header {
            font-size: 1.5rem;
            font-weight: bold;
            padding: 1.5rem 1rem 1rem 1rem;
            text-align: center;
            border-bottom: 1px solid #343a40;
        }
        .main-content {
            margin-left: 250px;
            padding: 2rem 1rem;
        }
        @media (max-width: 991.98px) {
            .main-content {
                margin-left: 0;
            }
            .sidebar {
                min-height: auto;
            }
        }
        .table-responsive {
            border-radius: 0.5rem;
            overflow: hidden;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-approve {
            background-color: #198754;
            color: #fff;
        }
        .btn-reject {
            background-color: #dc3545;
            color: #fff;
        }
        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }
        .status-active {
            color: #198754;
            font-weight: bold;
        }
        .status-closed {
            color: #dc3545;
            font-weight: bold;
        }
        .processed-row {
            background-color: #f1f3f4;
            opacity: 0.7;
        }
        .alert {
            margin-top: 1rem;
        }
        .spinner-border {
            width: 1.5rem;
            height: 1.5rem;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <nav class="sidebar d-none d-lg-block position-fixed" style="width: 250px;">
        <div class="sidebar-header mb-4">
            <i class="fas fa-university me-2"></i>BankAuto Admin
        </div>
        <ul class="nav flex-column px-2">
            <li class="nav-item mb-2">
                <a class="nav-link" href="dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link active" href="pendingAccounts.jsp"><i class="fas fa-user-clock me-2"></i>Pending Accounts</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="approveAccount.jsp"><i class="fas fa-user-check me-2"></i>Approve Accounts</a>
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
                <span class="navbar-brand mb-0 h1"><i class="fas fa-user-shield me-2"></i>Pending Account Approvals</span>
                <button class="btn btn-outline-secondary d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas" aria-controls="sidebarOffcanvas">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="d-none d-lg-block">
                    <span class="me-3 text-muted">Admin</span>
                    <button class="btn btn-outline-danger btn-sm" onclick="performLogout()"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
            </div>
        </nav>
        <!-- Alerts -->
        <div id="successAlert" class="alert alert-success alert-dismissible fade show d-none" role="alert"></div>
        <div id="errorAlert" class="alert alert-danger alert-dismissible fade show d-none" role="alert"></div>
        <!-- Loading Spinner -->
        <div id="loadingDiv" class="text-center my-5">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-3">Loading pending accounts...</p>
        </div>
        <!-- Accounts Table -->
        <div id="accountsContainer" class="table-responsive d-none">
            <table class="table table-hover align-middle">
                <thead class="table-light">
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
                <tbody id="accountsTableBody"></tbody>
            </table>
        </div>
        <!-- No Accounts Message -->
        <div id="noAccountsDiv" class="text-center text-muted my-5 d-none">
            <h4>No pending accounts found</h4>
            <p>All accounts have been processed or no new account requests are available.</p>
        </div>
        <!-- Back to Dashboard -->
        <div class="text-center mt-4">
            <% String contextPath = request.getContextPath(); %>
            <a href="../admin/dashboard.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
        </div>
    </div>
</div>
<!-- Approve Modal -->
<div class="modal fade" id="approveModal" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="approveModalLabel"><i class="fas fa-check-circle text-success me-2"></i>Approve Account</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to approve this account?</p>
                <p><strong>Account ID:</strong> <span id="approveAccountId"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success" onclick="confirmApprove()"><i class="fas fa-check"></i> Approve Account</button>
            </div>
        </div>
    </div>
</div>
<!-- Reject Modal -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="rejectModalLabel"><i class="fas fa-times-circle text-danger me-2"></i>Reject Account</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to reject this account?</p>
                <p><strong>Account ID:</strong> <span id="rejectAccountId"></span></p>
                <div class="mb-3">
                    <label for="rejectReason" class="form-label">Reason for rejection:</label>
                    <textarea class="form-control" id="rejectReason" rows="3" placeholder="Enter reason..."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmReject()"><i class="fas fa-times"></i> Reject Account</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set contextPath from JSP
    const contextPath = '<%= request.getContextPath() %>';
    // Global variables
    let pendingAccounts = [];
    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        loadPendingAccounts();
    });
    // Load pending accounts using fetch
    function loadPendingAccounts() {
        fetch(contextPath + '/api/pendingAccounts')
            .then(response => response.json())
            .then(data => {
                document.getElementById('loadingDiv').classList.add('d-none');
                if (data.success) {
                    pendingAccounts = data.data;
                    displayAccounts();
                } else {
                    showError('Failed to load pending accounts: ' + data.message);
                }
            })
            .catch(error => {
                document.getElementById('loadingDiv').classList.add('d-none');
                showError('Error loading pending accounts: ' + error.message);
            });
    }
    // Display accounts in table
    function displayAccounts() {
        const tbody = document.getElementById('accountsTableBody');
        tbody.innerHTML = '';
        if (pendingAccounts.length === 0) {
            document.getElementById('noAccountsDiv').classList.remove('d-none');
            return;
        }
        document.getElementById('accountsContainer').classList.remove('d-none');
        pendingAccounts.forEach(account => {
            const row = createAccountRow(account);
            tbody.appendChild(row);
        });
    }
    // Create table row for account
    function createAccountRow(account) {
        const row = document.createElement('tr');
        row.id = 'account-row-' + account.accountId;
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
            approveBtn.className = 'btn btn-approve btn-sm me-1';
            approveBtn.innerHTML = '<i class="fas fa-check"></i> Approve';
            approveBtn.setAttribute('title', 'Approve this account');
            approveBtn.onclick = function() { approveAccount(account.accountId); };
            const rejectBtn = document.createElement('button');
            rejectBtn.className = 'btn btn-reject btn-sm';
            rejectBtn.innerHTML = '<i class="fas fa-times"></i> Reject';
            rejectBtn.setAttribute('title', 'Reject this account');
            rejectBtn.onclick = function() { rejectAccount(account.accountId); };
            actionsCell.appendChild(approveBtn);
            actionsCell.appendChild(rejectBtn);
        } else {
            actionsCell.innerHTML = '<span class="text-muted fst-italic">Processed</span>';
        }
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
    // Approve/Reject modal logic
    let currentAccountId = '';
    function approveAccount(accountId) {
        currentAccountId = accountId;
        document.getElementById('approveAccountId').textContent = accountId;
        new bootstrap.Modal(document.getElementById('approveModal')).show();
    }
    function rejectAccount(accountId) {
        currentAccountId = accountId;
        document.getElementById('rejectAccountId').textContent = accountId;
        document.getElementById('rejectReason').value = '';
        new bootstrap.Modal(document.getElementById('rejectModal')).show();
    }
    function confirmApprove() {
        processAccount(currentAccountId, 'approve');
        bootstrap.Modal.getInstance(document.getElementById('approveModal')).hide();
    }
    function confirmReject() {
        const reason = document.getElementById('rejectReason').value;
        if (!reason.trim()) {
            showError('Please provide a reason for rejection.');
            return;
        }
        processAccount(currentAccountId, 'reject', reason);
        bootstrap.Modal.getInstance(document.getElementById('rejectModal')).hide();
    }
    // Process account (approve/reject)
    function processAccount(accountId, action, reason = '') {
        const actionText = action === 'approve' ? 'approve' : 'reject';
        // Disable buttons
        const row = document.getElementById('account-row-' + accountId);
        const buttons = row.querySelectorAll('button');
        buttons.forEach(function(btn) {
            btn.disabled = true;
        });
        // Show loading state
        buttons.forEach(function(btn) {
            if (btn.textContent.toLowerCase().includes(actionText)) {
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>' + (action === 'approve' ? 'Approving...' : 'Rejecting...');
            }
        });
        // Make API call
        const formData = new FormData();
        formData.append('accountId', accountId);
        formData.append('action', action);
        if (action === 'reject') {
            formData.append('reason', reason);
        }
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
                            btn.innerHTML = '<i class="fas fa-check"></i> Approve';
                        } else if (btn.textContent.toLowerCase().includes('rejecting')) {
                            btn.innerHTML = '<i class="fas fa-times"></i> Reject';
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
                        btn.innerHTML = '<i class="fas fa-check"></i> Approve';
                    } else if (btn.textContent.toLowerCase().includes('rejecting')) {
                        btn.innerHTML = '<i class="fas fa-times"></i> Reject';
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
        actionsCell.innerHTML = '<span class="text-muted fst-italic">Processed</span>';
        // Add processed row styling
        row.classList.add('processed-row');
    }
    // Show success message
    function showSuccess(message) {
        const alert = document.getElementById('successAlert');
        alert.textContent = message;
        alert.classList.remove('d-none');
        // Hide after 5 seconds
        setTimeout(function() {
            alert.classList.add('d-none');
        }, 5000);
    }
    // Show error message
    function showError(message) {
        const alert = document.getElementById('errorAlert');
        alert.textContent = message;
        alert.classList.remove('d-none');
        // Hide after 5 seconds
        setTimeout(function() {
            alert.classList.add('d-none');
        }, 5000);
    }
    // Logout function for admin
    function performLogout() {
        if (confirm('Are you sure you want to logout?')) {
            const logoutBtns = document.querySelectorAll('a[onclick="performLogout()"], button[onclick="performLogout()"]');
            logoutBtns.forEach(btn => {
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span> Logging out...</span>';
                btn.style.pointerEvents = 'none';
            });
            const form = document.createElement('form');
            form.method = 'GET';
            form.action = '../user/logout';
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
