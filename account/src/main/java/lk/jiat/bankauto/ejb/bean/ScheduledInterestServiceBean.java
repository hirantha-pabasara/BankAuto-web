package lk.jiat.bankauto.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import lk.jiat.bankauto.core.service.InterestService;
import lk.jiat.bankauto.core.service.ScheduledInterestService;

import java.util.logging.Logger;

/**
 * Scheduled service that automatically calculates and applies interest to bank accounts
 * Runs on the first day of every month at 2:00 AM
 */
@Singleton
@Startup
public class ScheduledInterestServiceBean implements ScheduledInterestService {

    private static final Logger logger = Logger.getLogger(ScheduledInterestServiceBean.class.getName());

    @EJB
    private InterestService interestService;

    /**
     * Scheduled method that runs monthly to calculate interest
     * Cron expression: "0 0 2 1 * *" means:
     * - Second: 0
     * - Minute: 0  
     * - Hour: 2 (2:00 AM)
     * - Day of month: 1 (first day)
     * - Month: * (every month)
     * - Day of week: * (any day)
     */
    @Schedule(second = "0", minute = "0", hour = "2", dayOfMonth = "1", month = "*", year = "*", persistent = false)
    public void calculateMonthlyInterest() {
        logger.info("Starting scheduled monthly interest calculation...");
        
        try {
            int accountsProcessed = interestService.applyInterestToAllAccounts();
            logger.info("Monthly interest calculation completed successfully. Processed " + accountsProcessed + " accounts.");
        } catch (Exception e) {
            logger.severe("Error during scheduled interest calculation: " + e.getMessage());
            // Log the error but don't throw it to prevent scheduler from stopping
        }
    }

    /**
     * Manual trigger for interest calculation (for testing purposes)
     */
    @Override
    public int triggerInterestCalculation() {
        logger.info("Manual interest calculation triggered...");
        
        try {
            int accountsProcessed = interestService.applyInterestToAllAccounts();
            logger.info("Manual interest calculation completed. Processed " + accountsProcessed + " accounts.");
            return accountsProcessed;
        } catch (Exception e) {
            logger.severe("Error during manual interest calculation: " + e.getMessage());
            throw new RuntimeException("Failed to calculate interest", e);
        }
    }
}
