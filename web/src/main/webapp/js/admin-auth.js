class AdminAuth {
    constructor() {
        this.apiClient = new ApiClient();
        this.initializeEventListeners();
    }

    initializeEventListeners() {
        const registerForm = document.getElementById('adminRegisterForm');
        if (registerForm) {
            registerForm.addEventListener('submit', (e) => this.handleRegistration(e));
        }

        const verifyForm = document.getElementById('verifyForm');
        if (verifyForm) {
            verifyForm.addEventListener('submit', (e) => this.handleVerification(e));
        }

        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', (e) => this.handleLogin(e));
        }
    }

    async handleRegistration(event) {
        event.preventDefault();
        
        const form = event.target;
        const formData = new FormData(form);
        
        const requiredFields = [
            { name: 'First Name', value: formData.get('fname') },
            { name: 'Last Name', value: formData.get('lname') },
            { name: 'Username', value: formData.get('userName') },
            { name: 'Email', value: formData.get('email') },
            { name: 'Password', value: formData.get('password') },
            { name: 'Phone Number', value: formData.get('phoneNumber') }
        ];

        const validation = FormUtils.validateRequired(requiredFields);
        if (!validation.valid) {
            FormUtils.showMessage('messageContainer', validation.message);
            return;
        }

        const email = formData.get('email');
        if (!FormUtils.validateEmail(email)) {
            FormUtils.showMessage('messageContainer', 'Please enter a valid email address');
            return;
        }

        const password = formData.get('password');
        if (!FormUtils.validatePassword(password)) {
            FormUtils.showMessage('messageContainer', 'Password must be at least 6 characters long');
            return;
        }

        try {
            FormUtils.showLoading('registerBtn', 'loadingSpinner');
            FormUtils.clearMessages('messageContainer');

            // Log form data for debugging
            console.log('Submitting registration with data:', Object.fromEntries(formData));
            
            // Log individual field values
            console.log('Form field values:');
            console.log('fname:', formData.get('fname'));
            console.log('lname:', formData.get('lname'));
            console.log('userName:', formData.get('userName'));
            console.log('email:', formData.get('email'));
            console.log('phoneNumber:', formData.get('phoneNumber'));

            const result = await this.apiClient.registerAdmin(formData);

            if (result.success) {
                FormUtils.showMessage('messageContainer', result.message, 'success');
                FormUtils.redirectAfterDelay(`verify.jsp?email=${encodeURIComponent(result.email)}`);
            } else {
                FormUtils.showMessage('messageContainer', result.message || 'Registration failed');
            }

        } catch (error) {
            console.error('Registration error:', error);
            
            // Check if it's a specific HTTP error
            if (error.message.includes('400')) {
                FormUtils.showMessage('messageContainer', 'Please check all required fields and try again.');
            } else if (error.message.includes('500')) {
                FormUtils.showMessage('messageContainer', 'Server error. Please try again later.');
            } else {
                FormUtils.showMessage('messageContainer', 'Network error. Please check your connection and try again.');
            }
        } finally {
            FormUtils.hideLoading('registerBtn', 'loadingSpinner');
        }
    }

    async handleVerification(event) {
        event.preventDefault();
        
        const email = document.getElementById('email').value;
        const verificationCode = document.getElementById('verificationCode').value.trim();

        if (!email || !verificationCode) {
            FormUtils.showMessage('messageContainer', 'Please enter the verification code');
            return;
        }

        try {
            FormUtils.showLoading('verifyBtn', 'loadingSpinner');
            FormUtils.clearMessages('messageContainer');

            const result = await this.apiClient.verifyEmail(email, verificationCode);

            if (result.success) {
                FormUtils.showMessage('messageContainer', result.message, 'success');
                FormUtils.redirectAfterDelay('login.jsp');
            } else {
                FormUtils.showMessage('messageContainer', result.message);
            }

        } catch (error) {
            console.error('Verification error:', error);
            FormUtils.showMessage('messageContainer', 'Network error. Please try again.');
        } finally {
            FormUtils.hideLoading('verifyBtn', 'loadingSpinner');
        }
    }

    async handleLogin(event) {
        event.preventDefault();
        
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value;

        if (!email || !password) {
            FormUtils.showMessage('messageContainer', 'Please enter both email and password');
            return;
        }

        if (!FormUtils.validateEmail(email)) {
            FormUtils.showMessage('messageContainer', 'Please enter a valid email address');
            return;
        }

        try {
            FormUtils.showLoading('loginBtn', 'loadingSpinner');
            FormUtils.clearMessages('messageContainer');

            const result = await this.apiClient.loginAdmin(email, password);

            if (result.success) {
                FormUtils.showMessage('messageContainer', 'Login successful!', 'success');
                FormUtils.redirectAfterDelay(result.redirectUrl || 'dashboard.jsp', 1000);
            } else {
                FormUtils.showMessage('messageContainer', result.message);
            }

        } catch (error) {
            console.error('Login error:', error);
            FormUtils.showMessage('messageContainer', 'Network error. Please try again.');
        } finally {
            FormUtils.hideLoading('loginBtn', 'loadingSpinner');
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AdminAuth();
});
