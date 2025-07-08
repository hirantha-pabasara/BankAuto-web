// Validation JavaScript for BankAuto forms

// Form validation utilities
const Validation = {
    // Email validation
    email: {
        pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        validate: function(email) {
            return this.pattern.test(email);
        },
        message: 'Please enter a valid email address'
    },
    
    // Password validation
    password: {
        minLength: 8,
        pattern: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/,
        validate: function(password) {
            if (password.length < this.minLength) {
                return { valid: false, message: `Password must be at least ${this.minLength} characters long` };
            }
            if (!this.pattern.test(password)) {
                return { valid: false, message: 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character' };
            }
            return { valid: true, message: '' };
        }
    },
    
    // Phone validation
    phone: {
        pattern: /^[\+]?[1-9][\d]{0,15}$/,
        validate: function(phone) {
            const cleanPhone = phone.replace(/\s+/g, '');
            return this.pattern.test(cleanPhone);
        },
        message: 'Please enter a valid phone number'
    },
    
    // Account number validation
    accountNumber: {
        pattern: /^\d{10,16}$/,
        validate: function(accountNumber) {
            return this.pattern.test(accountNumber);
        },
        message: 'Account number must be 10-16 digits'
    },
    
    // Amount validation
    amount: {
        min: 0.01,
        max: 999999.99,
        validate: function(amount) {
            const numAmount = parseFloat(amount);
            if (isNaN(numAmount)) {
                return { valid: false, message: 'Please enter a valid amount' };
            }
            if (numAmount < this.min) {
                return { valid: false, message: `Amount must be at least $${this.min}` };
            }
            if (numAmount > this.max) {
                return { valid: false, message: `Amount cannot exceed $${this.max}` };
            }
            return { valid: true, message: '' };
        }
    },
    
    // Date validation
    date: {
        validate: function(dateString) {
            const date = new Date(dateString);
            return date instanceof Date && !isNaN(date);
        },
        message: 'Please enter a valid date'
    },
    
    // Age validation
    age: {
        min: 18,
        max: 120,
        validate: function(birthDate) {
            const today = new Date();
            const birth = new Date(birthDate);
            let age = today.getFullYear() - birth.getFullYear();
            const monthDiff = today.getMonth() - birth.getMonth();
            
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
                age--;
            }
            
            if (age < this.min) {
                return { valid: false, message: `You must be at least ${this.min} years old` };
            }
            if (age > this.max) {
                return { valid: false, message: `Invalid birth date` };
            }
            return { valid: true, message: '' };
        }
    },
    
    // Required field validation
    required: {
        validate: function(value) {
            return value && value.trim().length > 0;
        },
        message: 'This field is required'
    },
    
    // Name validation
    name: {
        pattern: /^[a-zA-Z\s]{2,50}$/,
        validate: function(name) {
            return this.pattern.test(name);
        },
        message: 'Name must contain only letters and spaces (2-50 characters)'
    },
    
    // SSN/ID validation
    ssn: {
        pattern: /^\d{3}-?\d{2}-?\d{4}$/,
        validate: function(ssn) {
            return this.pattern.test(ssn);
        },
        message: 'Please enter a valid SSN (XXX-XX-XXXX)'
    }
};

// Real-time validation
function setupRealTimeValidation() {
    // Email fields
    const emailFields = document.querySelectorAll('input[type="email"]');
    emailFields.forEach(field => {
        field.addEventListener('blur', function() {
            validateField(this, Validation.email);
        });
    });
    
    // Password fields
    const passwordFields = document.querySelectorAll('input[type="password"]');
    passwordFields.forEach(field => {
        field.addEventListener('input', function() {
            if (this.id === 'password') {
                validatePasswordField(this);
            } else if (this.id === 'confirmPassword') {
                validatePasswordConfirmation(this);
            }
        });
    });
    
    // Phone fields (validation handled in register.js)
    const phoneFields = document.querySelectorAll('input[type="tel"]');
    phoneFields.forEach(field => {
        // Phone validation is handled in register.js
        // No formatting applied here
    });
    
    // Amount fields
    const amountFields = document.querySelectorAll('input[step="0.01"]');
    amountFields.forEach(field => {
        field.addEventListener('blur', function() {
            validateAmountField(this);
        });
        
        field.addEventListener('input', function() {
            formatAmountField(this);
        });
    });
    
    // Date fields
    const dateFields = document.querySelectorAll('input[type="date"]');
    dateFields.forEach(field => {
        if (field.id === 'dateOfBirth') {
            field.addEventListener('blur', function() {
                validateAgeField(this);
            });
        } else {
            field.addEventListener('blur', function() {
                validateField(this, Validation.date);
            });
        }
    });
    
    // Required fields
    const requiredFields = document.querySelectorAll('input[required], textarea[required], select[required]');
    requiredFields.forEach(field => {
        field.addEventListener('blur', function() {
            validateRequiredField(this);
        });
    });
    
    // Name fields
    const nameFields = document.querySelectorAll('#firstName, #lastName');
    nameFields.forEach(field => {
        field.addEventListener('blur', function() {
            validateField(this, Validation.name);
        });
    });
    
    // NIC field (validation handled in register.js)
    const nicField = document.getElementById('idNumber');
    if (nicField) {
        // NIC validation is handled in register.js
        // No formatting or validation applied here
    }
}

// Validate individual field
function validateField(field, validator) {
    const value = field.value.trim();
    const isValid = validator.validate(value);
    
    if (typeof isValid === 'object') {
        showFieldError(field, isValid.valid ? '' : isValid.message);
        return isValid.valid;
    } else {
        showFieldError(field, isValid ? '' : validator.message);
        return isValid;
    }
}

// Validate password field
function validatePasswordField(field) {
    const result = Validation.password.validate(field.value);
    showFieldError(field, result.valid ? '' : result.message);
    
    // Show password strength
    showPasswordStrength(field, field.value);
    
    return result.valid;
}

// Validate password confirmation
function validatePasswordConfirmation(field) {
    const passwordField = document.getElementById('password');
    if (!passwordField) return false;
    
    const isMatch = field.value === passwordField.value;
    showFieldError(field, isMatch ? '' : 'Passwords do not match');
    
    return isMatch;
}

// Validate amount field
function validateAmountField(field) {
    const result = Validation.amount.validate(field.value);
    showFieldError(field, result.valid ? '' : result.message);
    
    return result.valid;
}

// Validate age field
function validateAgeField(field) {
    const result = Validation.age.validate(field.value);
    showFieldError(field, result.valid ? '' : result.message);
    
    return result.valid;
}

// Validate required field
function validateRequiredField(field) {
    const isValid = Validation.required.validate(field.value);
    showFieldError(field, isValid ? '' : Validation.required.message);
    
    return isValid;
}

// Show field error
function showFieldError(field, message) {
    // Remove existing error
    const existingError = field.parentNode.querySelector('.invalid-feedback');
    if (existingError) {
        existingError.remove();
    }
    
    // Remove existing classes
    field.classList.remove('is-valid', 'is-invalid');
    
    if (message) {
        // Add error class and message
        field.classList.add('is-invalid');
        
        const errorDiv = document.createElement('div');
        errorDiv.className = 'invalid-feedback';
        errorDiv.textContent = message;
        field.parentNode.appendChild(errorDiv);
    } else {
        // Add valid class
        field.classList.add('is-valid');
    }
}

// Show password strength
function showPasswordStrength(field, password) {
    let strengthDiv = field.parentNode.querySelector('.password-strength');
    
    if (!strengthDiv) {
        strengthDiv = document.createElement('div');
        strengthDiv.className = 'password-strength mt-2';
        field.parentNode.appendChild(strengthDiv);
    }
    
    const strength = calculatePasswordStrength(password);
    
    strengthDiv.innerHTML = `
        <div class="progress" style="height: 5px;">
            <div class="progress-bar bg-${strength.color}" 
                 style="width: ${strength.percentage}%"></div>
        </div>
        <small class="text-${strength.color}">${strength.text}</small>
    `;
}

// Calculate password strength
function calculatePasswordStrength(password) {
    let score = 0;
    
    if (password.length >= 8) score++;
    if (/[a-z]/.test(password)) score++;
    if (/[A-Z]/.test(password)) score++;
    if (/\d/.test(password)) score++;
    if (/[@$!%*?&]/.test(password)) score++;
    
    const strengthLevels = [
        { color: 'danger', text: 'Very Weak', percentage: 20 },
        { color: 'danger', text: 'Weak', percentage: 40 },
        { color: 'warning', text: 'Fair', percentage: 60 },
        { color: 'info', text: 'Good', percentage: 80 },
        { color: 'success', text: 'Strong', percentage: 100 }
    ];
    
    return strengthLevels[score] || strengthLevels[0];
}

// Format phone number
function formatPhoneNumber(field) {
    let value = field.value.replace(/\D/g, '');
    
    if (value.length >= 10) {
        value = value.substring(0, 10);
        value = value.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
    } else if (value.length >= 6) {
        value = value.replace(/(\d{3})(\d{3})/, '($1) $2-');
    } else if (value.length >= 3) {
        value = value.replace(/(\d{3})/, '($1) ');
    }
    
    field.value = value;
}

// Format amount field
function formatAmountField(field) {
    let value = field.value.replace(/[^\d.]/g, '');
    
    // Ensure only one decimal point
    const parts = value.split('.');
    if (parts.length > 2) {
        value = parts[0] + '.' + parts.slice(1).join('');
    }
    
    // Limit decimal places to 2
    if (parts[1] && parts[1].length > 2) {
        value = parts[0] + '.' + parts[1].substring(0, 2);
    }
    
    field.value = value;
}

// Format SSN
function formatSSN(field) {
    let value = field.value.replace(/\D/g, '');
    
    if (value.length >= 9) {
        value = value.substring(0, 9);
        value = value.replace(/(\d{3})(\d{2})(\d{4})/, '$1-$2-$3');
    } else if (value.length >= 5) {
        value = value.replace(/(\d{3})(\d{2})/, '$1-$2-');
    } else if (value.length >= 3) {
        value = value.replace(/(\d{3})/, '$1-');
    }
    
    field.value = value;
}

// Form submission validation
function validateForm(form) {
    let isValid = true;
    const fields = form.querySelectorAll('input, textarea, select');
    
    fields.forEach(field => {
        if (field.hasAttribute('required')) {
            if (!validateRequiredField(field)) {
                isValid = false;
            }
        }
        
        // Specific field validations
        switch (field.type) {
            case 'email':
                if (field.value && !validateField(field, Validation.email)) {
                    isValid = false;
                }
                break;
            case 'password':
                if (field.id === 'password' && !validatePasswordField(field)) {
                    isValid = false;
                }
                if (field.id === 'confirmPassword' && !validatePasswordConfirmation(field)) {
                    isValid = false;
                }
                break;
            case 'tel':
                if (field.value && !validateField(field, Validation.phone)) {
                    isValid = false;
                }
                break;
            case 'date':
                if (field.id === 'dateOfBirth' && !validateAgeField(field)) {
                    isValid = false;
                }
                break;
        }
        
        // Amount fields
        if (field.hasAttribute('step') && field.getAttribute('step') === '0.01') {
            if (field.value && !validateAmountField(field)) {
                isValid = false;
            }
        }
        
        // Name fields
        if ((field.id === 'firstName' || field.id === 'lastName') && field.value) {
            if (!validateField(field, Validation.name)) {
                isValid = false;
            }
        }
        
        // SSN field
        if (field.id === 'idNumber' && field.value) {
            if (!validateField(field, Validation.ssn)) {
                isValid = false;
            }
        }
    });
    
    if (!isValid) {
        // Scroll to first error
        const firstError = form.querySelector('.is-invalid');
        if (firstError) {
            firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            firstError.focus();
        }
    }
    
    return isValid;
}

// Initialize validation when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    setupRealTimeValidation();
    
    // Add form submit handlers
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validateForm(this)) {
                e.preventDefault();
                e.stopPropagation();
            }
        });
    });
    
    console.log('Form validation initialized');
});

// Export validation functions for global use
window.FormValidation = {
    validateField,
    validateForm,
    validatePasswordField,
    validatePasswordConfirmation,
    validateAmountField,
    validateAgeField,
    validateRequiredField,
    showFieldError,
    Validation
};
