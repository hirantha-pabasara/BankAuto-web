/**
 * Load Account Data from EJB Backend
 * Connects to servlet that uses AccountService EJB
 */

class AccountDataLoader {
    constructor() {
        this.baseUrl = window.location.origin + window.location.pathname.split('/')[1];
        this.accountsData = [];
    }

    /**
     * Initialize account data loading
     */
    async init() {
        try {
            await this.loadUserAccounts();
        } catch (error) {
            console.error('Failed to initialize account data:', error);
            this.showError('Failed to load account data. Please refresh the page.');
        }
    }

    /**
     * Fetch user accounts from backend servlet
     */
    async loadUserAccounts() {
        try {
            const response = await fetch('../user/account-details', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                credentials: 'same-origin'
            });

            if (!response.ok) {
                if (response.status === 401) {
                    // Redirect to login if unauthorized
                    window.location.href = '../login.jsp';
                    return;
                }
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            this.accountsData = await response.json();
            this.displayAccountData();
            
        } catch (error) {
            console.error('Error loading accounts:', error);
            this.showError('Unable to load your accounts. Please try again later.');
        }
    }

    /**
     * Display all account data in UI
     */
    displayAccountData() {
        // Check if we're on the transactions page
        const isTransactionPage = window.location.pathname.includes('transactions.jsp');
        
        if (isTransactionPage) {
            this.initTransactionPage();
        } else {
            // Regular dashboard/account pages
            this.updateAccountCards();
            this.updateAccountTable();
            this.updateAccountSummary();
        }
    }

    /**
     * Update the account cards section
     */
    updateAccountCards() {
        const accountCards = document.querySelectorAll('.card.border-left-success, .card.border-left-primary, .card.border-left-info');
        
        // Reset all cards
        accountCards.forEach(card => {
            const cardBody = card.querySelector('.card-body .row .col');
            const iconCol = card.querySelector('.card-body .row .col-auto');
            
            if (cardBody) {
                cardBody.innerHTML = `
                    <div class="text-xs font-weight-bold text-muted text-uppercase mb-1">No Account</div>
                    <div class="h5 mb-0 font-weight-bold text-gray-800">$0.00</div>
                `;
            }
            if (iconCol) {
                iconCol.innerHTML = `<i class="fas fa-wallet fa-2x text-gray-300"></i>`;
            }
        });

        // Update cards with real data (up to 3 accounts)
        this.accountsData.slice(0, 3).forEach((account, index) => {
            if (index < accountCards.length) {
                const card = accountCards[index];
                const cardBody = card.querySelector('.card-body .row .col');
                const iconCol = card.querySelector('.card-body .row .col-auto');
                
                if (cardBody) {
                    cardBody.innerHTML = `
                        <div class="text-xs font-weight-bold text-${this.getAccountColor(account.accountType)} text-uppercase mb-1">
                            ${account.accountType}
                        </div>
                        <div class="text-xs text-gray-500 mb-1">
                            Account #: ****-${account.accountNumber.slice(-4)}
                        </div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                            ${this.formatCurrency(account.balance, account.currency)}
                        </div>
                        <div class="text-xs text-gray-500">Available Balance</div>
                    `;
                }

                if (iconCol) {
                    iconCol.innerHTML = `
                        <i class="fas ${this.getAccountIcon(account.accountType)} fa-2x text-gray-300"></i>
                    `;
                }

                // Update the bottom info
                const bottomInfo = card.querySelector('.mt-3 small');
                if (bottomInfo) {
                    bottomInfo.innerHTML = `Status: <span class="badge badge-${this.getStatusColor(account.status)}">${account.status}</span>`;
                }
            }
        });
    }

    /**
     * Update the account details table
     */
    updateAccountTable() {
        const tableHead = document.querySelector('#dataTable thead tr');
        const tableBody = document.querySelector('#dataTable tbody');
        
        if (!tableBody || !tableHead) return;

        // Set table headers
        tableHead.innerHTML = `
            <th>Account Type</th>
            <th>Account Number</th>
            <th>Balance</th>
            <th>Status</th>
            <th>Created Date</th>
            <th>Actions</th>
        `;

        // Clear existing rows
        tableBody.innerHTML = '';

        if (this.accountsData.length === 0) {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="6" class="text-center text-muted py-4">
                        <i class="fas fa-info-circle"></i> No accounts found
                    </td>
                </tr>
            `;
            return;
        }

        // Add rows for each account
        this.accountsData.forEach(account => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>
                    <i class="fas ${this.getAccountIcon(account.accountType)} text-${this.getAccountColor(account.accountType)}"></i>
                    ${account.accountType}
                </td>
                <td>****-****-****-${account.accountNumber.slice(-4)}</td>
                <td>${this.formatCurrency(account.balance, account.currency)}</td>
                <td><span class="badge bg-${this.getStatusColor(account.status)}">${account.status}</span></td>
                <td>${this.formatDate(account.createdAt)}</td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="viewAccountDetails(${account.id})">
                        <i class="fas fa-eye"></i>
                    </button>
                    ${account.status === 'ACTIVE' ? `
                        <button class="btn btn-sm btn-success" onclick="initiateTransfer(${account.id})">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                        <button class="btn btn-sm btn-info" onclick="generateStatement(${account.id})">
                            <i class="fas fa-file-alt"></i>
                        </button>
                    ` : ''}
                </td>
            `;
            tableBody.appendChild(row);
        });
    }

    /**
     * Update account summary section
     */
    updateAccountSummary() {
        // Update total balance and account count in summary section
        const summaryRows = document.querySelectorAll('.card-body .row');
        
        if (summaryRows.length > 0) {
            const totalBalance = this.accountsData.reduce((sum, account) => 
                sum + parseFloat(account.balance || 0), 0
            );
            const activeCount = this.accountsData.filter(acc => acc.status === 'ACTIVE').length;

            // Find the summary section (usually the last row in account summary card)
            const lastSummarySection = Array.from(summaryRows).find(row => 
                row.querySelector('.h2') && row.textContent.includes('Total Balance')
            );

            if (lastSummarySection) {
                lastSummarySection.innerHTML = `
                    <div class="col-6">
                        <div class="text-center">
                            <div class="h2 mb-0 text-gray-800">${this.formatCurrency(totalBalance)}</div>
                            <div class="text-sm text-gray-500">Total Balance</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="text-center">
                            <div class="h2 mb-0 text-gray-800">${activeCount}</div>
                            <div class="text-sm text-gray-500">Active Accounts</div>
                        </div>
                    </div>
                `;
            }
        }
    }

    /**
     * Populate account filter dropdown for transactions page
     */
    populateAccountFilter() {
        const accountFilter = document.getElementById('accountFilter');
        if (!accountFilter) return;

        // Clear existing options except the first one (All Accounts)
        while (accountFilter.children.length > 1) {
            accountFilter.removeChild(accountFilter.lastChild);
        }

        // Add options for each account
        this.accountsData.forEach(account => {
            if (account.status === 'ACTIVE') {
                const option = document.createElement('option');
                option.value = account.id;
                option.textContent = `${account.accountType} - ****${account.accountNumber.slice(-4)}`;
                accountFilter.appendChild(option);
            }
        });
    }

    /**
     * Populate from account dropdown for transfer modal
     */
    populateFromAccountDropdown() {
        const fromAccountSelect = document.getElementById('fromAccount');
        if (!fromAccountSelect) return;

        // Clear existing options except the first one
        while (fromAccountSelect.children.length > 1) {
            fromAccountSelect.removeChild(fromAccountSelect.lastChild);
        }

        // Add options for each active account
        this.accountsData.forEach(account => {
            if (account.status === 'ACTIVE') {
                const option = document.createElement('option');
                option.value = account.id;
                option.textContent = `${account.accountType} - ${this.formatCurrency(account.balance, account.currency)} (****${account.accountNumber.slice(-4)})`;
                option.dataset.accountType = account.accountType;
                option.dataset.balance = account.balance;
                fromAccountSelect.appendChild(option);
            }
        });
    }

    /**
     * Get account data by ID (useful for transaction processing)
     */
    getAccountById(accountId) {
        return this.accountsData.find(account => account.id == accountId);
    }

    /**
     * Initialize transaction page specific functionality
     */
    initTransactionPage() {
        this.populateAccountFilter();
        this.populateFromAccountDropdown();
        
        // Pre-select account if URL parameter exists
        const urlParams = new URLSearchParams(window.location.search);
        const fromAccountId = urlParams.get('from');
        if (fromAccountId) {
            const fromAccountSelect = document.getElementById('fromAccount');
            if (fromAccountSelect) {
                fromAccountSelect.value = fromAccountId;
            }
        }
    }

    /**
     * Utility methods for styling and formatting
     */
    getAccountColor(accountType) {
        const type = accountType.toLowerCase();
        if (type.includes('savings')) return 'success';
        if (type.includes('checking')) return 'primary';
        if (type.includes('current')) return 'info';
        if (type.includes('fixed')) return 'warning';
        return 'secondary';
    }

    getAccountIcon(accountType) {
        const type = accountType.toLowerCase();
        if (type.includes('savings')) return 'fa-piggy-bank';
        if (type.includes('checking')) return 'fa-credit-card';
        if (type.includes('current')) return 'fa-university';
        if (type.includes('fixed')) return 'fa-lock';
        return 'fa-wallet';
    }

    getStatusColor(status) {
        switch (status) {
            case 'ACTIVE': return 'success';
            case 'PENDING_APPROVAL': return 'warning';
            case 'SUSPENDED': return 'danger';
            case 'CLOSED': return 'secondary';
            default: return 'secondary';
        }
    }

    formatCurrency(amount, currency = 'USD') {
        const numAmount = parseFloat(amount) || 0;
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency
        }).format(numAmount);
    }

    formatDate(dateString) {
        if (!dateString) return 'N/A';
        
        // Handle different date formats from backend
        let date;
        if (Array.isArray(dateString)) {
            // Handle LocalDateTime array format [year, month, day, hour, minute, second]
            date = new Date(dateString[0], dateString[1] - 1, dateString[2], 
                           dateString[3] || 0, dateString[4] || 0, dateString[5] || 0);
        } else {
            date = new Date(dateString);
        }
        
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    }

    /**
     * Show error message to user
     */
    showError(message) {
        const container = document.querySelector('.container-fluid');
        if (container) {
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger alert-dismissible fade show';
            alertDiv.innerHTML = `
                <i class="fas fa-exclamation-triangle"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            container.insertBefore(alertDiv, container.firstChild);
        }
    }
}

// Global functions for button actions (referenced in generated HTML)
function viewAccountDetails(accountId) {
    alert(`Viewing details for account ID: ${accountId}`);
    // TODO: Implement account details modal/page
}

function initiateTransfer(accountId) {
    window.location.href = `transactions.jsp?from=${accountId}`;
}

function generateStatement(accountId) {
    alert(`Generating statement for account ID: ${accountId}`);
    // TODO: Implement statement generation
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    const loader = new AccountDataLoader();
    loader.init();
    
    // Make loader globally available for transaction processing
    window.accountDataLoader = loader;
});

// Export for other scripts
window.AccountDataLoader = AccountDataLoader;
