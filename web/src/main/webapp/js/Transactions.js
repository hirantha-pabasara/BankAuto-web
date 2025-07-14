/**
 * BankAuto Transaction Management System
 * Implements transfer processing functionality
 * Works with backend EJB services and account management
 */

// Configuration
const TRANSACTION_CONFIG = {
    BASE_PATH: '../api', // Relative to current context (/bankauto/user/)
    ENDPOINTS: {
        PROCESS_TRANSFER: '/transfers/process'
    }
};

// Global variables
let transferInProgress = false;
let userAccounts = [];

/**
 * Initialize page when DOM is loaded
 */
document.addEventListener('DOMContentLoaded', function() {
    initializePage();
});

/**
 * Initialize all page functionality
 */
function initializePage() {
    loadUserAccounts();
    setupFormValidation();
    setupModalEvents();
    initializeTransferModal();
    setupRealTimeValidation();
}

/**
 * Setup modal event listeners
 */
function setupModalEvents() {
    // Add event listener for transfer modal
    const transferModal = document.getElementById('transferModal');
    if (transferModal) {
        transferModal.addEventListener('shown.bs.modal', function () {
            // Check if accounts are loaded, if not, load them
            const fromAccountSelect = document.getElementById('fromAccount');
            if (fromAccountSelect && fromAccountSelect.options.length <= 1) {
                loadUserAccounts();
            }
            // Focus on first input
            const firstInput = document.getElementById('fromAccount');
            if (firstInput) {
                firstInput.focus();
            }
        });

        transferModal.addEventListener('hidden.bs.modal', function () {
            resetTransferForm();
        });
    }
}

/**
 * Load user accounts from backend servlet
 */
async function loadUserAccounts() {
    try {
        const response = await fetch('account-details', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            credentials: 'same-origin'
        });
        
        if (response.status === 401) {
            // User not authenticated, redirect to login
            window.location.href = '../login.jsp';
            return;
        }
        
        if (!response.ok) {
            throw new Error('Failed to load accounts: ' + response.status);
        }
        
        const accounts = await response.json();
        
        if (accounts && Array.isArray(accounts)) {
            userAccounts = accounts; // Store globally for transfer functionality
            populateAccountDropdowns(accounts);
        } else {
            throw new Error('Invalid accounts data received');
        }
        
    } catch (error) {
        console.error('Error in account loading process:', error);
        
        // Fall back to showing an error message or empty dropdowns
        const fromAccountSelect = document.getElementById('fromAccount');
        const accountFilterSelect = document.getElementById('accountFilter');
        
        if (fromAccountSelect) {
            fromAccountSelect.innerHTML = '<option value="">Unable to load accounts</option>';
        }
        
        if (accountFilterSelect) {
            // Keep the "All Accounts" option
            accountFilterSelect.innerHTML = '<option value="all">All Accounts</option><option value="">Unable to load accounts</option>';
        }
        
        // Show user-friendly error
        showError('Unable to load your accounts. Please refresh the page or contact support.');
    }
}

/**
 * Populate account dropdowns with user's accounts
 */
function populateAccountDropdowns(accounts) {
    const fromAccountSelect = document.getElementById('fromAccount');
    const accountFilterSelect = document.getElementById('accountFilter');
    
    // Clear existing options
    if (fromAccountSelect) {
        fromAccountSelect.innerHTML = '<option value="">Select Account</option>';
    }
    
    // Validate accounts data
    if (!accounts || !Array.isArray(accounts)) {
        if (fromAccountSelect) {
            fromAccountSelect.innerHTML = '<option value="">No accounts data available</option>';
        }
        return;
    }
    
    // Filter only active accounts for transfers
    const activeAccounts = accounts.filter(account => 
        account && account.status && account.status.toUpperCase() === 'ACTIVE'
    );
    
    // Populate fromAccount dropdown if it exists
    if (fromAccountSelect && activeAccounts.length > 0) {
        activeAccounts.forEach(account => {
            try {
                const option = document.createElement('option');
                option.value = account.id || account.accountId;
                option.dataset.balance = account.balance || 0;
                option.dataset.accountNumber = account.accountNumber || '';
                option.dataset.accountType = account.accountType || 'Unknown';
                
                // Format account display: "Account Type ****1234 - $5,500.00"
                const accountNumber = account.accountNumber || '';
                const maskedNumber = accountNumber.length >= 4 ? 
                    '****' + accountNumber.slice(-4) : 
                    accountNumber;
                
                const balance = parseFloat(account.balance) || 0;
                const formattedBalance = balance.toLocaleString('en-US', {
                    style: 'currency',
                    currency: 'USD'
                });
                
                const accountType = account.accountType || 'Account';
                option.textContent = `${accountType} ${maskedNumber} - ${formattedBalance}`;
                fromAccountSelect.appendChild(option);
            } catch (error) {
                console.error('Error creating account option:', error, account);
            }
        });
    } else if (fromAccountSelect) {
        const message = activeAccounts.length === 0 ? 
            'No active accounts available' : 
            'No accounts found';
        fromAccountSelect.innerHTML = `<option value="">${message}</option>`;
    }
    
    // Populate account filter dropdown if it exists
    if (accountFilterSelect && accounts.length > 0) {
        // Keep the existing "All Accounts" option and add user accounts
        accounts.forEach(account => {
            try {
                const option = document.createElement('option');
                option.value = account.id || account.accountId;
                const accountNumber = account.accountNumber || '';
                const maskedNumber = accountNumber.length >= 4 ? 
                    '****' + accountNumber.slice(-4) : 
                    accountNumber;
                const accountType = account.accountType || 'Account';
                option.textContent = `${accountType} ${maskedNumber}`;
                accountFilterSelect.appendChild(option);
            } catch (error) {
                console.error('Error creating filter option:', error, account);
            }
        });
    }
}

/**
 * Handle transfer type change to show/hide relevant fields
 */
function handleTransferTypeChange() {
    const transferType = document.getElementById('transferType');
    const scheduledFields = document.getElementById('scheduledFields');
    const recurringFields = document.getElementById('recurringFields');
    const scheduledDateTime = document.getElementById('scheduledDateTime');
    const startDate = document.getElementById('startDate');
    
    if (!transferType) return;
    
    const typeValue = transferType.value;
    
    // Hide all conditional fields
    if (scheduledFields) scheduledFields.style.display = 'none';
    if (recurringFields) recurringFields.style.display = 'none';
    
    // Remove required attributes
    if (scheduledDateTime) scheduledDateTime.required = false;
    if (startDate) startDate.required = false;
    
    // Show relevant fields based on selection
    if (typeValue === 'SCHEDULED' && scheduledFields && scheduledDateTime) {
        scheduledFields.style.display = 'block';
        scheduledDateTime.required = true;
        
        // Set minimum datetime to current time + 1 hour
        const now = new Date();
        now.setHours(now.getHours() + 1);
        scheduledDateTime.min = now.toISOString().slice(0, 16);
        
    } else if (typeValue === 'RECURRING' && recurringFields && startDate) {
        recurringFields.style.display = 'block';
        startDate.required = true;
        
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        startDate.min = today;
        
        // Set minimum end date to start date + frequency
        const endDate = document.getElementById('endDate');
        if (endDate) endDate.min = today;
    }
    
    // Clear validation classes
    if (scheduledDateTime) {
        scheduledDateTime.classList.remove('is-invalid', 'is-valid');
    }
    if (startDate) {
        startDate.classList.remove('is-invalid', 'is-valid');
    }
}

/**
 * Process transfer with comprehensive validation and error handling
 */
async function processTransfer() {
    if (transferInProgress) {
        return;
    }

    // Clear previous messages
    hideMessages();

    // Validate form
    const validationResult = validateTransferForm();
    
    if (!validationResult.isValid) {
        showError(validationResult.errors.join('<br>'));
        highlightInvalidFields(validationResult.invalidFields);
        return;
    }

    // Set loading state
    setTransferLoading(true);
    transferInProgress = true;

    try {
        // Prepare transfer data
        const transferData = prepareTransferData();
        
        // Send to backend
        const apiUrl = TRANSACTION_CONFIG.BASE_PATH + TRANSACTION_CONFIG.ENDPOINTS.PROCESS_TRANSFER;
        const response = await fetch(apiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            credentials: 'same-origin',
            body: JSON.stringify(transferData)
        });
        
        if (!response.ok) {
            throw new Error(`Backend error: ${response.status}`);
        }
        
        const result = await response.json();
        
        if (result.success) {
            showSuccess(buildSuccessMessage(result, transferData.transferType));
            resetTransferForm();
            
            // Refresh account data and page content
            setTimeout(() => {
                closeTransferModal();
                refreshPageContent();
            }, 1500);
        } else {
            showError(result.message || 'Transfer failed');
        }
        
    } catch (error) {
        console.error('Error during transfer processing:', error);
        showError('Unable to process transfer. Please check your connection and try again.');
    } finally {
        setTransferLoading(false);
        transferInProgress = false;
    }
}

/**
 * Comprehensive form validation
 */
function validateTransferForm() {
    const errors = [];
    const invalidFields = [];

    // Basic field validation
    const formFields = {
        fromAccount: document.getElementById('fromAccount').value,
        toAccount: document.getElementById('toAccount').value.trim(),
        amount: parseFloat(document.getElementById('amount').value),
        transferType: document.getElementById('transferType').value
    };

    // Validate source account
    if (!formFields.fromAccount) {
        errors.push('Please select a source account');
        invalidFields.push('fromAccount');
    }

    // Validate destination account
    if (!formFields.toAccount) {
        errors.push('Please enter destination account or email');
        invalidFields.push('toAccount');
    } else if (!isValidAccountOrEmail(formFields.toAccount)) {
        errors.push('Please enter a valid account number or email address');
        invalidFields.push('toAccount');
    }

    // Validate amount
    if (!formFields.amount || formFields.amount <= 0) {
        errors.push('Please enter a valid amount');
        invalidFields.push('amount');
    } else if (formFields.amount > 1000000) {
        errors.push('Amount exceeds maximum transfer limit of $1,000,000');
        invalidFields.push('amount');
    }

    // Check sufficient balance
    if (formFields.fromAccount && formFields.amount > 0) {
        const selectedAccount = document.querySelector(`#fromAccount option[value="${formFields.fromAccount}"]`);
        if (selectedAccount) {
            const accountBalance = parseFloat(selectedAccount.dataset.balance);
            
            if (formFields.amount > accountBalance) {
                errors.push('Insufficient balance for this transfer');
                invalidFields.push('amount');
            }
        }
    }

    // Validate transfer type specific fields
    if (formFields.transferType === 'SCHEDULED') {
        const scheduledDateTime = document.getElementById('scheduledDateTime');
        if (scheduledDateTime && !scheduledDateTime.value) {
            errors.push('Please select a scheduled date and time');
            invalidFields.push('scheduledDateTime');
        } else if (scheduledDateTime && new Date(scheduledDateTime.value) <= new Date()) {
            errors.push('Scheduled date must be at least 1 hour in the future');
            invalidFields.push('scheduledDateTime');
        }
    } else if (formFields.transferType === 'RECURRING') {
        const startDate = document.getElementById('startDate');
        const endDate = document.getElementById('endDate');
        
        if (startDate && !startDate.value) {
            errors.push('Please select a start date for recurring transfer');
            invalidFields.push('startDate');
        } else if (startDate && new Date(startDate.value) < new Date().setHours(0,0,0,0)) {
            errors.push('Start date cannot be in the past');
            invalidFields.push('startDate');
        }
        
        if (endDate && startDate && endDate.value && new Date(endDate.value) <= new Date(startDate.value)) {
            errors.push('End date must be after start date');
            invalidFields.push('endDate');
        }
    }

    return {
        isValid: errors.length === 0,
        errors: errors,
        invalidFields: invalidFields
    };
}

/**
 * Validate account number or email format
 */
function isValidAccountOrEmail(input) {
    // Account number pattern (e.g., ACC1234567890, SAV1234567890)
    const accountPattern = /^[A-Z]{3}\d{10}$/;
    
    // Email pattern
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    return accountPattern.test(input) || emailPattern.test(input);
}

/**
 * Prepare transfer data for backend submission
 */
function prepareTransferData() {
    const transferType = document.getElementById('transferType').value;
    const selectedAccount = document.querySelector(`#fromAccount option[value="${document.getElementById('fromAccount').value}"]`);
    
    const baseData = {
        fromAccountId: parseInt(document.getElementById('fromAccount').value),
        fromAccountNumber: selectedAccount ? selectedAccount.dataset.accountNumber : '',
        toAccount: document.getElementById('toAccount').value.trim(),
        amount: parseFloat(document.getElementById('amount').value),
        description: document.getElementById('description').value.trim() || null,
        transferType: transferType,
        timestamp: new Date().toISOString()
    };

    // Add scheduling information based on transfer type
    if (transferType === 'SCHEDULED') {
        const scheduledDateTime = document.getElementById('scheduledDateTime');
        if (scheduledDateTime) {
            baseData.scheduledDateTime = scheduledDateTime.value;
        }
    } else if (transferType === 'RECURRING') {
        const startDate = document.getElementById('startDate');
        const frequency = document.getElementById('frequency');
        const endDate = document.getElementById('endDate');
        
        if (startDate) baseData.startDate = startDate.value;
        if (frequency) baseData.frequency = frequency.value;
        if (endDate && endDate.value) baseData.endDate = endDate.value;
    }

    return baseData;
}

/**
 * Build success message based on transfer type
 */
function buildSuccessMessage(result, transferType) {
    let message = 'Transfer ' + (result.referenceNumber ? 'reference: ' + result.referenceNumber : 'processed successfully');
    
    switch (transferType) {
        case 'IMMEDIATE':
            message += '<br><strong>Your transfer has been processed immediately.</strong>';
            break;
        case 'SCHEDULED':
            message += '<br><strong>Your transfer has been scheduled and will be processed automatically using EJB Timer Services.</strong>';
            break;
        case 'RECURRING':
            message += '<br><strong>Your recurring transfer has been set up and will be processed automatically according to the schedule using EJB Timer Services.</strong>';
            break;
    }
    
    return message;
}

/**
 * Setup real-time form validation
 */
function setupRealTimeValidation() {
    const amountInput = document.getElementById('amount');
    const fromAccountSelect = document.getElementById('fromAccount');
    const toAccountInput = document.getElementById('toAccount');
    
    if (!amountInput || !fromAccountSelect || !toAccountInput) return;
    
    // Real-time balance validation
    function validateBalanceReal() {
        const selectedAccount = document.querySelector('#fromAccount option[value="' + fromAccountSelect.value + '"]');
        const amount = parseFloat(amountInput.value);
        
        if (selectedAccount && amount > 0) {
            const balance = parseFloat(selectedAccount.dataset.balance);
            const warningDiv = document.getElementById('amountWarning');
            
            if (warningDiv && amount > balance) {
                amountInput.classList.add('validation-error');
                warningDiv.textContent = 'Insufficient balance. Available: $' + balance.toFixed(2);
                warningDiv.style.display = 'block';
            } else if (warningDiv) {
                amountInput.classList.remove('validation-error');
                warningDiv.style.display = 'none';
            }
        }
    }
    
    // Real-time account/email validation
    function validateToAccountReal() {
        const value = toAccountInput.value.trim();
        if (value.length > 0) {
            if (isValidAccountOrEmail(value)) {
                toAccountInput.classList.remove('validation-error');
                toAccountInput.classList.add('is-valid');
            } else {
                toAccountInput.classList.add('validation-error');
                toAccountInput.classList.remove('is-valid');
            }
        } else {
            toAccountInput.classList.remove('validation-error', 'is-valid');
        }
    }
    
    // Update balance info when account changes
    function updateBalanceInfoReal() {
        const selectedAccount = document.querySelector('#fromAccount option[value="' + fromAccountSelect.value + '"]');
        const balanceInfo = document.getElementById('balanceInfo');
        
        if (selectedAccount && balanceInfo) {
            const balance = parseFloat(selectedAccount.dataset.balance);
            const accountType = selectedAccount.dataset.accountType;
            balanceInfo.innerHTML = 'Available Balance: <strong>$' + balance.toFixed(2) + '</strong> | Type: ' + accountType;
            balanceInfo.style.display = 'block';
        } else if (balanceInfo) {
            balanceInfo.style.display = 'none';
        }
        
        validateBalanceReal();
    }
    
    // Attach event listeners
    amountInput.addEventListener('input', validateBalanceReal);
    fromAccountSelect.addEventListener('change', updateBalanceInfoReal);
    toAccountInput.addEventListener('input', validateToAccountReal);
    toAccountInput.addEventListener('blur', validateToAccountReal);
}

/**
 * Highlight invalid fields
 */
function highlightInvalidFields(fieldNames) {
    // Clear all validation classes first
    const allInputs = document.querySelectorAll('#transferForm input, #transferForm select');
    allInputs.forEach(input => {
        input.classList.remove('is-invalid', 'is-valid');
    });
    
    // Highlight invalid fields
    fieldNames.forEach(fieldName => {
        const field = document.getElementById(fieldName);
        if (field) {
            field.classList.add('is-invalid');
        }
    });
}

/**
 * Initialize transfer modal settings
 */
function initializeTransferModal() {
    // Modal event listeners are handled in setupModalEvents()
}

/**
 * Reset transfer form to initial state
 */
function resetTransferForm() {
    const form = document.getElementById('transferForm');
    if (!form) return;
    
    form.reset();
    
    // Hide conditional fields
    const scheduledFields = document.getElementById('scheduledFields');
    const recurringFields = document.getElementById('recurringFields');
    
    if (scheduledFields) scheduledFields.style.display = 'none';
    if (recurringFields) recurringFields.style.display = 'none';
    
    // Remove required attributes
    const scheduledDateTime = document.getElementById('scheduledDateTime');
    const startDate = document.getElementById('startDate');
    
    if (scheduledDateTime) scheduledDateTime.required = false;
    if (startDate) startDate.required = false;
    
    // Clear validation classes
    const inputs = form.querySelectorAll('input, select');
    inputs.forEach(input => {
        input.classList.remove('is-invalid', 'is-valid', 'validation-error');
    });
    
    // Hide messages and warnings
    hideMessages();
    
    const amountWarning = document.getElementById('amountWarning');
    const balanceInfo = document.getElementById('balanceInfo');
    
    if (amountWarning) amountWarning.style.display = 'none';
    if (balanceInfo) balanceInfo.style.display = 'none';
    
    // Reset loading state
    setTransferLoading(false);
    transferInProgress = false;
}

/**
 * Show error message
 */
function showError(message) {
    const errorDiv = document.getElementById('transferError');
    const errorMessage = document.getElementById('errorMessage');
    
    if (errorDiv && errorMessage) {
        errorMessage.innerHTML = message;
        errorDiv.style.display = 'block';
        
        const successDiv = document.getElementById('transferSuccess');
        if (successDiv) successDiv.style.display = 'none';
        
        // Scroll to error message
        errorDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    } else {
        // Fallback to alert if error elements don't exist
        alert(message.replace(/<br>/g, '\n'));
    }
}

/**
 * Show success message
 */
function showSuccess(message) {
    const successDiv = document.getElementById('transferSuccess');
    const successMessage = document.getElementById('successMessage');
    
    if (successDiv && successMessage) {
        successMessage.innerHTML = message;
        successDiv.style.display = 'block';
        
        const errorDiv = document.getElementById('transferError');
        if (errorDiv) errorDiv.style.display = 'none';
        
        // Scroll to success message
        successDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    } else {
        // Fallback to alert if success elements don't exist
        alert(message.replace(/<br>/g, '\n').replace(/<\/?strong>/g, ''));
    }
}

/**
 * Hide all messages
 */
function hideMessages() {
    const errorDiv = document.getElementById('transferError');
    const successDiv = document.getElementById('transferSuccess');
    
    if (errorDiv) errorDiv.style.display = 'none';
    if (successDiv) successDiv.style.display = 'none';
}

/**
 * Set loading state for transfer button
 */
function setTransferLoading(loading) {
    const button = document.getElementById('transferButton');
    const buttonText = document.getElementById('transferButtonText');
    const spinner = document.getElementById('transferSpinner');
    
    if (button && buttonText) {
        if (loading) {
            button.disabled = true;
            buttonText.textContent = 'Processing...';
            if (spinner) spinner.style.display = 'inline-block';
        } else {
            button.disabled = false;
            buttonText.textContent = 'Process Transfer';
            if (spinner) spinner.style.display = 'none';
        }
    }
}

/**
 * Close transfer modal
 */
function closeTransferModal() {
    const modal = bootstrap.Modal.getInstance(document.getElementById('transferModal'));
    if (modal) {
        modal.hide();
    }
}

/**
 * Refresh page content after successful transaction
 */
function refreshPageContent() {
    try {
        // Reload user accounts data
        loadUserAccounts();
        
        // If we're on a dashboard or account page, refresh the data
        if (typeof refreshAccountData === 'function') {
            refreshAccountData();
        }
        
        // If we're on the transactions page, refresh transaction history
        if (typeof refreshTransactionHistory === 'function') {
            refreshTransactionHistory();
        }
        
        // Update any balance displays
        updateAllBalanceDisplays();
        
        // Show success notification
        showTransactionCompleteNotification();
        
    } catch (error) {
        console.error('Error refreshing page content:', error);
        // Fallback: reload the entire page
        window.location.reload();
    }
}

/**
 * Update all balance displays on the page
 */
function updateAllBalanceDisplays() {
    // Update account balance cards
    const balanceCards = document.querySelectorAll('[data-account-balance]');
    balanceCards.forEach(card => {
        const accountId = card.dataset.accountId;
        if (accountId && userAccounts) {
            const account = userAccounts.find(acc => acc.id == accountId);
            if (account) {
                const balanceElement = card.querySelector('.balance-amount, .h5, .font-weight-bold');
                if (balanceElement) {
                    balanceElement.textContent = new Intl.NumberFormat('en-US', {
                        style: 'currency',
                        currency: 'USD'
                    }).format(account.balance);
                }
            }
        }
    });
}

/**
 * Show transaction completion notification
 */
function showTransactionCompleteNotification() {
    // Create a toast notification
    const toastHtml = `
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" 
             style="position: fixed; top: 20px; right: 20px; z-index: 9999;">
            <div class="toast-header bg-success text-white">
                <i class="fas fa-check-circle me-2"></i>
                <strong class="me-auto">Transaction Complete</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                Your transaction has been processed successfully. Account balances have been updated.
            </div>
        </div>
    `;
    
    document.body.insertAdjacentHTML('beforeend', toastHtml);
    const toast = document.querySelector('.toast:last-child');
    const bsToast = new bootstrap.Toast(toast);
    bsToast.show();
    
    // Remove toast after it's hidden
    toast.addEventListener('hidden.bs.toast', () => {
        toast.remove();
    });
}

/**
 * Setup form validation for balance checking and field validation
 */
function setupFormValidation() {
    // Add real-time validation for amount and account selection
    const fromAccountSelect = document.getElementById('fromAccount');
    const amountInput = document.getElementById('amount');
    
    if (fromAccountSelect) {
        fromAccountSelect.addEventListener('change', updateBalanceInfo);
    }
    
    if (amountInput) {
        amountInput.addEventListener('input', validateBalance);
        amountInput.addEventListener('blur', validateBalance);
    }

    // Setup transfer form submission
    const form = document.getElementById('transferForm');
    if (form) {
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            processTransfer();
        });
        
        // Add Bootstrap validation classes
        const inputs = form.querySelectorAll('input, select');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.checkValidity()) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-valid');
                    this.classList.add('is-invalid');
                }
            });
        });
    }
}

/**
 * Update balance information when account is selected
 */
function updateBalanceInfo() {
    const fromAccountSelect = document.getElementById('fromAccount');
    const balanceInfo = document.getElementById('balanceInfo');
    
    if (!fromAccountSelect || !balanceInfo) return;
    
    const selectedOption = fromAccountSelect.options[fromAccountSelect.selectedIndex];
    
    if (selectedOption && selectedOption.value && selectedOption.dataset.balance) {
        const balance = parseFloat(selectedOption.dataset.balance);
        const accountType = selectedOption.dataset.accountType;
        
        const formattedBalance = balance.toLocaleString('en-US', {
            style: 'currency',
            currency: 'USD'
        });
        
        balanceInfo.innerHTML = `Available Balance: <strong>${formattedBalance}</strong> | Type: ${accountType}`;
        balanceInfo.style.display = 'block';
        balanceInfo.className = 'balance-info mt-1 text-success';
    } else {
        balanceInfo.style.display = 'none';
    }
    
    // Re-validate amount if it has a value
    validateBalance();
}

/**
 * Validate that transfer amount doesn't exceed account balance
 */
function validateBalance() {
    const fromAccountSelect = document.getElementById('fromAccount');
    const amountInput = document.getElementById('amount');
    const amountWarning = document.getElementById('amountWarning');
    
    if (!fromAccountSelect || !amountInput || !amountWarning) return;
    
    const selectedOption = fromAccountSelect.options[fromAccountSelect.selectedIndex];
    const amount = parseFloat(amountInput.value);
    
    if (selectedOption && selectedOption.value && selectedOption.dataset.balance && amount > 0) {
        const balance = parseFloat(selectedOption.dataset.balance);
        
        if (amount > balance) {
            amountInput.classList.add('validation-error');
            amountWarning.textContent = `Insufficient balance. Available: ${balance.toLocaleString('en-US', {
                style: 'currency',
                currency: 'USD'
            })}`;
            amountWarning.style.display = 'block';
            amountWarning.className = 'amount-warning mt-1 text-danger';
        } else {
            amountInput.classList.remove('validation-error');
            amountWarning.style.display = 'none';
        }
    } else if (amount > 0) {
        amountInput.classList.remove('validation-error');
        amountWarning.style.display = 'none';
    }
}

/**
 * Safety mechanism to reset UI if transfer gets stuck
 */
function setupTransferSafetyMechanism() {
    // Set a maximum timeout for any transfer operation
    const MAX_TRANSFER_TIME = 60000; // 60 seconds
    let transferTimeoutId;
    
    // Override the original processTransfer to add safety timeout
    const originalProcessTransfer = window.processTransfer;
    if (typeof originalProcessTransfer === 'function') {
        window.processTransfer = function() {
            // Clear any existing timeout
            if (transferTimeoutId) {
                clearTimeout(transferTimeoutId);
            }
            
            // Set safety timeout
            transferTimeoutId = setTimeout(() => {
                console.error('Transfer operation timed out after 60 seconds - resetting UI');
                setTransferLoading(false);
                transferInProgress = false;
                showError('Transfer operation timed out. Please try again.');
                
                // Re-enable all form elements
                const form = document.getElementById('transferForm');
                if (form) {
                    const inputs = form.querySelectorAll('input, select, button');
                    inputs.forEach(input => {
                        input.disabled = false;
                    });
                }
            }, MAX_TRANSFER_TIME);
            
            // Call original function
            try {
                return originalProcessTransfer.apply(this, arguments);
            } catch (error) {
                // Clear timeout on immediate error
                if (transferTimeoutId) {
                    clearTimeout(transferTimeoutId);
                }
                throw error;
            }
        };
    }
    
    // Clear timeout when transfer completes successfully
    const originalSetTransferLoading = setTransferLoading;
    setTransferLoading = function(loading) {
        if (!loading && transferTimeoutId) {
            clearTimeout(transferTimeoutId);
            transferTimeoutId = null;
        }
        return originalSetTransferLoading(loading);
    };
}

// Initialize safety mechanism when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    setupTransferSafetyMechanism();
});



