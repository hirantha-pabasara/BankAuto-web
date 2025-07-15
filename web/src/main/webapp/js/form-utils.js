class FormUtils {
    static showLoading(buttonId, spinnerId) {
        const button = document.getElementById(buttonId);
        const spinner = document.getElementById(spinnerId);
        
        if (button) button.disabled = true;
        if (spinner) spinner.style.display = 'block';
    }

    static hideLoading(buttonId, spinnerId) {
        const button = document.getElementById(buttonId);
        const spinner = document.getElementById(spinnerId);
        
        if (button) button.disabled = false;
        if (spinner) spinner.style.display = 'none';
    }

    static showMessage(containerId, message, type = 'danger') {
        const container = document.getElementById(containerId);
        if (!container) return;

        const iconMap = {
            success: 'fas fa-check-circle',
            danger: 'fas fa-exclamation-triangle',
            info: 'fas fa-info-circle'
        };

        container.innerHTML = `
            <div class="alert alert-${type}" role="alert">
                <i class="${iconMap[type]}"></i> ${message}
            </div>
        `;
    }

    static clearMessages(containerId) {
        const container = document.getElementById(containerId);
        if (container) container.innerHTML = '';
    }

    static validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    static validatePassword(password) {
        return password && password.length >= 6;
    }

    static validateRequired(fields) {
        for (const field of fields) {
            if (!field.value || field.value.trim() === '') {
                return { valid: false, message: `${field.name} is required` };
            }
        }
        return { valid: true };
    }

    static redirectAfterDelay(url, delay = 2000) {
        setTimeout(() => {
            window.location.href = url;
        }, delay);
    }
}
