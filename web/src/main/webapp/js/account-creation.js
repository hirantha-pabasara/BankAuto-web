async function handleAccountCreation(event) {
    event.preventDefault();
    const formData = new FormData();
    formData.append('accountType', document.getElementById('accountType').value);
    formData.append('accountName', document.getElementById('accountName').value);
    formData.append('initialDeposit', document.getElementById('initialDeposit').value);
    formData.append('currency', document.getElementById('currency').value);
    formData.append('purpose', document.getElementById('purpose').value);
    formData.append('paperlessStatements', document.getElementById('paperlessStatements').checked);
    formData.append('mobileAlerts', document.getElementById('mobileAlerts').checked);
    formData.append('agreeTerms', document.getElementById('agreeTerms').checked);
    
    // Add file uploads
    const files = document.getElementById('documentUpload').files;
    for (let i = 0; i < files.length; i++) {
        formData.append('documentUpload', files[i]);
    }
    
    try {
        const response = await fetch('account-creation', {
            method: 'POST',
            body: formData
        });
        
        const result = await response.json();
        if (result.success) {
            // Hide form and show pending review section
            document.getElementById('accountForm').style.display = 'none';
            document.getElementById('pendingReviewSection').style.display = 'block';
            window.scrollTo({ top: 0, behavior: 'smooth' });
        } else {
            showError(result.message || 'Failed to create account. Please try again.');
        }
    } catch (error) {
        console.error('Error:', error);
        showError('Failed to submit application. Please try again.');
    }
}

function showError(message) {
    // Create error alert
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-danger alert-dismissible fade show';
    alertDiv.innerHTML = `
        <i class="fas fa-exclamation-triangle"></i> ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    // Insert at top of container
    const container = document.querySelector('.container-fluid');
    container.insertBefore(alertDiv, container.firstChild);
    
    // Auto dismiss after 5 seconds
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}
