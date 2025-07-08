// Main JavaScript file for BankAuto

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

// Application initialization
function initializeApp() {
    // Initialize sidebar toggle
    initializeSidebarToggle();
    
    // Initialize tooltips
    initializeTooltips();
    
    // Initialize smooth scrolling
    initializeSmoothScrolling();
    
    // Initialize form validation
    initializeFormValidation();
    
    // Initialize data tables
    initializeDataTables();
    
    // Initialize charts
    initializeCharts();
    
    // Initialize notifications
    initializeNotifications();
    
    // Initialize auto-refresh
    initializeAutoRefresh();
    
    console.log('BankAuto application initialized successfully');
}

// Sidebar toggle functionality
function initializeSidebarToggle() {
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebarToggleTop = document.getElementById('sidebarToggleTop');
    
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            document.body.classList.toggle('sidebar-toggled');
            const sidebar = document.querySelector('.sidebar');
            if (sidebar) {
                sidebar.classList.toggle('toggled');
            }
        });
    }
    
    if (sidebarToggleTop) {
        sidebarToggleTop.addEventListener('click', function() {
            document.body.classList.toggle('sidebar-toggled');
            const sidebar = document.querySelector('.sidebar');
            if (sidebar) {
                sidebar.classList.toggle('toggled');
            }
        });
    }
}

// Initialize Bootstrap tooltips
function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// Smooth scrolling for anchor links
function initializeSmoothScrolling() {
    const links = document.querySelectorAll('a[href^="#"]');
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Form validation
function initializeFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
}

// Initialize data tables
function initializeDataTables() {
    const tables = document.querySelectorAll('.data-table');
    tables.forEach(table => {
        // Add sorting functionality
        addTableSorting(table);
        
        // Add search functionality
        addTableSearch(table);
        
        // Add pagination
        addTablePagination(table);
    });
}

// Add table sorting
function addTableSorting(table) {
    const headers = table.querySelectorAll('th');
    headers.forEach((header, index) => {
        header.style.cursor = 'pointer';
        header.addEventListener('click', function() {
            sortTable(table, index);
        });
    });
}

// Sort table by column
function sortTable(table, columnIndex) {
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    rows.sort((a, b) => {
        const aValue = a.cells[columnIndex].textContent.trim();
        const bValue = b.cells[columnIndex].textContent.trim();
        
        // Check if values are numbers
        if (!isNaN(aValue) && !isNaN(bValue)) {
            return parseFloat(aValue) - parseFloat(bValue);
        }
        
        // Check if values are dates
        const aDate = new Date(aValue);
        const bDate = new Date(bValue);
        if (!isNaN(aDate) && !isNaN(bDate)) {
            return aDate - bDate;
        }
        
        // String comparison
        return aValue.localeCompare(bValue);
    });
    
    // Re-append sorted rows
    rows.forEach(row => tbody.appendChild(row));
}

// Add table search
function addTableSearch(table) {
    const searchInput = document.createElement('input');
    searchInput.type = 'text';
    searchInput.placeholder = 'Search...';
    searchInput.className = 'form-control mb-3';
    
    table.parentNode.insertBefore(searchInput, table);
    
    searchInput.addEventListener('keyup', function() {
        const filter = this.value.toLowerCase();
        const rows = table.querySelectorAll('tbody tr');
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(filter) ? '' : 'none';
        });
    });
}

// Add table pagination
function addTablePagination(table) {
    const rowsPerPage = 10;
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    if (rows.length <= rowsPerPage) return;
    
    const totalPages = Math.ceil(rows.length / rowsPerPage);
    let currentPage = 1;
    
    // Create pagination container
    const paginationContainer = document.createElement('nav');
    paginationContainer.innerHTML = `
        <ul class="pagination justify-content-center">
            <li class="page-item" id="prevPage">
                <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li class="page-item" id="nextPage">
                <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    `;
    
    table.parentNode.appendChild(paginationContainer);
    
    // Show page
    function showPage(page) {
        const startIndex = (page - 1) * rowsPerPage;
        const endIndex = startIndex + rowsPerPage;
        
        rows.forEach((row, index) => {
            row.style.display = (index >= startIndex && index < endIndex) ? '' : 'none';
        });
    }
    
    // Initialize first page
    showPage(1);
    
    // Add event listeners
    document.getElementById('prevPage').addEventListener('click', function(e) {
        e.preventDefault();
        if (currentPage > 1) {
            currentPage--;
            showPage(currentPage);
        }
    });
    
    document.getElementById('nextPage').addEventListener('click', function(e) {
        e.preventDefault();
        if (currentPage < totalPages) {
            currentPage++;
            showPage(currentPage);
        }
    });
}

// Initialize charts
function initializeCharts() {
    // Placeholder for chart initialization
    // This would integrate with Chart.js or similar library
    console.log('Charts initialized');
}

// Initialize notifications
function initializeNotifications() {
    // Check for new notifications
    checkForNotifications();
    
    // Set up notification sound
    setupNotificationSound();
}

// Check for new notifications
function checkForNotifications() {
    // This would make an AJAX call to check for new notifications
    // For now, we'll just log
    console.log('Checking for notifications');
}

// Setup notification sound
function setupNotificationSound() {
    // Create audio element for notification sound
    const audio = document.createElement('audio');
    audio.id = 'notificationSound';
    audio.src = 'data:audio/wav;base64,UklGRnoGAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQoGAACBhYqFbF1fdJivrJBhNjVgodDbq2EcBj+a2/LDciUFLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUCLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBzGY4PTBfCUC=';
    document.body.appendChild(audio);
}

// Play notification sound
function playNotificationSound() {
    const audio = document.getElementById('notificationSound');
    if (audio) {
        audio.play().catch(e => console.log('Could not play notification sound:', e));
    }
}

// Initialize auto-refresh
function initializeAutoRefresh() {
    // Auto-refresh data every 30 seconds
    setInterval(function() {
        refreshData();
    }, 30000);
}

// Refresh data
function refreshData() {
    // This would make AJAX calls to refresh data
    console.log('Refreshing data...');
}

// Utility functions
const Utils = {
    // Format currency
    formatCurrency: function(amount, currency = 'USD') {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency
        }).format(amount);
    },
    
    // Format date
    formatDate: function(date) {
        return new Intl.DateTimeFormat('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        }).format(new Date(date));
    },
    
    // Format date and time
    formatDateTime: function(date) {
        return new Intl.DateTimeFormat('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        }).format(new Date(date));
    },
    
    // Show loading spinner
    showLoading: function(element) {
        const spinner = document.createElement('div');
        spinner.className = 'text-center p-3';
        spinner.innerHTML = `
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        `;
        element.appendChild(spinner);
    },
    
    // Hide loading spinner
    hideLoading: function(element) {
        const spinner = element.querySelector('.spinner-border');
        if (spinner) {
            spinner.parentElement.remove();
        }
    },
    
    // Show toast notification
    showToast: function(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type} border-0`;
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', 'assertive');
        toast.setAttribute('aria-atomic', 'true');
        
        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        `;
        
        // Add to toast container or create one
        let toastContainer = document.querySelector('.toast-container');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
            document.body.appendChild(toastContainer);
        }
        
        toastContainer.appendChild(toast);
        
        // Initialize and show toast
        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();
        
        // Remove toast after it's hidden
        toast.addEventListener('hidden.bs.toast', function() {
            toast.remove();
        });
    },
    
    // Validate email
    validateEmail: function(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    },
    
    // Validate phone number
    validatePhone: function(phone) {
        const re = /^[\+]?[1-9][\d]{0,15}$/;
        return re.test(phone.replace(/\s/g, ''));
    },
    
    // Generate random ID
    generateId: function() {
        return Math.random().toString(36).substr(2, 9);
    },
    
    // Debounce function
    debounce: function(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    },
    
    // Throttle function
    throttle: function(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    }
};

// AJAX helper functions
const Ajax = {
    // GET request
    get: function(url, callback) {
        fetch(url)
            .then(response => response.json())
            .then(data => callback(null, data))
            .catch(error => callback(error));
    },
    
    // POST request
    post: function(url, data, callback) {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => callback(null, data))
            .catch(error => callback(error));
    },
    
    // PUT request
    put: function(url, data, callback) {
        fetch(url, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => callback(null, data))
            .catch(error => callback(error));
    },
    
    // DELETE request
    delete: function(url, callback) {
        fetch(url, {
            method: 'DELETE'
        })
            .then(response => response.json())
            .then(data => callback(null, data))
            .catch(error => callback(error));
    }
};

// Security helpers
const Security = {
    // Sanitize input
    sanitize: function(str) {
        const div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    },
    
    // Validate session
    validateSession: function() {
        // This would check if user session is still valid
        console.log('Validating session...');
    },
    
    // Auto-logout after inactivity
    setupAutoLogout: function(timeoutMinutes = 30) {
        let timeout;
        const resetTimeout = () => {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                alert('Session expired. You will be logged out.');
                window.location.href = 'logout.jsp';
            }, timeoutMinutes * 60 * 1000);
        };
        
        // Reset timeout on user activity
        document.addEventListener('mousemove', resetTimeout);
        document.addEventListener('keypress', resetTimeout);
        document.addEventListener('click', resetTimeout);
        
        // Initialize timeout
        resetTimeout();
    }
};

// Export for global use
window.BankAuto = {
    Utils,
    Ajax,
    Security,
    playNotificationSound,
    refreshData
};
