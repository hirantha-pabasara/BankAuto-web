# Transaction Flow Logging Guide

## Overview
This guide shows how to use the comprehensive logging system implemented throughout the BankAuto transaction flow to debug and monitor transactions from frontend to backend.

## Logging Levels and Components

### Frontend Logging (JavaScript)
- **Location**: `transactions.jsp` + `Transactions.js` + `TransactionFlowLogger.js`
- **Prefix**: `[TRANSACTION-FLOW]`
- **Components**: FRONTEND, API-CALL, API-RESPONSE, VALIDATION, TRANSFER, FLOW, PERFORMANCE

### Backend Logging (Java)
- **Servlet Layer**: `TransferServlet.java`
- **EJB Layer**: `TransactionSessionBean.java`
- **Logger Names**: 
  - `lk.jiat.bankauto.servlet.TransferServlet`
  - `lk.jiat.bankauto.ejb.bean.TransactionSessionBean`

## How to Enable and Use Logging

### 1. Frontend Debug Panel
- **Activation**: Press `Ctrl+Shift+D` or call `toggleDebugPanel()`
- **Features**:
  - Real-time log viewing
  - Session tracking
  - Error counting
  - Log download
  - Log clearing

### 2. Browser Console Logging
All transaction steps are logged with detailed information:
```
[TRANSACTION-FLOW] TRANSFER PROCESSING STARTED
[TRANSACTION-FLOW] Form data collected: {fromAccount: "1", toAccount: "test@example.com", ...}
[TRANSACTION-FLOW] Form validation completed in 2.45ms
[TRANSACTION-FLOW] Transfer successful - Reference: TXN1641234567890
```

### 3. Server-Side Logging
Configure your application server to show INFO level logs for these packages:
```
lk.jiat.bankauto.servlet
lk.jiat.bankauto.ejb.bean
```

## Complete Transaction Flow Logging Points

### 1. Page Load
```javascript
// Frontend
TransactionLogger.logFrontendEvent('PAGE_LOAD', {...});
```

### 2. Account Loading
```javascript
// Frontend - Account fetch
[TRANSACTION-FLOW] Starting account loading process...
[TRANSACTION-FLOW] Account fetch completed in 245.67ms
[TRANSACTION-FLOW] Number of accounts: 3
```

### 3. Form Validation
```javascript
// Frontend - Validation
[TRANSACTION-FLOW] FORM VALIDATION STARTED
[TRANSACTION-FLOW] Source account validation passed: 1
[TRANSACTION-FLOW] Amount validation passed: 100.50
[TRANSACTION-FLOW] Balance check passed
```

### 4. Transfer Processing
```javascript
// Frontend - Transfer initiation
[TRANSACTION-FLOW] TRANSFER PROCESSING STARTED
[TRANSACTION-FLOW] Transfer data: {fromAccount: "1", amount: 100.50, ...}
```

```java
// Backend - Servlet processing
TRANSFER PROCESSING STARTED - User ID: 123
Request details - Remote Address: 127.0.0.1
Raw JSON received: {"fromAccountId":1,"toAccount":"test@example.com",...}
Transfer service call completed in 156ms
```

```java
// Backend - EJB processing
IMMEDIATE TRANSFER PROCESSING STARTED
Source account retrieved successfully:
  - Account Number: ACC1234567890
  - Current Balance: 5500.00
Balance check passed - sufficient funds available
TRANSFER COMPLETED SUCCESSFULLY in 234ms
```

### 5. Fund Transfer Execution
```java
// Backend - Fund movement
FUND TRANSFER EXECUTION STARTED
Balance calculation:
  - Original Balance: 5500.00
  - Transfer Amount: 100.50
  - New Balance: 5399.50
Transfer execution completed successfully
```

## Debugging Common Issues

### Issue 1: Account Loading Fails
**Check Frontend Logs:**
```
[TRANSACTION-FLOW] Authentication failed - redirecting to login
[TRANSACTION-FLOW] HTTP error occurred: 500 Internal Server Error
```

**Check Backend Logs:**
```
ERROR in TransferServlet GET
User not authenticated
```

### Issue 2: Transfer Validation Fails
**Check Frontend Logs:**
```
[TRANSACTION-FLOW] Form validation failed
[TRANSACTION-FLOW] Validation errors: ["Insufficient balance for this transfer"]
```

**Check Backend Logs:**
```
Transfer request validation failed
Validation failed: Insufficient balance
```

### Issue 3: Transfer Execution Fails
**Check Backend Logs:**
```
CRITICAL ERROR during fund transfer execution
Transfer execution failed:
  - Account: ACC1234567890
  - Amount: 100.50
  - Error: Database connection timeout
```

## Performance Monitoring

### Frontend Performance
```javascript
// Automatic timing
[TRANSACTION-FLOW] Account fetch completed in 245.67ms
[TRANSACTION-FLOW] JSON parsing completed in 1.23ms
[TRANSACTION-FLOW] Form validation completed in 2.45ms
```

### Backend Performance
```java
// Servlet timing
Total transfer processing time: 412ms

// EJB timing
TRANSFER COMPLETED SUCCESSFULLY in 234ms
Transfer service call completed in 156ms
```

## Log Export and Analysis

### 1. Download Logs from Debug Panel
- Press `Ctrl+Shift+D` to open debug panel
- Click "📥 Download Logs" button
- Logs saved as `transaction-logs-[SESSION-ID].json`

### 2. Log File Structure
```json
{
  "sessionId": "TXN-SESSION-1641234567890-abc123def",
  "timestamp": "2025-01-13T10:30:00.000Z",
  "logs": [
    {
      "timestamp": "2025-01-13T10:30:00.000Z",
      "level": "INFO",
      "component": "FRONTEND",
      "message": "Event: PAGE_LOAD",
      "data": {...}
    }
  ],
  "summary": {
    "totalLogs": 156,
    "errorCount": 2,
    "warningCount": 5
  }
}
```

### 3. Server Log Analysis
Check your application server logs (e.g., WildFly, Tomcat):
```
tail -f server.log | grep "TRANSFER\|Transaction"
```

## Testing Scenarios

### 1. Successful Transfer Test
1. Open transactions page
2. Press `Ctrl+Shift+D` to open debug panel
3. Fill transfer form with valid data
4. Submit transfer
5. Check logs for complete flow

### 2. Validation Error Test
1. Fill form with invalid data (negative amount)
2. Submit transfer
3. Check frontend validation logs

### 3. Insufficient Balance Test
1. Fill form with amount > account balance
2. Submit transfer
3. Check both frontend and backend validation logs

### 4. Network Error Test
1. Disconnect network
2. Submit transfer
3. Check error handling logs

## Log Monitoring in Production

### 1. Set Log Levels
```properties
# Application server configuration
lk.jiat.bankauto.servlet=INFO
lk.jiat.bankauto.ejb.bean=INFO
root=WARN
```

### 2. Log Aggregation
Consider using tools like:
- ELK Stack (Elasticsearch, Logstash, Kibana)
- Splunk
- Application server built-in monitoring

### 3. Alert Configuration
Set up alerts for:
- High error rates in transfer processing
- Performance degradation
- Authentication failures

## Troubleshooting Tips

1. **Always check both frontend and backend logs**
2. **Use session IDs to correlate logs across tiers**
3. **Check timestamps to identify performance bottlenecks**
4. **Look for error codes to identify specific failure points**
5. **Use the debug panel for real-time monitoring during development**

## Additional Utilities

### Global JavaScript Functions
```javascript
// Quick logging functions
logTransferStep('VALIDATION', 'PASSED', validationData);
logTransferError(error, context);
logApiCall('POST', '/api/transfers/process', requestData);
```

### Backend Logging Patterns
```java
// Standardized logging
logger.info("=== OPERATION STARTED ===");
logger.info("Input parameters: " + params);
logger.info("Processing time: " + duration + "ms");
logger.info("=== OPERATION ENDED ===");
```

This comprehensive logging system provides full visibility into the transaction flow and helps quickly identify and resolve issues.
