package lk.jiat.bankauto.core.service;

import jakarta.ejb.Local;

/**
 * Service interface for scheduled interest calculations
 */
@Local
public interface ScheduledInterestService {
    
    /**
     * Calculate and apply monthly interest to all eligible accounts
     * This method is called automatically by the scheduler
     */
    void calculateMonthlyInterest();
    
    /**
     * Manual trigger for interest calculation (for testing purposes)
     * @return number of accounts processed
     */
    int triggerInterestCalculation();
}
