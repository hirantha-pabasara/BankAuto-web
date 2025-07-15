package lk.jiat.bankauto.core.service;

import jakarta.ejb.Remote;
import java.math.BigDecimal;
import java.util.List;
import lk.jiat.bankauto.core.model.InterestRate;

@Remote
public interface InterestService {
    // Set interest rate for a specific account type
    void setInterestRate(String accountType, BigDecimal rate);
    
    // Get interest rate for a specific account type
    BigDecimal getInterestRate(String accountType);
    
    // Get all interest rates
    List<InterestRate> getAllInterestRates();
    
    // Apply interest to all eligible accounts
    int applyInterestToAllAccounts();
    
    // Apply interest to a specific account
    void applyInterestToAccount(Long accountId);
}