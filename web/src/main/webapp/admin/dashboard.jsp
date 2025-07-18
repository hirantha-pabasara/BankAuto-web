<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/admin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Custom styles for Interest Rate Management */
        #interestRatesTableBody input[type="number"] {
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 5px 8px;
            font-size: 14px;
        }
        
        #interestRatesTableBody input[type="number"]:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            outline: none;
        }
        
        .table th {
            background-color: #343a40;
            color: white;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
        }
        
        .table td {
            text-align: center;
            vertical-align: middle;
        }
        
        .badge {
            font-size: 0.9em;
            padding: 6px 12px;
        }
        
        .btn-sm {
            font-size: 0.8rem;
            padding: 4px 8px;
        }
        
        #interestManagementSection .card {
            border: none;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        #interestManagementSection .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
        }
        
        .table-responsive {
            border-radius: 0.35rem;
            overflow: hidden;
        }
        
        .d-flex.justify-content-between {
            gap: 10px;
        }
        
        .d-flex.justify-content-between .btn {
            flex: 1;
            max-width: 250px;
        }
    </style>
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
                    <a class="nav-link active" href="dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                </li>
                <li class="nav-item mb-2">
                    <a class="nav-link" href="pendingAccounts.jsp"><i class="fas fa-user-clock me-2"></i>Pending Accounts</a>
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
                    <span class="navbar-brand mb-0 h1"><i class="fas fa-user-shield me-2"></i>Admin Dashboard</span>
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
                        <h1 class="h3 mb-0 text-gray-800">Admin Dashboard</h1>
                    </div>
                    
                    <!-- Content Row -->
                    <div class="row">
                        <!-- Total Users Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Users</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">1,234</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-users fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Pending Accounts Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Accounts</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user-clock fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Active Accounts Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Active Accounts</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">1,216</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user-check fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Total Transactions Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Transactions</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">24,567</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-exchange-alt fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Content Row -->
                    <div class="row">
                        <!-- Recent Activity -->
                        <div class="col-lg-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Recent Activity</h6>
                                </div>
                                <div class="card-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">New Account Registration</h6>
                                                <small>3 mins ago</small>
                                            </div>
                                            <p class="mb-1">John Doe registered for a new account</p>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">Account Approved</h6>
                                                <small>12 mins ago</small>
                                            </div>
                                            <p class="mb-1">Jane Smith's account has been approved</p>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">Large Transaction</h6>
                                                <small>1 hour ago</small>
                                            </div>
                                            <p class="mb-1">$50,000 transfer detected</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Quick Actions -->
                        <div class="col-lg-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <a class="btn btn-warning btn-block w-100" href="pendingAccounts.jsp">
                                                <i class="fas fa-user-clock"></i> Account Approvals
                                            </a>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <button class="btn btn-success btn-block w-100" onclick="loadInterestManagement()">
                                                <i class="fas fa-percentage"></i> Interest Rate Management
                                            </button>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <button class="btn btn-info btn-block w-100" onclick="applyInterestToAll()">
                                                <i class="fas fa-calculator"></i> Apply Interest to All Accounts
                                            </button>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <button class="btn btn-primary btn-block w-100" onclick="viewInterestTransactions()">
                                                <i class="fas fa-chart-line"></i> Interest Transactions Report
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Interest Rate Management Section -->
                    <div class="row" id="interestManagementSection" style="display: none;">
                        <div class="col-lg-12 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex justify-content-between align-items-center">
                                    <h6 class="m-0 font-weight-bold text-primary">Interest Rate Management</h6>
                                    <button class="btn btn-sm btn-secondary" onclick="hideInterestManagement()">
                                        <i class="fas fa-times"></i> Close
                                    </button>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-4">
                                        <div class="col-md-12">
                                            <h5 class="mb-3">Current Interest Rates</h5>
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <thead class="table-dark">
                                                        <tr>
                                                            <th>Account Type</th>
                                                            <th>Current Rate (%)</th>
                                                            <th>New Rate (%)</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="interestRatesTableBody">
                                                        <!-- Interest rates will be loaded here -->
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <button type="button" class="btn btn-success" onclick="updateAllInterestRates()">
                                                    <i class="fas fa-save"></i> Update All Rates
                                                </button>
                                                <button type="button" class="btn btn-secondary" onclick="loadInterestRates()">
                                                    <i class="fas fa-sync-alt"></i> Refresh
                                                </button>
                                                <button type="button" class="btn btn-warning" onclick="initializeRates()">
                                                    <i class="fas fa-database"></i> Initialize Default Rates
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Status Messages -->
                    <div class="row">
                        <div class="col-12">
                            <div id="statusMessage" class="alert" style="display: none;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script>
        // Admin Dashboard JavaScript Functions
        
        function showStatus(message, type) {
            if (!type) type = 'success';
            const statusDiv = document.getElementById('statusMessage');
            statusDiv.className = 'alert alert-' + type + ' alert-dismissible fade show';
            statusDiv.innerHTML = 
                message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            statusDiv.style.display = 'block';
            
            setTimeout(function() {
                statusDiv.style.display = 'none';
            }, 5000);
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
        
        async function loadPendingAccounts() {
            try {
                // Hide interest management section
                document.getElementById('interestManagementSection').style.display = 'none';
                
                const response = await fetch('account-approval');
                if (!response.ok) {
                    throw new Error('Failed to fetch pending accounts');
                }
                
                const accounts = await response.json();
                showStatus('Found ' + accounts.length + ' pending accounts', 'info');
                window.location.href =approveAccounts.jsp; // Redirect to the accounts approval page
                // You can add more functionality here to display the accounts
                
            } catch (error) {
                console.error('Error loading pending accounts:', error);
                showStatus('Failed to load pending accounts', 'danger');
            }
        }
        
        async function loadInterestManagement() {
            try {
                // Show interest management section
                document.getElementById('interestManagementSection').style.display = 'block';
                
                // Load current interest rates
                await loadInterestRates();
                
                // Scroll to the section
                document.getElementById('interestManagementSection').scrollIntoView({ 
                    behavior: 'smooth' 
                });
                
                showStatus('Interest Rate Management loaded successfully', 'success');
                
            } catch (error) {
                console.error('Error loading interest management:', error);
                showStatus('Failed to load interest management', 'danger');
            }
        }

        function hideInterestManagement() {
            document.getElementById('interestManagementSection').style.display = 'none';
        }

        async function loadInterestRates() {
            try {
                const response = await fetch('interest-rates');
                if (!response.ok) {
                    throw new Error('Failed to fetch interest rates');
                }
                
                const result = await response.json();
                
                if (result.success) {
                    displayInterestRatesTable(result.rates);
                    showStatus('Interest rates loaded successfully', 'success');
                } else {
                    throw new Error(result.message || 'Failed to load interest rates');
                }
                
            } catch (error) {
                console.error('Error loading interest rates:', error);
                showStatus('Failed to load interest rates: ' + error.message, 'danger');
                
                // Display default rates table on error
                displayDefaultRatesTable();
            }
        }

        function displayInterestRatesTable(rates) {
            const tbody = document.getElementById('interestRatesTableBody');
            tbody.innerHTML = '';
            
            for (let i = 0; i < rates.length; i++) {
                const rate = rates[i];
                const row = document.createElement('tr');
                const accountTypeId = rate.accountType.replace(/\s+/g, '_');
                
                row.innerHTML = 
                    '<td><strong>' + rate.displayName + '</strong></td>' +
                    '<td><span class="badge bg-info">' + rate.currentRate + '%</span></td>' +
                    '<td>' +
                        '<input type="number" class="form-control" ' +
                               'id="newRate_' + accountTypeId + '" ' +
                               'step="0.01" min="0" max="15" ' +
                               'placeholder="Enter new rate">' +
                    '</td>' +
                    '<td>' +
                        '<button class="btn btn-sm btn-primary" ' +
                                'onclick="updateSingleRate(\'' + rate.accountType + '\')">' +
                            '<i class="fas fa-save"></i> Update' +
                        '</button>' +
                    '</td>';
                tbody.appendChild(row);
            }
        }

        function displayDefaultRatesTable() {
            const defaultRates = [
                { accountType: 'Savings Account', displayName: 'Savings', currentRate: '2.50' },
                { accountType: 'Checking Account', displayName: 'Checking', currentRate: '0.50' },
                { accountType: 'Current Account', displayName: 'Current', currentRate: '1.00' },
                { accountType: 'Fixed Deposit', displayName: 'Fixed Deposit', currentRate: '5.00' }
            ];
            
            displayInterestRatesTable(defaultRates);
        }

        async function updateSingleRate(accountType) {
            try {
                const inputId = 'newRate_' + accountType.replace(/\s+/g, '_');
                const newRateInput = document.getElementById(inputId);
                const newRate = newRateInput.value.trim();
                
                if (!newRate) {
                    showStatus('Please enter a new rate to update', 'warning');
                    return;
                }
                
                if (parseFloat(newRate) < 0 || parseFloat(newRate) > 15) {
                    showStatus('Interest rate must be between 0% and 15%', 'warning');
                    return;
                }
                
                const params = new URLSearchParams();
                params.append('action', 'updateRate');
                params.append('accountType', accountType);
                params.append('newRate', newRate);
                
                const response = await fetch('interest-rates', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: params
                });
                
                if (!response.ok) {
                    throw new Error('Failed to update interest rate');
                }
                
                const result = await response.json();
                
                if (result.success) {
                    showStatus(result.message, 'success');
                    // Reload the table to show updated rates
                    await loadInterestRates();
                } else {
                    showStatus(result.message || 'Failed to update interest rate', 'danger');
                }
                
            } catch (error) {
                console.error('Error updating single interest rate:', error);
                showStatus('Failed to update interest rate', 'danger');
            }
        }

        async function updateAllInterestRates() {
            try {
                const tableBody = document.getElementById('interestRatesTableBody');
                const rows = tableBody.getElementsByTagName('tr');
                const params = new URLSearchParams();
                params.append('action', 'updateAllRates');
                
                let hasRates = false;
                
                for (let i = 0; i < rows.length; i++) {
                    const row = rows[i];
                    const input = row.querySelector('input[type="number"]');
                    const accountType = getAccountTypeFromRow(row);
                    
                    if (input && input.value.trim() && accountType) {
                        const rate = input.value.trim();
                        
                        if (parseFloat(rate) < 0 || parseFloat(rate) > 15) {
                            showStatus('Interest rate for ' + accountType + ' must be between 0% and 15%', 'warning');
                            return;
                        }
                        
                        const paramName = getParamNameFromAccountType(accountType);
                        params.append(paramName, rate);
                        hasRates = true;
                    }
                }
                
                if (!hasRates) {
                    showStatus('Please enter at least one interest rate to update', 'warning');
                    return;
                }
                
                const response = await fetch('interest-rates', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: params
                });
                
                if (!response.ok) {
                    throw new Error('Failed to update interest rates');
                }
                
                const result = await response.json();
                
                if (result.success) {
                    showStatus(result.message, 'success');
                    // Reload the table to show updated rates
                    await loadInterestRates();
                } else {
                    showStatus(result.message || 'Failed to update interest rates', 'danger');
                }
                
            } catch (error) {
                console.error('Error updating all interest rates:', error);
                showStatus('Failed to update interest rates', 'danger');
            }
        }

        function getAccountTypeFromRow(row) {
            const firstCell = row.getElementsByTagName('td')[0];
            if (firstCell) {
                const text = firstCell.textContent.trim();
                // Map display names back to account types
                switch (text) {
                    case 'Savings': return 'Savings Account';
                    case 'Checking': return 'Checking Account';
                    case 'Current': return 'Current Account';
                    case 'Fixed Deposit': return 'Fixed Deposit';
                    default: return text;
                }
            }
            return null;
        }

        function getParamNameFromAccountType(accountType) {
            switch (accountType) {
                case 'Savings Account': return 'savings';
                case 'Checking Account': return 'checking';
                case 'Current Account': return 'current';
                case 'Fixed Deposit': return 'fixed';
                default: return accountType.toLowerCase().replace(/\s+/g, '');
            }
        }
        
        async function applyInterestToAll() {
            if (!confirm('Are you sure you want to apply interest to all accounts? This will add interest to all account balances based on current rates.')) {
                return;
            }
            
            const button = event.target;
            const originalHTML = button.innerHTML;
            button.disabled = true;
            button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Applying Interest...';
            
            try {
                const response = await fetch('trigger-interest', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                if (!response.ok) {
                    throw new Error('Failed to apply interest');
                }
                
                const result = await response.json();
                
                if (result.success) {
                    showStatus('Interest applied successfully to ' + result.accountsProcessed + ' accounts!', 'success');
                } else {
                    showStatus(result.message || 'Failed to apply interest', 'danger');
                }
                
            } catch (error) {
                console.error('Error applying interest:', error);
                showStatus('Failed to apply interest to accounts. Error: ' + error.message, 'danger');
            } finally {
                button.disabled = false;
                button.innerHTML = originalHTML;
            }
        }
        
        async function initializeRates() {
            try {
                const response = await fetch('initialize-rates', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                });
                
                const result = await response.json();
                
                if (result.success) {
                    showStatus(result.message, 'success');
                    // Refresh the current rates display
                    await loadCurrentRates();
                } else {
                    showStatus(result.message, 'danger');
                }
                
            } catch (error) {
                console.error('Error initializing rates:', error);
                showStatus('Failed to initialize default rates', 'danger');
            }
        }
        
        // Load initial data when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Any initialization code can go here
            console.log('Admin Dashboard loaded');
        });
        
        async function viewInterestTransactions() {
            try {
                // Show loading indicator
                showStatus('Loading interest transactions report...', 'info');
                
                // Get interest summary first
                const summaryResponse = await fetch('../api/interest/summary', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                if (!summaryResponse.ok) {
                    throw new Error('Failed to fetch interest summary');
                }
                
                const summary = await summaryResponse.json();
                
                // Get recent interest transactions
                const transactionsResponse = await fetch('../api/interest/transactions', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                if (!transactionsResponse.ok) {
                    throw new Error('Failed to fetch interest transactions');
                }
                
                const transactionsData = await transactionsResponse.json();
                
                // Display the report in a modal or new section
                displayInterestReport(summary, transactionsData);
                
            } catch (error) {
                console.error('Error fetching interest transactions:', error);
                showStatus('Failed to load interest transactions report. Error: ' + error.message, 'danger');
            }
        }
        
        function displayInterestReport(summary, transactionsData) {
            // Create modal content for interest report
            const modalHtml = 
                '<div class="modal fade" id="interestReportModal" tabindex="-1" aria-labelledby="interestReportModalLabel" aria-hidden="true">' +
                    '<div class="modal-dialog modal-xl">' +
                        '<div class="modal-content">' +
                            '<div class="modal-header">' +
                                '<h5 class="modal-title" id="interestReportModalLabel">' +
                                    '<i class="fas fa-chart-line"></i> Interest Transactions Report' +
                                '</h5>' +
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                            '</div>' +
                            '<div class="modal-body">' +
                                '<!-- Interest Summary Cards -->' +
                                '<div class="row mb-4">' +
                                    '<div class="col-md-3">' +
                                        '<div class="card bg-success text-white">' +
                                            '<div class="card-body">' +
                                                '<div class="d-flex align-items-center">' +
                                                    '<div>' +
                                                        '<div class="h5 mb-0">$' + (summary.totalInterestEarned || '0.00') + '</div>' +
                                                        '<div class="small">Total Interest Paid</div>' +
                                                    '</div>' +
                                                    '<div class="ms-auto">' +
                                                        '<i class="fas fa-dollar-sign fa-2x"></i>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>' +
                                        '</div>' +
                                    '</div>' +
                                    '<div class="col-md-3">' +
                                        '<div class="card bg-primary text-white">' +
                                            '<div class="card-body">' +
                                                '<div class="d-flex align-items-center">' +
                                                    '<div>' +
                                                        '<div class="h5 mb-0">' + (summary.totalPayments || '0') + '</div>' +
                                                        '<div class="small">Total Payments</div>' +
                                                    '</div>' +
                                                    '<div class="ms-auto">' +
                                                        '<i class="fas fa-list fa-2x"></i>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>' +
                                        '</div>' +
                                    '</div>' +
                                    '<div class="col-md-3">' +
                                        '<div class="card bg-info text-white">' +
                                            '<div class="card-body">' +
                                                '<div class="d-flex align-items-center">' +
                                                    '<div>' +
                                                        '<div class="h5 mb-0">$' + (summary.currentMonthInterest || '0.00') + '</div>' +
                                                        '<div class="small">This Month</div>' +
                                                    '</div>' +
                                                    '<div class="ms-auto">' +
                                                        '<i class="fas fa-calendar fa-2x"></i>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>' +
                                        '</div>' +
                                    '</div>' +
                                    '<div class="col-md-3">' +
                                        '<div class="card bg-warning text-white">' +
                                            '<div class="card-body">' +
                                                '<div class="d-flex align-items-center">' +
                                                    '<div>' +
                                                        '<div class="h5 mb-0">' + (summary.periodStart || 'N/A') + '</div>' +
                                                        '<div class="small">Report Period Start</div>' +
                                                    '</div>' +
                                                    '<div class="ms-auto">' +
                                                        '<i class="fas fa-calendar-alt fa-2x"></i>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>' +
                                
                                '<!-- Recent Interest Transactions Table -->' +
                                '<div class="card">' +
                                    '<div class="card-header">' +
                                        '<h6 class="m-0 font-weight-bold">Recent Interest Transactions</h6>' +
                                    '</div>' +
                                    '<div class="card-body">' +
                                        '<div class="table-responsive">' +
                                            '<table class="table table-striped">' +
                                                '<thead>' +
                                                    '<tr>' +
                                                        '<th>Date</th>' +
                                                        '<th>Account</th>' +
                                                        '<th>Amount</th>' +
                                                        '<th>Description</th>' +
                                                        '<th>Reference</th>' +
                                                        '<th>Balance After</th>' +
                                                    '</tr>' +
                                                '</thead>' +
                                                '<tbody id="interestTransactionsTableBody">' +
                                                    generateInterestTransactionsRows(transactionsData.transactions || []) +
                                                '</tbody>' +
                                            '</table>' +
                                        '</div>' +
                                        (transactionsData.totalCount > 5 ? 
                                            '<div class="mt-3 text-center">' +
                                                '<button class="btn btn-outline-primary" onclick="loadAllInterestTransactions()">' +
                                                    'View All ' + transactionsData.totalCount + ' Transactions' +
                                                '</button>' +
                                            '</div>' : '') +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                            '<div class="modal-footer">' +
                                '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>' +
                                '<button type="button" class="btn btn-primary" onclick="exportInterestReport()">' +
                                    '<i class="fas fa-download"></i> Export Report' +
                                '</button>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            
            // Remove existing modal if present
            const existingModal = document.getElementById('interestReportModal');
            if (existingModal) {
                existingModal.remove();
            }
            
            // Add modal to DOM
            document.body.insertAdjacentHTML('beforeend', modalHtml);
            
            // Show modal
            const modal = new bootstrap.Modal(document.getElementById('interestReportModal'));
            modal.show();
            
            showStatus('Interest transactions report loaded successfully!', 'success');
        }
        
        function generateInterestTransactionsRows(transactions) {
            if (!transactions || transactions.length === 0) {
                return '<tr><td colspan="6" class="text-center">No interest transactions found</td></tr>';
            }
            
            return transactions.slice(0, 10).map(transaction => {
                const date = new Date(transaction.transactionDate).toLocaleDateString();
                const amount = parseFloat(transaction.amount).toFixed(2);
                const balanceAfter = transaction.balanceAfterTransaction ? 
                    parseFloat(transaction.balanceAfterTransaction).toFixed(2) : 'N/A';
                
                return '<tr>' +
                        '<td>' + date + '</td>' +
                        '<td>' + (transaction.toAccountIdentifier || 'N/A') + '</td>' +
                        '<td class="text-success">+$' + amount + '</td>' +
                        '<td>' + (transaction.description || 'Interest Credit') + '</td>' +
                        '<td><small>' + transaction.referenceNumber + '</small></td>' +
                        '<td>$' + balanceAfter + '</td>' +
                    '</tr>';
            }).join('');
        }
        
        async function loadAllInterestTransactions() {
            // Close current modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('interestReportModal'));
            modal.hide();
            
            // Show full report - redirect to transactions page with filter
            showStatus('Loading complete interest transactions...', 'info');
            
            // For now, we'll show another modal with all transactions
            // In a real application, you might redirect to a dedicated reports page
            try {
                const response = await fetch('../api/interest/transactions?limit=100', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                if (!response.ok) {
                    throw new Error('Failed to fetch all interest transactions');
                }
                
                const data = await response.json();
                displayAllInterestTransactions(data);
                
            } catch (error) {
                console.error('Error loading all interest transactions:', error);
                showStatus('Failed to load complete interest transactions. Error: ' + error.message, 'danger');
            }
        }
        
        function displayAllInterestTransactions(transactionsData) {
            const modalHtml = 
                '<div class="modal fade" id="allInterestTransactionsModal" tabindex="-1" aria-hidden="true">' +
                    '<div class="modal-dialog modal-xl">' +
                        '<div class="modal-content">' +
                            '<div class="modal-header">' +
                                '<h5 class="modal-title">' +
                                    '<i class="fas fa-list"></i> All Interest Transactions (' + (transactionsData.totalCount || 0) + ')' +
                                '</h5>' +
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                            '</div>' +
                            '<div class="modal-body">' +
                                '<div class="table-responsive" style="max-height: 500px;">' +
                                    '<table class="table table-striped table-sm">' +
                                        '<thead class="table-dark sticky-top">' +
                                            '<tr>' +
                                                '<th>Date</th>' +
                                                '<th>Account</th>' +
                                                '<th>Amount</th>' +
                                                '<th>Description</th>' +
                                                '<th>Reference</th>' +
                                                '<th>Balance After</th>' +
                                            '</tr>' +
                                        '</thead>' +
                                        '<tbody>' +
                                            generateInterestTransactionsRows(transactionsData.transactions || []) +
                                        '</tbody>' +
                                    '</table>' +
                                '</div>' +
                            '</div>' +
                            '<div class="modal-footer">' +
                                '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>' +
                                '<button type="button" class="btn btn-primary" onclick="exportInterestReport()">' +
                                    '<i class="fas fa-download"></i> Export CSV' +
                                '</button>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            
            // Remove existing modal if present
            const existingModal = document.getElementById('allInterestTransactionsModal');
            if (existingModal) {
                existingModal.remove();
            }
            
            // Add modal to DOM
            document.body.insertAdjacentHTML('beforeend', modalHtml);
            
            // Show modal
            const modal = new bootstrap.Modal(document.getElementById('allInterestTransactionsModal'));
            modal.show();
        }
        
        function exportInterestReport() {
            showStatus('Export functionality would be implemented here', 'info');
            // TODO: Implement CSV/PDF export functionality
        }
    </script>
</body>
</html>
