package lk.jiat.bankauto.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import lk.jiat.bankauto.core.service.InterestService;
import lk.jiat.bankauto.core.service.ScheduledInterestService;

import java.util.logging.Logger;


@Singleton
@Startup
public class ScheduledInterestServiceBean implements ScheduledInterestService {

    private static final Logger logger = Logger.getLogger(ScheduledInterestServiceBean.class.getName());

    @EJB
    private InterestService interestService;

    @Schedule(second = "0", minute = "0", hour = "2", dayOfMonth = "1", month = "*", year = "*", persistent = false)
    public void calculateMonthlyInterest() {
        logger.info("Starting scheduled monthly interest calculation...");
        
        try {
            int accountsProcessed = interestService.applyInterestToAllAccounts();
            logger.info("Monthly interest calculation completed successfully. Processed " + accountsProcessed + " accounts.");
        } catch (Exception e) {
            logger.severe("Error during scheduled interest calculation: " + e.getMessage());
        }
    }

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
