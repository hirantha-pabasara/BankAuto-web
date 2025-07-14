/**
 * Transaction Flow Logger
 * Comprehensive logging utility for tracking the entire transaction flow
 * from frontend to backend and back
 */

class TransactionFlowLogger {
    constructor() {
        this.sessionId = this.generateSessionId();
        this.isLoggingEnabled = true;
        this.logBuffer = [];
        this.maxBufferSize = 1000;
        
        console.log('[TRANSACTION-FLOW-LOGGER] Logger initialized with session ID:', this.sessionId);
    }
    
    generateSessionId() {
        return 'TXN-SESSION-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
    }
    
    log(level, component, message, data = null) {
        if (!this.isLoggingEnabled) return;
        
        const timestamp = new Date().toISOString();
        const logEntry = {
            timestamp,
            level: level.toUpperCase(),
            component,
            sessionId: this.sessionId,
            message,
            data,
            userAgent: navigator.userAgent,
            url: window.location.href
        };
        
        // Add to buffer
        this.logBuffer.push(logEntry);
        if (this.logBuffer.length > this.maxBufferSize) {
            this.logBuffer.shift(); // Remove oldest entry
        }
        
        // Console output with color coding
        const consoleMessage = `[${level.toUpperCase()}] [${component}] ${message}`;
        switch (level.toLowerCase()) {
            case 'error':
                console.error(consoleMessage, data || '');
                break;
            case 'warn':
                console.warn(consoleMessage, data || '');
                break;
            case 'info':
                console.info(consoleMessage, data || '');
                break;
            case 'debug':
                console.debug(consoleMessage, data || '');
                break;
            default:
                console.log(consoleMessage, data || '');
        }
    }
    
    // Specific logging methods for different components
    logFrontendEvent(eventType, details) {
        this.log('info', 'FRONTEND', `Event: ${eventType}`, details);
    }
    
    logApiCall(method, url, requestData) {
        this.log('info', 'API-CALL', `${method} ${url}`, requestData);
    }
    
    logApiResponse(url, status, responseData, duration) {
        this.log('info', 'API-RESPONSE', `${url} - Status: ${status} - Duration: ${duration}ms`, responseData);
    }
    
    logValidation(isValid, errors, field = null) {
        const level = isValid ? 'info' : 'warn';
        const message = isValid ? 'Validation passed' : 'Validation failed';
        this.log(level, 'VALIDATION', message, { field, errors });
    }
    
    logTransferStep(step, status, data) {
        this.log('info', 'TRANSFER', `Step: ${step} - Status: ${status}`, data);
    }
    
    logError(component, error, context = null) {
        this.log('error', component, `Error: ${error.message}`, {
            error: {
                name: error.name,
                message: error.message,
                stack: error.stack
            },
            context
        });
    }
    
    // Performance tracking
    startTimer(operation) {
        const timerId = `${operation}-${Date.now()}`;
        this[timerId] = performance.now();
        this.log('debug', 'PERFORMANCE', `Timer started: ${operation}`, { timerId });
        return timerId;
    }
    
    endTimer(timerId, operation) {
        if (this[timerId]) {
            const duration = performance.now() - this[timerId];
            this.log('info', 'PERFORMANCE', `${operation} completed`, { duration: `${duration.toFixed(2)}ms` });
            delete this[timerId];
            return duration;
        }
        return null;
    }
    
    // Flow tracking methods
    startTransactionFlow(transferData) {
        this.log('info', 'FLOW', '='.repeat(50));
        this.log('info', 'FLOW', 'TRANSACTION FLOW STARTED');
        this.log('info', 'FLOW', '='.repeat(50));
        this.log('info', 'FLOW', 'Transfer data', transferData);
    }
    
    endTransactionFlow(result) {
        this.log('info', 'FLOW', 'Transaction result', result);
        this.log('info', 'FLOW', '='.repeat(50));
        this.log('info', 'FLOW', 'TRANSACTION FLOW ENDED');
        this.log('info', 'FLOW', '='.repeat(50));
    }
    
    // Export logs for debugging
    exportLogs() {
        return {
            sessionId: this.sessionId,
            timestamp: new Date().toISOString(),
            logs: this.logBuffer,
            summary: this.generateSummary()
        };
    }
    
    generateSummary() {
        const summary = {
            totalLogs: this.logBuffer.length,
            errorCount: this.logBuffer.filter(log => log.level === 'ERROR').length,
            warningCount: this.logBuffer.filter(log => log.level === 'WARN').length,
            components: [...new Set(this.logBuffer.map(log => log.component))],
            timespan: {
                start: this.logBuffer[0]?.timestamp || null,
                end: this.logBuffer[this.logBuffer.length - 1]?.timestamp || null
            }
        };
        return summary;
    }
    
    // Download logs as JSON file
    downloadLogs() {
        const logs = this.exportLogs();
        const blob = new Blob([JSON.stringify(logs, null, 2)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        
        const a = document.createElement('a');
        a.href = url;
        a.download = `transaction-logs-${this.sessionId}.json`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        
        this.log('info', 'LOGGER', 'Logs downloaded', { filename: a.download });
    }
    
    // Clear logs
    clearLogs() {
        const oldCount = this.logBuffer.length;
        this.logBuffer = [];
        this.log('info', 'LOGGER', `Cleared ${oldCount} log entries`);
    }
    
    // Toggle logging
    setLoggingEnabled(enabled) {
        this.isLoggingEnabled = enabled;
        console.log(`Transaction flow logging ${enabled ? 'enabled' : 'disabled'}`);
    }
}

// Create global instance
window.TransactionLogger = new TransactionFlowLogger();

// Utility functions for quick logging
window.logTransferStep = (step, status, data) => {
    window.TransactionLogger.logTransferStep(step, status, data);
};

window.logTransferError = (error, context) => {
    window.TransactionLogger.logError('TRANSFER', error, context);
};

window.logApiCall = (method, url, data) => {
    window.TransactionLogger.logApiCall(method, url, data);
};

window.logApiResponse = (url, status, data, duration) => {
    window.TransactionLogger.logApiResponse(url, status, data, duration);
};

// Enhanced console methods with flow tracking
const originalConsoleLog = console.log;
const originalConsoleError = console.error;
const originalConsoleWarn = console.warn;

console.log = function(...args) {
    if (args[0] && args[0].includes('[TRANSACTION-FLOW]')) {
        window.TransactionLogger.log('info', 'FLOW', args.join(' '));
    }
    originalConsoleLog.apply(console, arguments);
};

console.error = function(...args) {
    if (args[0] && args[0].includes('[TRANSACTION-FLOW]')) {
        window.TransactionLogger.log('error', 'FLOW', args.join(' '));
    }
    originalConsoleError.apply(console, arguments);
};

console.warn = function(...args) {
    if (args[0] && args[0].includes('[TRANSACTION-FLOW]')) {
        window.TransactionLogger.log('warn', 'FLOW', args.join(' '));
    }
    originalConsoleWarn.apply(console, arguments);
};

console.log('[TRANSACTION-FLOW-LOGGER] Enhanced logging system initialized');
