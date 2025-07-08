/**
 * User Registration JavaScript
 * Handles form validation and submission using fetch API
 * Sends JSON data compatible with Gson on the backend
 */

// Form validation function
function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const email = document.getElementById('email').value;
    const phone = document.getElementById('phone').value;
    const username = document.getElementById('username').value;
    
    // Username validation
    if (username.length < 3) {
        showError('Username must be at least 3 characters long.');
        return false;
    }
    
    // Username should not contain special characters except underscore
    const usernameRegex = /^[a-zA-Z0-9_]+$/;
    if (!usernameRegex.test(username)) {
        showError('Username can only contain letters, numbers, and underscores.');
        return false;
    }
    
    // Password validation
    if (password.length < 8) {
        showError('Password must be at least 8 characters long.');
        return false;
    }
    
    if (password !== confirmPassword) {
        showError('Passwords do not match.');
        return false;
    }
    
    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        showError('Please enter a valid email address.');
        return false;
    }
    
    // Phone validation - Sri Lankan mobile format
    const phoneRegex = /^[0]{1}[7]{1}[01245678]{1}[0-9]{7}$/;
    if (!phoneRegex.test(phone.replace(/\s/g, ''))) {
        showError('Please enter a valid Sri Lankan mobile number (e.g., 0771234567).');
        return false;
    }
    
    // Sri Lankan NIC validation
    const nic = document.getElementById('idNumber').value.trim();
    if (!isValidSriLankanNIC(nic)) {
        showError('Please enter a valid NIC number.');
        return false;
    }
    
    // Age validation
    const dateOfBirth = new Date(document.getElementById('dateOfBirth').value);
    const today = new Date();
    let age = today.getFullYear() - dateOfBirth.getFullYear();
    const monthDiff = today.getMonth() - dateOfBirth.getMonth();
    
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dateOfBirth.getDate())) {
        age--;
    }
    
    if (age < 18) {
        showError('You must be at least 18 years old to create an account.');
        return false;
    }
    
    // Terms agreement validation
    if (!document.getElementById('agreeTerms').checked) {
        showError('You must agree to the Terms of Service and Privacy Policy.');
        return false;
    }
    
    return true;
}

// Sri Lankan NIC validation function with specific regex pattern
function isValidSriLankanNIC(nic) {
    // Remove any spaces and convert to uppercase
    nic = nic.replace(/\s/g, '').toUpperCase();
    
    // Your specific NIC regex pattern
    const nicRegex = /^(([5,6,7,8,9]{1})([0-9]{1})([0,1,2,3,5,6,7,8]{1})([0-9]{6})([v|V|x|X]))|(([1,2]{1})([0,9]{1})([0-9]{2})([0,1,2,3,5,6,7,8]{1})([0-9]{7}))/;
    
    return nicRegex.test(nic);
}

// Function to collect form data in JSON format for Gson (matching User entity)
function collectUserData() {
    return {
        fname: document.getElementById('firstName').value.trim(),
        lname: document.getElementById('lastName').value.trim(),
        userName: document.getElementById('username').value.trim(),
        email: document.getElementById('email').value.trim(),
        phoneNumber: document.getElementById('phone').value.trim(),
        DOB: document.getElementById('dateOfBirth').value,
        address: document.getElementById('address').value.trim(),
        NIC: document.getElementById('idNumber').value.trim(),
        password: document.getElementById('password').value
    };
}

// Main function to handle form submission
async function handleRegistration(event) {
    event.preventDefault();
    
    // Validate form first
    if (!validateForm()) {
        return false;
    }
    
    // Show loading state
    const submitButton = document.querySelector('button[type="submit"]');
    const originalButtonText = submitButton.innerHTML;
    submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
    submitButton.disabled = true;
    
    try {
        // Collect user data
        const userData = collectUserData();
        
        console.log('Sending registration data:', userData);
        
        // Send registration request using fetch
        const response = await fetch('../user/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(userData)
        });
        
        // Handle response
        if (response.ok) {
            try {
                const result = await response.json();
                
                if (result && result.success) {
                    showSuccess(result.message || 'Account created successfully! Redirecting to login...');
                    setTimeout(() => {
                        window.location.href = 'login.jsp';
                    }, 2000);
                } else {
                    showError(result?.message || 'Registration failed. Please try again.');
                }
            } catch (jsonError) {
                // Handle case where servlet doesn't send JSON response
                console.error('JSON parsing error:', jsonError);
                showSuccess('Account created successfully! Redirecting to login...');
                setTimeout(() => {
                    window.location.href = 'login.jsp';
                }, 2000);
            }
        } else {
            // Handle HTTP error responses
            try {
                const errorData = await response.json();
                showError(errorData?.message || `Registration failed (${response.status})`);
            } catch (jsonError) {
                showError(`Registration failed (${response.status})`);
            }
        }
        
    } catch (error) {
        console.error('Registration error:', error);
        showError('Network error. Please check your connection and try again.');
    } finally {
        // Reset button state
        submitButton.innerHTML = originalButtonText;
        submitButton.disabled = false;
    }
    
    return false;
}

// Alternative function for form-based submission (fallback)
async function submitRegistrationAjax() {
    if (!validateForm()) {
        return false;
    }
    
    const userData = collectUserData();
    
    try {
        const response = await fetch('/user/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(userData)
        });
        
        try {
            const result = await response.json();
            
            if (result && result.success) {
                alert(result.message || 'Registration successful! Please login.');
                window.location.href = 'login.jsp';
            } else {
                alert(result?.message || 'Registration failed');
            }
        } catch (jsonError) {
            // Handle case where servlet doesn't send JSON response
            if (response.ok) {
                alert('Registration successful! Please login.');
                window.location.href = 'login.jsp';
            } else {
                alert('Registration failed');
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
function validateUsername() {
    const username = document.getElementById('username').value;
    const usernameField = document.getElementById('username');
    
    if (username.length > 0) {
        if (username.length < 3) {
            setFieldError(usernameField, 'Username must be at least 3 characters long');
        } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
            setFieldError(usernameField, 'Username can only contain letters, numbers, and underscores');
        } else {
            setFieldSuccess(usernameField);
        }
    } else {
        clearFieldStatus(usernameField);
    }
}

function validateEmail() {
    const email = document.getElementById('email').value;
    const emailField = document.getElementById('email');
    
    if (email.length > 0) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            setFieldError(emailField, 'Please enter a valid email address');
        } else {
            setFieldSuccess(emailField);
        }
    } else {
        clearFieldStatus(emailField);
    }
}

function validatePassword() {
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
    
    // Also validate confirm password if it has a value
    const confirmPassword = document.getElementById('confirmPassword').value;
    if (confirmPassword.length > 0) {
        validateConfirmPassword();
    }
}

function validateConfirmPassword() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const confirmPasswordField = document.getElementById('confirmPassword');
    
    if (confirmPassword.length > 0) {
        if (password !== confirmPassword) {
            setFieldError(confirmPasswordField, 'Passwords do not match');
        } else {
            setFieldSuccess(confirmPasswordField);
        }
    } else {
        clearFieldStatus(confirmPasswordField);
    }
}

function validatePhone() {
    const phone = document.getElementById('phone').value;
    const phoneField = document.getElementById('phone');
    
    if (phone.length > 0) {
        const phoneRegex = /^[0]{1}[7]{1}[01245678]{1}[0-9]{7}$/;
        if (!phoneRegex.test(phone.replace(/\s/g, ''))) {
            setFieldError(phoneField, 'Please enter a valid Sri Lankan mobile number (e.g., 0771234567)');
        } else {
            setFieldSuccess(phoneField);
        }
    } else {
        clearFieldStatus(phoneField);
    }
}

function validateNIC() {
    const nic = document.getElementById('idNumber').value;
    const nicField = document.getElementById('idNumber');
    
    if (nic.length > 0) {
        if (!isValidSriLankanNIC(nic)) {
            setFieldError(nicField, 'Please enter a valid NIC number');
        } else {
            setFieldSuccess(nicField);
        }
    } else {
        clearFieldStatus(nicField);
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
        form.addEventListener('submit', handleRegistration);
    }
    
    // Attach real-time validation
    const usernameField = document.getElementById('username');
    const emailField = document.getElementById('email');
    const phoneField = document.getElementById('phone');
    const passwordField = document.getElementById('password');
    const confirmPasswordField = document.getElementById('confirmPassword');
    const nicField = document.getElementById('idNumber');
    
    if (usernameField) {
        usernameField.addEventListener('blur', validateUsername);
    }
    
    if (emailField) {
        emailField.addEventListener('blur', validateEmail);
    }
    
    if (phoneField) {
        phoneField.addEventListener('blur', validatePhone);
    }
    
    if (passwordField) {
        passwordField.addEventListener('blur', validatePassword);
    }
    
    if (confirmPasswordField) {
        confirmPasswordField.addEventListener('blur', validateConfirmPassword);
    }
    
    if (nicField) {
        nicField.addEventListener('blur', validateNIC);
    }
});