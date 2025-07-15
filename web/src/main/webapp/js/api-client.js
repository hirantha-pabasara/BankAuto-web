class ApiClient {
    constructor(baseUrl = 'http://localhost:8080/bankauto') {
        this.baseUrl = baseUrl;
    }

    async makeRequest(endpoint, options = {}) {
        const defaultOptions = {
            headers: {
                'Accept': 'application/json'
            },
            credentials: 'same-origin'
        };

        const config = {
            ...defaultOptions,
            ...options,
            headers: {
                ...defaultOptions.headers,
                ...options.headers
            }
        };

        try {
            const response = await fetch(`${this.baseUrl}${endpoint}`, config);

            if (!response.ok) {
                if (response.status === 401) {
                    window.location.href = '../user/login.jsp';
                    return;
                }
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            return await response.json();
        } catch (error) {
            console.error(`API Error for ${endpoint}:`, error);
            throw error;
        }
    }

    async registerAdmin(formData) {
        // Convert FormData to URLSearchParams for proper servlet handling
        const params = new URLSearchParams();
        for (const [key, value] of formData.entries()) {
            params.append(key, value);
        }

        return await this.makeRequest('/admin/register', {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        });
    }

    async verifyEmail(email, verificationCode) {
        const params = new URLSearchParams();
        params.append('email', email);
        params.append('verificationCode', verificationCode);

        return await this.makeRequest('/admin/verify', {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        });
    }

    async loginAdmin(email, password) {
        const params = new URLSearchParams();
        params.append('email', email);
        params.append('password', password);

        return await this.makeRequest('/admin/login', {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        });
    }
}
