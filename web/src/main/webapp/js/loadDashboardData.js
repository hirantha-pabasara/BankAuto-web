/**
 * Dashboard Data Loader
 * Loads user account summary and recent transactions for dashboard
 */

class DashboardDataLoader {
    constructor() {
        this.baseUrl = window.location.origin + window.location.pathname.split('/')[1];
        this.accountsData = [];
        this.transactionsData = [];
    }

    /**
     * Initialize dashboard data loading
     */
    async init() {
        try {
            await this.loadDashboardData();
        } catch (error) {
            console.error('Failed to initialize dashboard data:', error);
            this.showError('Failed to load dashboard data. Please refresh the page.');
        }
    }

    /**
     * Load all dashboard data
     */
    async loadDashboardData() {
        try {
            // Load accounts data (reuse the same servlet)
            await this.loadUserAccounts();
            
            // Load recent transactions (you'll need to create this endpoint)
            // await this.loadRecentTransactions();
            
            this.updateDashboard();
            
        } catch (error) {
            console.error('Error loading dashboard data:', error);
            this.showError('Unable to load dashboard data. Please try again later.');
        }
    }


    async loadUserAccounts() {
        try {
            const response = await fetch(`account-details`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                credentials: 'same-origin'
            });

            if (!response.ok) {
                if (response.status === 401) {
                    window.location.href = '../user/login.jsp';
                    return;
                }
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            this.accountsData = await response.json();
            
        } catch (error) {
            console.error('Error loading accounts:', error);
            throw error;
        }
    }

    /**
     * Update dashboard with real data
     */
    updateDashboard() {
        this.updateAccountCards();
        this.updateRecentTransactions();
        this.hideWelcomeMessageIfHasAccounts();
    }

    /**
     * Update the four main cards with account data
     */
    updateAccountCards() {
        if (this.accountsData.length === 0) {
            // Keep welcome message visible if no accounts
            return;
        }

        // Calculate totals
        const totalBalance = this.accountsData.reduce((sum, account) => 
            sum + parseFloat(account.balance || 0), 0
        );

        const savingsAccounts = this.accountsData.filter(acc => 
            acc.accountType.toLowerCase().includes('savings')
        );
        const checkingAccounts = this.accountsData.filter(acc => 
            acc.accountType.toLowerCase().includes('checking')
        );

        const savingsBalance = savingsAccounts.reduce((sum, acc) => 
            sum + parseFloat(acc.balance || 0), 0
        );
        const checkingBalance = checkingAccounts.reduce((sum, acc) => 
            sum + parseFloat(acc.balance || 0), 0
        );

        // Update Total Balance Card
        this.updateCard('Total Balance', this.formatCurrency(totalBalance), 'primary', 'fa-dollar-sign');

        // Update Savings Card
        if (savingsAccounts.length > 0) {
            this.updateCard('Savings Account', this.formatCurrency(savingsBalance), 'success', 'fa-piggy-bank');
        } else {
            this.updateCard('Savings Account', 'No Account', 'success', 'fa-piggy-bank');
        }

        // Update Checking Card
        if (checkingAccounts.length > 0) {
            this.updateCard('Checking Account', this.formatCurrency(checkingBalance), 'info', 'fa-credit-card');
        } else {
            this.updateCard('Checking Account', 'No Account', 'info', 'fa-credit-card');
        }

        // Update Pending Transactions (placeholder for now)
        const pendingCount = this.accountsData.filter(acc => acc.status === 'PENDING_APPROVAL').length;
        this.updateCard('Pending Accounts', pendingCount.toString(), 'warning', 'fa-clock');
    }

    /**
     * Update a specific card
     */
    updateCard(title, value, colorClass, iconClass) {
        const cards = document.querySelectorAll('.card');
        
        for (let card of cards) {
            const titleElement = card.querySelector(`.text-${colorClass}`);
            if (titleElement && titleElement.textContent.includes(title.split(' ')[0])) {
                const valueElement = card.querySelector('.h5');
                if (valueElement) {
                    valueElement.textContent = value;
                }
                break;
            }
        }
    }

    /**
     * Update recent transactions table
     */
    updateRecentTransactions() {
        const transactionsTable = document.querySelector('#dataTable tbody');
        if (!transactionsTable) return;

        if (this.accountsData.length === 0) {
            transactionsTable.innerHTML = `
                <tr>
                    <td colspan="5" class="text-center text-muted py-4">
                        <i class="fas fa-info-circle"></i> No accounts available. Create an account to start banking.
                    </td>
                </tr>
            `;
            return;
        }

        // Show placeholder data for now (you can replace with real transaction data later)
        transactionsTable.innerHTML = `
            <tr>
                <td>
                    <div class="d-flex align-items-center">
                        <div class="icon-circle bg-success mr-3">
                            <i class="fas fa-arrow-down text-white"></i>
                        </div>
                        <div>
                            <div class="font-weight-bold">Deposit</div>
                            <div class="text-sm text-gray-500">Direct Deposit</div>
                        </div>
                    </div>
                </td>
                <td>${this.accountsData[0]?.accountNumber ? '****-' + this.accountsData[0].accountNumber.slice(-4) : 'N/A'}</td>
                <td class="text-success font-weight-bold">+$2,500.00</td>
                <td><span class="badge bg-success">Completed</span></td>
                <td>${new Date().toLocaleDateString()}</td>
            </tr>
            <tr>
                <td>
                    <div class="d-flex align-items-center">
                        <div class="icon-circle bg-primary mr-3">
                            <i class="fas fa-exchange-alt text-white"></i>
                        </div>
                        <div>
                            <div class="font-weight-bold">Transfer</div>
                            <div class="text-sm text-gray-500">Internal Transfer</div>
                        </div>
                    </div>
                </td>
                <td>${this.accountsData[0]?.accountNumber ? '****-' + this.accountsData[0].accountNumber.slice(-4) : 'N/A'}</td>
                <td class="text-primary font-weight-bold">$500.00</td>
                <td><span class="badge bg-success">Completed</span></td>
                <td>${new Date(Date.now() - 86400000).toLocaleDateString()}</td>
            </tr>
            <tr>
                <td>
                    <div class="d-flex align-items-center">
                        <div class="icon-circle bg-warning mr-3">
                            <i class="fas fa-shopping-cart text-white"></i>
                        </div>
                        <div>
                            <div class="font-weight-bold">Purchase</div>
                            <div class="text-sm text-gray-500">Online Payment</div>
                        </div>
                    </div>
                </td>
                <td>${this.accountsData[1]?.accountNumber ? '****-' + this.accountsData[1].accountNumber.slice(-4) : 'N/A'}</td>
                <td class="text-danger font-weight-bold">-$89.99</td>
                <td><span class="badge bg-success">Completed</span></td>
                <td>${new Date(Date.now() - 172800000).toLocaleDateString()}</td>
            </tr>
        `;
    }

    /**
     * Hide welcome message if user has accounts
     */
    hideWelcomeMessageIfHasAccounts() {
        const welcomeAlert = document.querySelector('.alert-success');
        if (welcomeAlert && this.accountsData.length > 0) {
            welcomeAlert.style.display = 'none';
        }
    }

    /**
     * Format currency
     */
    formatCurrency(amount, currency = 'USD') {
        const numAmount = parseFloat(amount) || 0;
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency
        }).format(numAmount);
    }

    /**
     * Show error message
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

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    const dashboardLoader = new DashboardDataLoader();
    dashboardLoader.init();
});

// Export for other scripts
window.DashboardDataLoader = DashboardDataLoader;
