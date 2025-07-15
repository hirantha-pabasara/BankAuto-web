# Scheduled Interest Calculation

## Overview
This implementation provides automated monthly interest calculation for bank accounts using Jakarta EE's `@Schedule` annotation.

## Architecture

### Core Module
- **ScheduledInterestService.java**: Service interface for scheduled operations
  - `calculateMonthlyInterest()`: Automated method called by scheduler
  - `triggerInterestCalculation()`: Manual trigger for testing

### Account Module (EJB)
- **ScheduledInterestServiceBean.java**: Implementation with `@Schedule` annotation
  - `@Singleton`: Ensures only one instance runs across the cluster
  - `@Startup`: Initializes the scheduler when the application starts
  - Schedule: Runs on the 1st day of every month at 2:00 AM

### Web Module
- **TriggerInterestServlet.java**: Manual trigger endpoint for testing
  - Endpoint: `/admin/trigger-interest`
  - Method: POST
  - Returns JSON response with processing results

## Schedule Configuration
```java
@Schedule(second = "0", minute = "0", hour = "2", dayOfMonth = "1", month = "*", year = "*", persistent = false)
```

This cron expression means:
- **Second**: 0
- **Minute**: 0  
- **Hour**: 2 (2:00 AM)
- **Day of month**: 1 (first day)
- **Month**: * (every month)
- **Year**: * (every year)
- **Persistent**: false (won't survive server restarts)

## Interest Calculation Logic
1. Retrieves all active accounts with positive balances
2. For each account:
   - Gets the interest rate for the account type
   - Calculates monthly interest: (annual_rate / 12) / 100 * balance
   - Adds interest to the account balance
   - Updates the account in the database

## Interest Rates by Account Type
- **Savings Account**: 2.5% annual (default)
- **Fixed Deposit**: 5.0% annual (default)
- **Current Account**: 1.0% annual (default)
- **Checking Account**: 0.5% annual (default)

## Testing
1. Use the admin dashboard button "Apply Interest to All Accounts"
2. Or make a POST request to `/admin/trigger-interest`
3. Check the server logs for processing details

## Logging
The system logs:
- When scheduled calculation starts
- Number of accounts processed
- Total interest paid
- Individual account updates
- Any errors during processing

## Error Handling
- Individual account failures don't stop the entire process
- Errors are logged but don't crash the scheduler
- Manual triggers throw exceptions for immediate feedback

## Security
- Only accessible via admin interface
- No direct user access to scheduling functions
- Requires proper authentication to access trigger endpoints
