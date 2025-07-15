<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-                                            <button class="btn btn-info btn-block w-100" onclick="applyInterestToAll()">
                                                <i class="fas fa-calculator"></i> Apply Interest to All Accounts
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Pending Accounts Management -->
                        <div class="col-lg-6 mb-4">
                            <div class="card shadow mb-4" id="pendingAccountsCard" style="display: none;">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Pending Account Approvals</h6>
                                </div>
                                <div class="card-body">
                                    <div id="pendingAccountsList">
                                        <!-- Pending accounts will be loaded here -->
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
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="d-flex justify-content-between">
                                                <button type="button" class="btn btn-success" onclick="updateAllInterestRates()">
                                                    <i class="fas fa-save"></i> Update All Rates
                                                </button>
                                                <button type="button" class="btn btn-info" onclick="applyInterestToAll()">
                                                    <i class="fas fa-calculator"></i> Apply Interest to All Accounts
                                                </button>
                                                <button type="button" class="btn btn-secondary" onclick="loadInterestRates()">
                                                    <i class="fas fa-sync-alt"></i> Refresh
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
            
            <li class="nav-item active">
                <a class="nav-link" href="dashboard.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span>
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
                                            <button class="btn btn-warning btn-block w-100" onclick="loadPendingAccounts()">
                                                <i class="fas fa-user-clock"></i> Account Approvals
                                            </button>
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
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td><strong>Savings Account</strong></td>
                                                            <td><span id="currentSavingsRate" class="badge bg-info">-</span>%</td>
                                                            <td>
                                                                <input type="number" class="form-control" id="savingsRate" 
                                                                       step="0.01" min="0" max="15" placeholder="Enter new rate (optional)">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Checking Account</strong></td>
                                                            <td><span id="currentCheckingRate" class="badge bg-info">-</span>%</td>
                                                            <td>
                                                                <input type="number" class="form-control" id="checkingRate" 
                                                                       step="0.01" min="0" max="15" placeholder="Enter new rate (optional)">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Current Account</strong></td>
                                                            <td><span id="currentCurrentRate" class="badge bg-info">-</span>%</td>
                                                            <td>
                                                                <input type="number" class="form-control" id="currentRate" 
                                                                       step="0.01" min="0" max="15" placeholder="Enter new rate (optional)">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Fixed Deposit</strong></td>
                                                            <td><span id="currentFixedRate" class="badge bg-info">-</span>%</td>
                                                            <td>
                                                                <input type="number" class="form-control" id="fixedRate" 
                                                                       step="0.01" min="0" max="15" placeholder="Enter new rate (optional)">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="d-flex gap-2">
                                                <button type="button" class="btn btn-primary btn-lg" onclick="updateInterestRates()">
                                                    <i class="fas fa-save"></i> Update Interest Rates
                                                </button>
                                                <button type="button" class="btn btn-success btn-lg" onclick="loadCurrentRates()">
                                                    <i class="fas fa-refresh"></i> Refresh Current Rates
                                                </button>
                                                <button type="button" class="btn btn-warning btn-lg" onclick="initializeRates()">
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
        
        function hideInterestManagement() {
            document.getElementById('interestManagementSection').style.display = 'none';
        }
        
        // Load initial data when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Any initialization code can go here
            console.log('Admin Dashboard loaded');
        });
    </script>
</body>
</html>
