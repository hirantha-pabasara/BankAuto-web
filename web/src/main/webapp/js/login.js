/**
 * User Login JavaScript
 * Handles form validation and submission using fetch API
 * Sends JSON data compatible with Gson on the backend
 */

// Form validation function
function validateLoginForm() {
    const login = document.getElementById('login').value.trim();
    const password = document.getElementById('password').value;
    
    // Login field validation (username or email)
    if (login.length === 0) {
        showError('Please enter your username or email address.');
        return false;
    }
    
    // Password validation
    if (password.length === 0) {
        showError('Please enter your password.');
        return false;
    }
    
    if (password.length < 8) {
        showError('Password must be at least 8 characters long.');
        return false;
    }
    
    return true;
}

// Function to collect login data in JSON format
function collectLoginData() {
    return {
        login: document.getElementById('login').value.trim(),
        password: document.getElementById('password').value
    };
}

// Main function to handle login form submission
async function handleLogin(event) {
    event.preventDefault();
    
    // Validate form first
    if (!validateLoginForm()) {
        return false;
    }
    
    // Show loading state
    const submitButton = document.querySelector('button[type="submit"]');
    const originalButtonText = submitButton.innerHTML;
    submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
    submitButton.disabled = true;
    
    try {
        // Collect login data
        const loginData = collectLoginData();
        
        console.log('Sending login data:', loginData);
        
        // Send login request using fetch
        const response = await fetch('../user/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(loginData)
        });
        
        // Handle response
        if (response.ok) {
            try {
                const result = await response.json();
                
                if (result && result.success) {
                    showSuccess(result.message || 'Login successful! Redirecting...');
                    setTimeout(() => {
                        window.location.href = 'dashboard.jsp';
                    }, 1500);
                } else {
                    showError(result?.message || 'Invalid username/email or password.');
                }
            } catch (jsonError) {
                // Handle case where servlet doesn't send JSON response
                console.error('JSON parsing error:', jsonError);
                if (response.status === 200) {
                    showSuccess('Login successful! Redirecting...');
                    setTimeout(() => {
                        window.location.href = 'dashboard.jsp';
                    }, 1500);
                } else {
                    showError('Login failed. Please try again.');
                }
            }
        } else {
            // Handle HTTP error responses
            try {
                const errorData = await response.json();
                showError(errorData?.message || `Login failed (${response.status})`);
            } catch (jsonError) {
                showError(`Login failed (${response.status})`);
            }
        }
        
    } catch (error) {
        console.error('Login error:', error);
        showError('Network error. Please check your connection and try again.');
    } finally {
        // Reset button state
        submitButton.innerHTML = originalButtonText;
        submitButton.disabled = false;
    }
    
    return false;
}

// Alternative function for form-based submission (fallback)
async function submitLoginAjax() {
    if (!validateLoginForm()) {
        return false;
    }
    
    const loginData = collectLoginData();
    
    try {
        const response = await fetch('/user/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(loginData)
        });
        
        try {
            const result = await response.json();
            
            if (result && result.success) {
                alert(result.message || 'Login successful!');
                window.location.href = 'dashboard.jsp';
            } else {
                alert(result?.message || 'Login failed');
            }
        } catch (jsonError) {
            // Handle case where servlet doesn't send JSON response
            if (response.ok) {
                alert('Login successful!');
                window.location.href = 'dashboard.jsp';
            } else {
                alert('Login failed');
            }
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Network error occurred');
    }
    
    return false;
}

// Utility function to show error messages
function showError(message) {
    hideAllMessages();
    const errorDiv = document.createElement('div');
    errorDiv.className = 'alert alert-danger alert-dismissible fade show';
    errorDiv.innerHTML = `
        <i class="fas fa-exclamation-circle"></i>
        <strong>Error:</strong> ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    const form = document.querySelector('.user');
    if (form) {
        form.parentNode.insertBefore(errorDiv, form);
    }
}

// Utility function to show success messages
function showSuccess(message) {
    hideAllMessages();
    const successDiv = document.createElement('div');
    successDiv.className = 'alert alert-success alert-dismissible fade show';
    successDiv.innerHTML = `
        <i class="fas fa-check-circle"></i>
        <strong>Success:</strong> ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    const form = document.querySelector('.user');
    if (form) {
        form.parentNode.insertBefore(successDiv, form);
    }
}

// Utility function to hide all messages
function hideAllMessages() {
    const alerts = document.querySelectorAll('.alert-danger, .alert-success');
    alerts.forEach(alert => {
        alert.remove();
    });
}

// Real-time validation functions
function validateLoginField() {
    const login = document.getElementById('login').value.trim();
    const loginField = document.getElementById('login');
    
    if (login.length > 0) {
        // Basic validation - just check if it's not empty
        setFieldSuccess(loginField);
    } else {
        clearFieldStatus(loginField);
    }
}

function validatePasswordField() {
    const password = document.getElementById('password').value;
    const passwordField = document.getElementById('password');
    
    if (password.length > 0) {
        if (password.length < 8) {
            setFieldError(passwordField, 'Password must be at least 8 characters long');
        } else {
            setFieldSuccess(passwordField);
        }
    } else {
        clearFieldStatus(passwordField);
    }
}

// Field validation helper functions
function setFieldError(field, message) {
    field.classList.remove('is-valid');
    field.classList.add('is-invalid');
    
    let feedback = field.parentNode.querySelector('.invalid-feedback');
    if (!feedback) {
        feedback = document.createElement('div');
        feedback.className = 'invalid-feedback';
        field.parentNode.appendChild(feedback);
    }
    feedback.textContent = message;
}

function setFieldSuccess(field) {
    field.classList.remove('is-invalid');
    field.classList.add('is-valid');
    
    const feedback = field.parentNode.querySelector('.invalid-feedback');
    if (feedback) {
        feedback.remove();
    }
}

function clearFieldStatus(field) {
    field.classList.remove('is-invalid', 'is-valid');
    const feedback = field.parentNode.querySelector('.invalid-feedback');
    if (feedback) {
        feedback.remove();
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Attach form submit handler
    const form = document.querySelector('.user');
    if (form) {
        form.addEventListener('submit', handleLogin);
    }
    
    // Attach real-time validation
    const loginField = document.getElementById('login');
    const passwordField = document.getElementById('password');
    
    if (loginField) {
        loginField.addEventListener('blur', validateLoginField);
    }
    
    if (passwordField) {
        passwordField.addEventListener('blur', validatePasswordField);
    }
});

// Function for forgot password functionality
function forgotPassword() {
    const email = prompt('Please enter your email address:');
    if (email && email.trim()) {
        // Basic email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('Please enter a valid email address.');
            return;
        }
        
        // TODO: Implement actual password reset functionality
        // You can create a separate servlet for this
        alert('Password reset instructions have been sent to ' + email);
        
        // Example of how you might implement this:
        /*
        fetch('/user/forgot-password', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: email })
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
                alert('Password reset instructions have been sent to ' + email);
            } else {
                alert('Error: ' + result.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred. Please try again.');
        });
        */
    }
}
