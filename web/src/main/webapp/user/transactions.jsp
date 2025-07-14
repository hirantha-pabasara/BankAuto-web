<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/user.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .transfer-status-pending { color: #ffc107; }
        .transfer-status-completed { color: #198754; }
        .transfer-status-failed { color: #dc3545; }
        .transfer-status-scheduled { color: #0dcaf0; }
        .balance-info { font-size: 0.9em; color: #6c757d; }
        .validation-error { border-color: #dc3545; }
        .amount-warning { color: #dc3545; font-size: 0.8em; }
    </style>
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
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small" id="usernameDisplay">User</span>
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
                        <div>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#transferModal">
                                <i class="fas fa-paper-plane"></i> New Transfer
                            </button>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
    
    <!-- Enhanced Transfer Modal -->
    <div class="modal fade" id="transferModal" tabindex="-1" aria-labelledby="transferModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="transferModalLabel">
                        <i class="fas fa-paper-plane"></i> New Transfer
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="transferForm" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="fromAccount" class="form-label">From Account: <span class="text-danger">*</span></label>
                                    <select class="form-control" id="fromAccount" required>
                                        <option value="">Select Account</option>
                                        <!-- Populated dynamically -->
                                    </select>
                                    <div class="balance-info mt-1" id="balanceInfo"></div>
                                    <div class="invalid-feedback">Please select a source account</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="toAccount" class="form-label">To Account/Email: <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="toAccount" 
                                           placeholder="Enter account number or email" required>
                                    <div class="form-text">Enter account number (e.g., ACC1234567890) or email address</div>
                                    <div class="invalid-feedback">Please enter destination account or email</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="amount" class="form-label">Amount: <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" class="form-control" id="amount" 
                                               placeholder="0.00" step="0.01" min="0.01" max="1000000" required>
                                    </div>
                                    <div class="amount-warning mt-1" id="amountWarning" style="display: none;"></div>
                                    <div class="invalid-feedback">Please enter a valid amount</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="transferType" class="form-label">Transfer Type: <span class="text-danger">*</span></label>
                                    <select class="form-control" id="transferType" onchange="handleTransferTypeChange()" required>
                                        <option value="IMMEDIATE">Immediate Transfer</option>
                                        <option value="SCHEDULED">Scheduled Transfer</option>
                                        <option value="RECURRING">Recurring Transfer</option>
                                    </select>
                                    <div class="invalid-feedback">Please select transfer type</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="description" class="form-label">Description:</label>
                            <input type="text" class="form-control" id="description" 
                                   placeholder="Optional description (max 200 characters)" maxlength="200">
                            <div class="form-text">Optional: Provide a description for this transfer</div>
                        </div>
                        
                        <!-- Scheduled Transfer Fields -->
                        <div id="scheduledFields" style="display: none;">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> This transfer will be processed automatically at the scheduled time using EJB Timer Services.
                            </div>
                            <div class="form-group mb-3">
                                <label for="scheduledDateTime" class="form-label">Scheduled Date & Time: <span class="text-danger">*</span></label>
                                <input type="datetime-local" class="form-control" id="scheduledDateTime">
                                <div class="form-text">Select when this transfer should be processed</div>
                                <div class="invalid-feedback">Please select a future date and time</div>
                            </div>
                        </div>
                        
                        <!-- Recurring Transfer Fields -->
                        <div id="recurringFields" style="display: none;">
                            <div class="alert alert-warning">
                                <i class="fas fa-exclamation-triangle"></i> Recurring transfers will be processed automatically according to the schedule using EJB Timer Services.
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group mb-3">
                                        <label for="startDate" class="form-label">Start Date: <span class="text-danger">*</span></label>
                                        <input type="date" class="form-control" id="startDate">
                                        <div class="invalid-feedback">Please select start date</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group mb-3">
                                        <label for="frequency" class="form-label">Frequency: <span class="text-danger">*</span></label>
                                        <select class="form-control" id="frequency">
                                            <option value="">Select frequency</option>
                                            <option value="DAILY">Daily</option>
                                            <option value="WEEKLY">Weekly</option>
                                            <option value="MONTHLY">Monthly</option>
                                            <option value="QUARTERLY">Quarterly</option>
                                            <option value="ANNUALLY">Annually</option>
                                        </select>
                                        <div class="invalid-feedback">Please select frequency</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group mb-3">
                                        <label for="endDate" class="form-label">End Date:</label>
                                        <input type="date" class="form-control" id="endDate">
                                        <div class="form-text">Optional: Leave blank for indefinite</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Error and Success Messages -->
                        <div id="transferError" class="alert alert-danger" style="display: none;">
                            <i class="fas fa-exclamation-circle"></i>
                            <span id="errorMessage"></span>
                        </div>
                        <div id="transferSuccess" class="alert alert-success" style="display: none;">
                            <i class="fas fa-check-circle"></i>
                            <span id="successMessage"></span>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="transferButton" onclick="processTransfer()">
                        <span id="transferButtonText">Process Transfer</span>
                        <span id="transferSpinner" class="spinner-border spinner-border-sm ms-1" style="display: none;"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Transaction Details Modal -->
    <div class="modal fade" id="transactionDetailsModal" tabindex="-1" aria-labelledby="transactionDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="transactionDetailsModalLabel">
                        <i class="fas fa-info-circle"></i> Transaction Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="transactionDetailsContent">
                    <!-- Populated dynamically -->
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/main.js"></script>
    <script src="../js/TransactionFlowLogger.js"></script>
    <script src="../js/Transactions.js"></script>
    
    <!-- Transaction Flow Debug Panel -->
    <div id="debugPanel" style="position: fixed; top: 10px; right: 10px; width: 350px; background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px; padding: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); z-index: 9999; display: none;">
        <div style="display: flex; justify-content: between; align-items: center; margin-bottom: 10px;">
            <h6 style="margin: 0; color: #495057;">🔍 Transaction Flow Debug</h6>
            <button onclick="toggleDebugPanel()" style="background: none; border: none; font-size: 16px; cursor: pointer;">✕</button>
        </div>
        <div style="font-size: 12px; color: #6c757d; margin-bottom: 10px;">
            Session: <span id="debugSessionId"></span><br>
            Context: <code>http://localhost:8080/bankauto/user/</code><br>
            Backend: <span id="debugBackendMode">REAL</span>
        </div>
        <div style="margin-bottom: 10px;">
            <button onclick="downloadTransactionLogs()" class="btn btn-sm btn-outline-primary" style="margin-right: 5px;">📥 Logs</button>
            <button onclick="clearTransactionLogs()" class="btn btn-sm btn-outline-secondary" style="margin-right: 5px;">🗑️ Clear</button>
            <button onclick="testBackend()" class="btn btn-sm btn-outline-info" style="margin-right: 5px;">🔧 Test</button>
            <button onclick="toggleBackend()" class="btn btn-sm btn-outline-warning">🔄 Mode</button>
        </div>
        <div style="max-height: 200px; overflow-y: auto; font-size: 11px; font-family: monospace; background: #f8f9fa; padding: 5px; border-radius: 3px;">
            <div id="debugLogOutput"></div>
        </div>
        <div style="margin-top: 10px; font-size: 11px; color: #6c757d;">
            <div>Logs: <span id="debugLogCount">0</span> | Errors: <span id="debugErrorCount">0</span></div>
        </div>
    </div>
    
    <script>
        // Debug panel functionality
        let debugPanelVisible = false;
        
        function toggleDebugPanel() {
            debugPanelVisible = !debugPanelVisible;
            document.getElementById('debugPanel').style.display = debugPanelVisible ? 'block' : 'none';
            if (debugPanelVisible) {
                updateDebugPanel();
            }
        }
        
        function updateDebugPanel() {
            if (window.TransactionLogger) {
                const summary = window.TransactionLogger.generateSummary();
                document.getElementById('debugSessionId').textContent = window.TransactionLogger.sessionId;
                document.getElementById('debugLogCount').textContent = summary.totalLogs;
                document.getElementById('debugErrorCount').textContent = summary.errorCount;
                
                // Show recent logs
                const recentLogs = window.TransactionLogger.logBuffer.slice(-10);
                const logOutput = document.getElementById('debugLogOutput');
                logOutput.innerHTML = recentLogs.map(log => 
                    `<div style="margin-bottom: 2px; color: ${getLogColor(log.level)};">
                        [${log.timestamp.substr(11, 8)}] ${log.component}: ${log.message}
                    </div>`
                ).join('');
                logOutput.scrollTop = logOutput.scrollHeight;
            }
        }
        
        function getLogColor(level) {
            switch(level) {
                case 'ERROR': return '#dc3545';
                case 'WARN': return '#ffc107';
                case 'INFO': return '#198754';
                case 'DEBUG': return '#6c757d';
                default: return '#212529';
            }
        }
        
        function downloadTransactionLogs() {
            if (window.TransactionLogger) {
                window.TransactionLogger.downloadLogs();
            }
        }
        
        function clearTransactionLogs() {
            if (window.TransactionLogger) {
                window.TransactionLogger.clearLogs();
                updateDebugPanel();
            }
        }
        
        // Debug Panel Control Functions
        function testBackend() {
            if (typeof testBackendConnectivity === 'function') {
                testBackendConnectivity();
            } else {
                TransactionFlowLogger.error('Debug', 'testBackendConnectivity function not available');
            }
        }

        function toggleBackend() {
            if (typeof toggleBackendMode === 'function') {
                toggleBackendMode();
                // Update debug panel display
                const modeElement = document.getElementById('debugBackendMode');
                if (modeElement) {
                    modeElement.textContent = window.USE_REAL_BACKEND ? 'REAL' : 'MOCK';
                }
            } else {
                TransactionFlowLogger.error('Debug', 'toggleBackendMode function not available');
            }
        }

        // Initialize debug panel on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set initial backend mode display
            const modeElement = document.getElementById('debugBackendMode');
            if (modeElement) {
                modeElement.textContent = window.USE_REAL_BACKEND ? 'REAL' : 'MOCK';
            }
            
            // Auto-test backend connectivity on load
            setTimeout(function() {
                TransactionFlowLogger.info('System', 'Auto-testing backend connectivity...');
                testBackend();
            }, 1000);
        });
        
        // Auto-update debug panel
        setInterval(() => {
            if (debugPanelVisible) {
                updateDebugPanel();
            }
        }, 2000);
        
        // Keyboard shortcut to toggle debug panel (Ctrl+Shift+D)
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.shiftKey && e.key === 'D') {
                e.preventDefault();
                toggleDebugPanel();
            }
        });
        
        // Log page load
        document.addEventListener('DOMContentLoaded', function() {
            if (window.TransactionLogger) {
                window.TransactionLogger.logFrontendEvent('PAGE_LOAD', {
                    page: 'transactions.jsp',
                    timestamp: new Date().toISOString(),
                    userAgent: navigator.userAgent
                });
            }
        });
        
        // Load username via JavaScript instead of EL expression
        fetch('account-details', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            credentials: 'same-origin'
        })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Failed to load user info');
        })
        .then(data => {
            // Try to get username from the response or session
            const usernameDisplay = document.getElementById('usernameDisplay');
            if (usernameDisplay) {
                // If the response contains user info, use it
                if (data && data.length > 0 && data[0].accountHolder) {
                    usernameDisplay.textContent = data[0].accountHolder;
                } else {
                    // Fallback to a generic display
                    usernameDisplay.textContent = 'User';
                }
            }
        })
        .catch(error => {
            console.log('Could not load username:', error);
            // Keep default "User" text
        });
        
        console.log('🔍 Transaction Flow Debug Panel loaded. Press Ctrl+Shift+D to toggle.');
    </script>
</body>
</html>
