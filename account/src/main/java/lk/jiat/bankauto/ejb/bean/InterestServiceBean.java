package lk.jiat.bankauto.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.bankauto.core.enums.AccountStatus;
import lk.jiat.bankauto.core.enums.TransactionStatus;
import lk.jiat.bankauto.core.enums.TransactionType;
import lk.jiat.bankauto.core.enums.TransferType;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.model.InterestRate;
import lk.jiat.bankauto.core.model.Transaction;
import lk.jiat.bankauto.core.service.AccountService;
import lk.jiat.bankauto.core.service.InterestService;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class InterestServiceBean implements InterestService {

    private static final Logger logger = Logger.getLogger(InterestServiceBean.class.getName());

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager em;

    @EJB
    private AccountService accountService;

    @Override
    public void setInterestRate(String accountType, BigDecimal rate) {
        try {
            TypedQuery<InterestRate> query = em.createNamedQuery("InterestRate.findByAccountType", InterestRate.class);
            query.setParameter("accountType", accountType);
            
            List<InterestRate> existingRates = query.getResultList();
            
            if (!existingRates.isEmpty()) {
                InterestRate interestRate = existingRates.get(0);
                interestRate.setRate(rate);
                interestRate.setUpdatedAt(LocalDateTime.now());
                em.merge(interestRate);
                logger.info("Updated interest rate for " + accountType + " to " + rate + "%");
            } else {
                // Create new rate
                InterestRate interestRate = new InterestRate(accountType, rate, 1L); // Admin user ID
                em.persist(interestRate);
                logger.info("Created new interest rate for " + accountType + " at " + rate + "%");
            }
            
        } catch (Exception e) {
            logger.severe("Error setting interest rate: " + e.getMessage());
            throw new RuntimeException("Failed to set interest rate", e);
        }
    }

    @Override
    public BigDecimal getInterestRate(String accountType) {
        try {
            TypedQuery<InterestRate> query = em.createNamedQuery("InterestRate.findByAccountType", InterestRate.class);
            query.setParameter("accountType", accountType);
            
            List<InterestRate> rates = query.getResultList();
            
            if (!rates.isEmpty()) {
                return rates.get(0).getRate();
            }

            return getDefaultRate(accountType);
            
        } catch (Exception e) {
            logger.severe("Error getting interest rate: " + e.getMessage());
            return getDefaultRate(accountType);
        }
    }

    @Override
    public int applyInterestToAllAccounts() {
        int accountsProcessed = 0;
        BigDecimal totalInterestPaid = BigDecimal.ZERO;
        
        try {
            logger.info("Starting interest calculation for all accounts...");

            TypedQuery<BankAccount> query = em.createQuery(
                "SELECT a FROM BankAccount a WHERE a.status = :status AND a.balance > 0", 
                BankAccount.class);
            query.setParameter("status", AccountStatus.ACTIVE);
            
            List<BankAccount> accounts = query.getResultList();
            logger.info("Found " + accounts.size() + " eligible accounts for interest calculation");
            
            for (BankAccount account : accounts) {
                try {
                    BigDecimal interestApplied = applyInterestToAccountInternal(account);
                    if (interestApplied.compareTo(BigDecimal.ZERO) > 0) {
                        totalInterestPaid = totalInterestPaid.add(interestApplied);
                        accountsProcessed++;
                    }
                } catch (Exception e) {
                    logger.warning("Failed to apply interest to account " + account.getAccountNumber() + ": " + e.getMessage());
                }
            }
            
            logger.info("Interest calculation completed. Processed " + accountsProcessed + " accounts. Total interest paid: $" + totalInterestPaid);
            
        } catch (Exception e) {
            logger.severe("Error applying interest to all accounts: " + e.getMessage());
            throw new RuntimeException("Failed to apply interest to accounts", e);
        }
        
        return accountsProcessed;
    }

    @Override
    public void applyInterestToAccount(Long accountId) {
        try {
            BankAccount account = em.find(BankAccount.class, accountId);
            
            if (account != null) {
                BigDecimal interestApplied = applyInterestToAccountInternal(account);
                if (interestApplied.compareTo(BigDecimal.ZERO) > 0) {
                    logger.info("Applied interest of $" + interestApplied + " to account " + account.getAccountNumber());
                } else {
                    logger.info("No interest applied to account " + account.getAccountNumber() + " (inactive or zero balance)");
                }
            } else {
                logger.warning("Account not found with ID: " + accountId);
            }
            
        } catch (Exception e) {
            logger.severe("Error applying interest to account " + accountId + ": " + e.getMessage());
            throw new RuntimeException("Failed to apply interest to account", e);
        }
    }

    private BigDecimal applyInterestToAccountInternal(BankAccount account) {
        if (account == null || account.getStatus() != AccountStatus.ACTIVE || 
            account.getBalance().compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }
        
        BigDecimal interestRate = getInterestRate(account.getAccountType());
        
        // Calculate monthly interest (annual rate / 12)
        BigDecimal monthlyRate = interestRate.divide(new BigDecimal("12"), 6, RoundingMode.HALF_UP);
        
        // Calculate interest amount
        BigDecimal interestAmount = account.getBalance()
            .multiply(monthlyRate.divide(new BigDecimal("100"), 6, RoundingMode.HALF_UP))
            .setScale(2, RoundingMode.HALF_UP);
        
        // Add interest to account balance
        BigDecimal oldBalance = account.getBalance();
        BigDecimal newBalance = oldBalance.add(interestAmount);
        account.setBalance(newBalance);
        
        em.merge(account);
        
        // Create transaction record for interest credit
        createInterestTransaction(account, interestAmount, oldBalance, newBalance, interestRate);
        
        logger.info("Applied interest of $" + interestAmount + " to account " + account.getAccountNumber() + 
                   " (Rate: " + interestRate + "%, Balance: $" + oldBalance + " -> $" + newBalance + ")");
        
        return interestAmount;
    }

    private void createInterestTransaction(BankAccount account, BigDecimal interestAmount, 
                                         BigDecimal oldBalance, BigDecimal newBalance, BigDecimal interestRate) {
        try {
            Transaction interestTransaction = new Transaction();

            interestTransaction.setFromAccountId(account.getId());
            interestTransaction.setToAccountId(account.getId());
            interestTransaction.setToAccountIdentifier(account.getAccountNumber());
            interestTransaction.setAmount(interestAmount);
            interestTransaction.setTransactionType(TransactionType.INTEREST);
            interestTransaction.setTransferType(TransferType.IMMEDIATE);
            interestTransaction.setStatus(TransactionStatus.COMPLETED);

            String description = String.format("Monthly Interest Credit - %.2f%% APR on %s Account", 
                                              interestRate, account.getAccountType());
            interestTransaction.setDescription(description);

            LocalDateTime now = LocalDateTime.now();
            interestTransaction.setTransactionDate(now);
            interestTransaction.setProcessedDate(now);
            interestTransaction.setCreatedBy(1L); // System user ID
            interestTransaction.setProcessedBy(1L); // System user ID

            interestTransaction.setBalanceAfterTransaction(newBalance);

            String referenceNumber = "INT" + System.currentTimeMillis() + String.format("%04d", (int)(Math.random() * 10000));
            interestTransaction.setReferenceNumber(referenceNumber);

            em.persist(interestTransaction);
            
            logger.info("Created interest transaction record: " + referenceNumber + 
                       " for account " + account.getAccountNumber() + " amount $" + interestAmount);
            
        } catch (Exception e) {
            logger.warning("Failed to create interest transaction record for account " + 
                          account.getAccountNumber() + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public List<InterestRate> getAllInterestRates() {
        try {
            TypedQuery<InterestRate> query = em.createQuery(
                "SELECT i FROM InterestRate i ORDER BY i.accountType", 
                InterestRate.class);
            
            return query.getResultList();
            
        } catch (Exception e) {
            logger.severe("Error getting all interest rates: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    private BigDecimal getDefaultRate(String accountType) {
        // Default interest rates
        switch (accountType.toLowerCase()) {
            case "savings account":
                return new BigDecimal("2.5");
            case "fixed deposit":
                return new BigDecimal("5.0");
            case "current account":
                return new BigDecimal("1.0");
            case "checking account":
                return new BigDecimal("0.5");
            default:
                return new BigDecimal("1.0");
        }
    }
}
