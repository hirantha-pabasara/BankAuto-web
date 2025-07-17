package lk.jiat.bankauto.ejb.bean;

import jakarta.annotation.Resource;
import jakarta.annotation.security.DeclareRoles;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.bankauto.core.dto.TransferRequest;
import lk.jiat.bankauto.core.dto.TransferResult;
import lk.jiat.bankauto.core.enums.RecurrenceFrequency;
import lk.jiat.bankauto.core.enums.TransactionStatus;
import lk.jiat.bankauto.core.enums.TransactionType;
import lk.jiat.bankauto.core.enums.TransferType;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.model.Transaction;
import lk.jiat.bankauto.core.service.AccountService;
import lk.jiat.bankauto.core.service.TransferService;
import jakarta.ejb.TimerService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@DeclareRoles({"USER", "ADMIN"})
@Stateless
public class TransactionSessionBean implements TransferService {

    private static final Logger logger = Logger.getLogger(TransactionSessionBean.class.getName());

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager em;

    @Resource
    private TimerService timerService;

    @Resource
    private SessionContext sessionContext;

    @EJB
    private AccountService accountService;

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @RolesAllowed({"USER", "ADMIN"})
    public TransferResult processImmediateTransfer(TransferRequest request) {
        logger.info("=================================================================");
        logger.info("IMMEDIATE TRANSFER PROCESSING STARTED");
        logger.info("=================================================================");
        logger.info("Processing immediate transfer for amount: " + request.getAmount());
        logger.info("Transfer request details:");
        logger.info("  - User ID: " + request.getUserId());
        logger.info("  - From Account ID: " + request.getFromAccountId());
        logger.info("  - To Account: " + request.getToAccount());
        logger.info("  - Amount: " + request.getAmount());
        logger.info("  - Description: " + request.getDescription());

        long startTime = System.currentTimeMillis();

        try {
            // Validate transfer request
            logger.info("Starting transfer request validation...");
            TransferResult validation = validateTransferRequest(request);
            if (!validation.isSuccess()) {
                logger.warning("Transfer validation failed: " + validation.getMessage());
                logger.warning("Error code: " + validation.getErrorCode());
                return validation;
            }
            logger.info("Transfer validation passed successfully");

            // Get source account
            logger.info("Retrieving source account with ID: " + request.getFromAccountId());
            BankAccount fromAccount = accountService.getAccountById(request.getFromAccountId());
            if (fromAccount == null) {
                logger.severe("CRITICAL: Source account not found - Account ID: " + request.getFromAccountId());
                return TransferResult.failure("Source account not found", "ACCOUNT_NOT_FOUND");
            }
            
            logger.info("Source account retrieved successfully:");
            logger.info("  - Account Number: " + fromAccount.getAccountNumber());
            logger.info("  - Account Type: " + fromAccount.getAccountType());
            logger.info("  - Current Balance: " + fromAccount.getBalance());
            logger.info("  - Account Status: " + fromAccount.getStatus());

            // Check sufficient balance
            logger.info("Checking account balance sufficiency...");
            logger.info("Required amount: " + request.getAmount());
            logger.info("Available balance: " + fromAccount.getBalance());
            
            if (fromAccount.getBalance().compareTo(request.getAmount()) < 0) {
                logger.warning("INSUFFICIENT BALANCE - Required: " + request.getAmount() + 
                              ", Available: " + fromAccount.getBalance());
                return TransferResult.failure("Insufficient balance", "INSUFFICIENT_BALANCE");
            }
            logger.info("Balance check passed - sufficient funds available");

            // Create transaction record
            logger.info("Creating transaction record in database...");
            Transaction transaction = new Transaction(
                    request.getFromAccountId(),
                    request.getToAccount(),
                    request.getAmount(),
                    TransactionType.TRANSFER,
                    TransferType.IMMEDIATE,
                    request.getDescription(),
                    request.getUserId()
            );

            transaction.setStatus(TransactionStatus.PROCESSING);
            em.persist(transaction);
            em.flush();
            
            logger.info("Transaction record created successfully:");
            logger.info("  - Transaction ID: " + transaction.getTransactionId());
            logger.info("  - Reference Number: " + transaction.getReferenceNumber());
            logger.info("  - Status: " + transaction.getStatus());

            // Process the transfer
            logger.info("Executing fund transfer...");
            long transferStartTime = System.currentTimeMillis();
            boolean transferSuccess = executeTransfer(fromAccount, request, transaction);
            long transferTime = System.currentTimeMillis() - transferStartTime;
            logger.info("Transfer execution completed in " + transferTime + "ms");

            if (transferSuccess) {
                logger.info("Transfer execution successful - updating transaction status");
                transaction.setStatus(TransactionStatus.COMPLETED);
                transaction.setProcessedDate(LocalDateTime.now());
                transaction.setProcessedBy(request.getUserId());
                em.merge(transaction);

                long totalTime = System.currentTimeMillis() - startTime;
                logger.info("TRANSFER COMPLETED SUCCESSFULLY in " + totalTime + "ms");
                logger.info("Reference Number: " + transaction.getReferenceNumber());
                logger.info("New account balance: " + fromAccount.getBalance());
                
                return TransferResult.success("Transfer completed successfully", transaction.getReferenceNumber());
            } else {
                logger.severe("Transfer execution failed - updating transaction status");
                transaction.setStatus(TransactionStatus.FAILED);
                transaction.setFailureReason("Transfer execution failed");
                em.merge(transaction);

                return TransferResult.failure("Transfer failed during execution", "EXECUTION_FAILED");
            }

        } catch (Exception e) {
            long totalTime = System.currentTimeMillis() - startTime;
            logger.log(Level.SEVERE, "CRITICAL ERROR in immediate transfer processing after " + totalTime + "ms", e);
            logger.severe("Error details:");
            logger.severe("  - User ID: " + request.getUserId());
            logger.severe("  - From Account ID: " + request.getFromAccountId());
            logger.severe("  - Amount: " + request.getAmount());
            logger.severe("  - Error: " + e.getMessage());
            
            sessionContext.setRollbackOnly();
            return TransferResult.failure("An unexpected error occurred", "SYSTEM_ERROR");
        } finally {
            logger.info("=================================================================");
            logger.info("IMMEDIATE TRANSFER PROCESSING ENDED");
            logger.info("=================================================================");
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @RolesAllowed({"USER", "ADMIN"})
    public TransferResult scheduleTransfer(TransferRequest request) {
        logger.info("Scheduling transfer for: " + request.getScheduledDateTime());

        try {
            // Validate transfer request
            TransferResult validation = validateTransferRequest(request);
            if (!validation.isSuccess()) {
                return validation;
            }

            // Validate scheduled date
            if (request.getScheduledDateTime().isBefore(LocalDateTime.now())) {
                return TransferResult.failure("Scheduled date must be in the future", "INVALID_SCHEDULE_DATE");
            }

            // Create scheduled transaction record
            Transaction transaction = new Transaction(
                    request.getFromAccountId(),
                    request.getToAccount(),
                    request.getAmount(),
                    TransactionType.TRANSFER,
                    TransferType.SCHEDULED,
                    request.getDescription(),
                    request.getUserId()
            );

            transaction.setStatus(TransactionStatus.SCHEDULED);
            transaction.setScheduledDateTime(request.getScheduledDateTime());
            em.persist(transaction);
            em.flush();

            // Create EJB Timer for scheduled execution
            TimerConfig timerConfig = new TimerConfig();
            timerConfig.setInfo(transaction.getTransactionId());
            timerConfig.setPersistent(true);

            timerService.createSingleActionTimer(
                    java.sql.Timestamp.valueOf(request.getScheduledDateTime()),
                    timerConfig
            );

            logger.info("Transfer scheduled successfully: " + transaction.getReferenceNumber());
            return TransferResult.success("Transfer scheduled successfully", transaction.getReferenceNumber());

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error scheduling transfer", e);
            sessionContext.setRollbackOnly();
            return TransferResult.failure("Failed to schedule transfer", "SCHEDULE_ERROR");
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @RolesAllowed({"USER", "ADMIN"})
    public TransferResult setupRecurringTransfer(TransferRequest request) {
        logger.info("Setting up recurring transfer with frequency: " + request.getFrequency());

        try {
            // Validate transfer request
            TransferResult validation = validateTransferRequest(request);
            if (!validation.isSuccess()) {
                return validation;
            }

            // Create recurring transaction record
            Transaction transaction = new Transaction(
                    request.getFromAccountId(),
                    request.getToAccount(),
                    request.getAmount(),
                    TransactionType.TRANSFER,
                    TransferType.RECURRING,
                    request.getDescription(),
                    request.getUserId()
            );

            transaction.setStatus(TransactionStatus.ACTIVE);
            transaction.setStartDate(request.getStartDate());
            transaction.setEndDate(request.getEndDate());
            transaction.setFrequency(RecurrenceFrequency.valueOf(request.getFrequency()));
            
            // Calculate next execution date - if start date is in the past, use current time
            LocalDateTime nextExecution = request.getStartDate();
            LocalDateTime now = LocalDateTime.now();
            
            // If start date is in the past, start from the next interval from now
            if (nextExecution.isBefore(now)) {
                nextExecution = now;
            }
            
            transaction.setNextExecutionDate(calculateNextExecutionDate(nextExecution, request.getFrequency()));

            em.persist(transaction);
            em.flush();

            logger.info("Recurring transfer setup successfully: " + transaction.getReferenceNumber() + 
                       ", Next execution: " + transaction.getNextExecutionDate() + 
                       ", Frequency: " + request.getFrequency());
            return TransferResult.success("Recurring transfer setup successfully", transaction.getReferenceNumber());

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error setting up recurring transfer", e);
            sessionContext.setRollbackOnly();
            return TransferResult.failure("Failed to setup recurring transfer", "RECURRING_SETUP_ERROR");
        }
    }

    @Timeout
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void handleScheduledTransfer(Timer timer) {
        logger.info("Executing scheduled transfer via Timer Service");

        try {
            Long transactionId = (Long) timer.getInfo();
            Transaction transaction = em.find(Transaction.class, transactionId);

            if (transaction != null && transaction.getStatus() == TransactionStatus.SCHEDULED) {
                // Execute the scheduled transfer
                executeScheduledTransfer(transaction);
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error executing scheduled transfer", e);
        }
    }




    @Override
    public void processScheduledTransfers() {
        logger.info("Processing scheduled transfers manually");
        
        try {
            LocalDateTime now = LocalDateTime.now();
            
            // Find all scheduled transfers that are due for execution
            TypedQuery<Transaction> query = em.createNamedQuery("Transaction.findScheduledTransfers", Transaction.class);
            query.setParameter("currentTime", now);
            query.setMaxResults(50); // Limit for performance
            
            List<Transaction> scheduledTransfers = query.getResultList();
            
            logger.info("Found " + scheduledTransfers.size() + " scheduled transfers to process");
            
            for (Transaction transaction : scheduledTransfers) {
                logger.info("Processing scheduled transfer: " + transaction.getReferenceNumber());
                executeScheduledTransfer(transaction);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing scheduled transfers", e);
        }
    }

    @Override
    @Schedule(hour = "2", minute = "0", second = "0", persistent = true)
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void processRecurringTransfers() {
        logger.info("Processing daily recurring transfers");

        try {
            List<Transaction> recurringTransfers = em.createNamedQuery("Transaction.findRecurringTransfers", Transaction.class)
                    .getResultList();

            LocalDateTime now = LocalDateTime.now();

            for (Transaction transaction : recurringTransfers) {
                if (transaction.getNextExecutionDate() != null &&
                        transaction.getNextExecutionDate().isBefore(now.plusHours(1))) {

                    processRecurringTransfer(transaction);
                }
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing recurring transfers", e);
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    @RolesAllowed({"USER", "ADMIN"})
    public List<Transaction> getTransactionHistory(Long accountId, LocalDateTime startDate, LocalDateTime endDate) {
        try {
            TypedQuery<Transaction> query;

            if (startDate != null && endDate != null) {
                query = em.createNamedQuery("Transaction.findByDateRange", Transaction.class);
                query.setParameter("startDate", startDate);
                query.setParameter("endDate", endDate);
            } else {
                query = em.createNamedQuery("Transaction.findByAccountId", Transaction.class);
            }

            query.setParameter("accountId", accountId);
            query.setMaxResults(100); // Limit for performance

            return query.getResultList();

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching transaction history", e);
            return List.of();
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    @RolesAllowed({"USER", "ADMIN"})
    public Transaction getTransactionById(Long transactionId) {
        try {
            return em.find(Transaction.class, transactionId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching transaction by ID", e);
            return null;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @RolesAllowed({"USER", "ADMIN"})
    public boolean cancelTransfer(Long transactionId, Long userId) {
        try {
            Transaction transaction = em.find(Transaction.class, transactionId);

            if (transaction != null &&
                    (transaction.getStatus() == TransactionStatus.SCHEDULED ||
                            transaction.getStatus() == TransactionStatus.ACTIVE) &&
                    transaction.getCreatedBy().equals(userId)) {

                transaction.setStatus(TransactionStatus.CANCELLED);
                transaction.setProcessedDate(LocalDateTime.now());
                transaction.setProcessedBy(userId);
                em.merge(transaction);

                // Cancel associated timers if any
                cancelAssociatedTimers(transactionId);

                return true;
            }

            return false;

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error cancelling transfer", e);
            sessionContext.setRollbackOnly();
            return false;
        }
    }



    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public TransferResult validateTransferRequest(TransferRequest request) {
        logger.info("=================================================================");
        logger.info("TRANSFER REQUEST VALIDATION STARTED");
        logger.info("=================================================================");
        
        logger.info("Validating transfer request:");
        logger.info("  - User ID: " + request.getUserId());
        logger.info("  - From Account ID: " + request.getFromAccountId());
        logger.info("  - To Account: " + request.getToAccount());
        logger.info("  - Amount: " + request.getAmount());
        logger.info("  - Transfer Type: " + request.getTransferType());
        
        // Basic validation
        logger.info("Performing basic field validation...");
        
        if (request.getFromAccountId() == null) {
            logger.warning("Validation failed: Source account is missing");
            return TransferResult.failure("Source account is required", "MISSING_FROM_ACCOUNT");
        }
        logger.info("✓ Source account ID validation passed");

        if (request.getToAccount() == null || request.getToAccount().trim().isEmpty()) {
            logger.warning("Validation failed: Destination account is missing");
            return TransferResult.failure("Destination account is required", "MISSING_TO_ACCOUNT");
        }
        logger.info("✓ Destination account validation passed");

        if (request.getAmount() == null || request.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            logger.warning("Validation failed: Invalid amount - " + request.getAmount());
            return TransferResult.failure("Valid amount is required", "INVALID_AMOUNT");
        }
        logger.info("✓ Amount validation passed");

        if (request.getAmount().compareTo(new BigDecimal("1000000")) > 0) {
            logger.warning("Validation failed: Amount exceeds limit - " + request.getAmount());
            return TransferResult.failure("Amount exceeds maximum transfer limit", "AMOUNT_LIMIT_EXCEEDED");
        }
        logger.info("✓ Amount limit validation passed");
        
        // Additional validations based on transfer type
        if (request.getTransferType() != null) {
            logger.info("Validating transfer type specific requirements...");
            switch (request.getTransferType().toUpperCase()) {
                case "SCHEDULED":
                    if (request.getScheduledDateTime() == null) {
                        logger.warning("Validation failed: Scheduled transfer missing date/time");
                        return TransferResult.failure("Scheduled date/time is required", "MISSING_SCHEDULE_DATE");
                    }
                    if (request.getScheduledDateTime().isBefore(LocalDateTime.now())) {
                        logger.warning("Validation failed: Scheduled date in past - " + request.getScheduledDateTime());
                        return TransferResult.failure("Scheduled date must be in future", "INVALID_SCHEDULE_DATE");
                    }
                    logger.info("✓ Scheduled transfer validation passed");
                    break;
                    
                case "RECURRING":
                    if (request.getStartDate() == null) {
                        logger.warning("Validation failed: Recurring transfer missing start date");
                        return TransferResult.failure("Start date is required for recurring transfers", "MISSING_START_DATE");
                    }
                    if (request.getFrequency() == null || request.getFrequency().trim().isEmpty()) {
                        logger.warning("Validation failed: Recurring transfer missing frequency");
                        return TransferResult.failure("Frequency is required for recurring transfers", "MISSING_FREQUENCY");
                    }
                    logger.info("✓ Recurring transfer validation passed");
                    break;
                    
                default:
                    logger.info("✓ Standard transfer validation (no additional requirements)");
                    break;
            }
        }

        logger.info("All validation checks passed successfully");
        logger.info("=================================================================");
        logger.info("TRANSFER REQUEST VALIDATION COMPLETED");
        logger.info("=================================================================");
        
        return TransferResult.success("Validation passed", null);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    @RolesAllowed({"USER", "ADMIN"})
    public List<Transaction> getPendingTransfers(Long userId) {
        try {
            TypedQuery<Transaction> query = em.createQuery(
                    "SELECT t FROM Transaction t WHERE t.createdBy = :userId AND " +
                            "(t.status = 'SCHEDULED' OR t.status = 'ACTIVE') ORDER BY t.nextExecutionDate ASC",
                    Transaction.class
            );
            query.setParameter("userId", userId);
            query.setMaxResults(50);

            return query.getResultList();

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching pending transfers", e);
            return List.of();
        }
    }

    // Private helper methods
    private boolean executeTransfer(BankAccount fromAccount, TransferRequest request, Transaction transaction) {
        logger.info("=================================================================");
        logger.info("FUND TRANSFER EXECUTION STARTED");
        logger.info("=================================================================");
        
        try {
            logger.info("Transfer execution details:");
            logger.info("  - From Account: " + fromAccount.getAccountNumber());
            logger.info("  - From Account Balance (before): " + fromAccount.getBalance());
            logger.info("  - To Account: " + request.getToAccount());
            logger.info("  - Transfer Amount: " + request.getAmount());
            logger.info("  - Transaction ID: " + transaction.getTransactionId());
            
            // Deduct from source account
            logger.info("Deducting amount from source account...");
            BigDecimal originalBalance = fromAccount.getBalance();
            BigDecimal newBalance = fromAccount.getBalance().subtract(request.getAmount());
            
            logger.info("Balance calculation:");
            logger.info("  - Original Balance: " + originalBalance);
            logger.info("  - Transfer Amount: " + request.getAmount());
            logger.info("  - New Balance: " + newBalance);
            
            if (newBalance.compareTo(BigDecimal.ZERO) < 0) {
                logger.severe("CRITICAL: New balance would be negative! Transfer aborted.");
                logger.severe("This should not happen as balance was checked earlier.");
                return false;
            }
            
            fromAccount.setBalance(newBalance);
            logger.info("Updating account balance in database...");
            em.merge(fromAccount);
            
            transaction.setBalanceAfterTransaction(newBalance);
            logger.info("Transaction updated with new balance: " + newBalance);

            // Process destination account crediting
            logger.info("Destination account processing:");
            logger.info("  - Destination: " + request.getToAccount());
            
            if (isInternalAccount(request.getToAccount())) {
                logger.info("  - Type: Internal account transfer");
                
                // Credit the destination account
                BankAccount toAccount = accountService.getAccountByNumber(request.getToAccount());
                if (toAccount != null) {
                    logger.info("  - Destination account found: " + toAccount.getAccountNumber());
                    logger.info("  - Destination balance (before): " + toAccount.getBalance());
                    
                    BigDecimal newToBalance = toAccount.getBalance().add(request.getAmount());
                    toAccount.setBalance(newToBalance);
                    em.merge(toAccount);
                    
                    logger.info("  - Destination balance (after): " + newToBalance);
                    logger.info("  - INTERNAL TRANSFER COMPLETED: Funds transferred from " + 
                               fromAccount.getAccountNumber() + " to " + toAccount.getAccountNumber());
                    
                    // Create a corresponding credit transaction record for the destination account
                    Transaction creditTransaction = new Transaction(
                        toAccount.getId(),
                        fromAccount.getAccountNumber(),
                        request.getAmount(),
                        TransactionType.DEPOSIT,
                        TransferType.IMMEDIATE,
                        "Transfer received from " + fromAccount.getAccountNumber() + 
                        (request.getDescription() != null ? " - " + request.getDescription() : ""),
                        request.getUserId()
                    );
                    creditTransaction.setStatus(TransactionStatus.COMPLETED);
                    creditTransaction.setProcessedDate(LocalDateTime.now());
                    creditTransaction.setBalanceAfterTransaction(newToBalance);
                    creditTransaction.setReferenceNumber(transaction.getReferenceNumber() + "-CR");
                    em.persist(creditTransaction);
                    
                    logger.info("  - Credit transaction record created: " + creditTransaction.getReferenceNumber());
                } else {
                    logger.severe("  - CRITICAL ERROR: Destination account not found: " + request.getToAccount());
                    logger.severe("  - Reversing debit transaction...");
                    
                    // Reverse the debit - restore original balance
                    fromAccount.setBalance(originalBalance);
                    em.merge(fromAccount);
                    transaction.setBalanceAfterTransaction(originalBalance);
                    
                    logger.severe("  - Debit transaction reversed. Balance restored to: " + originalBalance);
                    return false;
                }
                
            } else if (isEmailAddress(request.getToAccount())) {
                logger.info("  - Type: Email-based transfer");
                logger.info("  - External transfer to email: " + request.getToAccount());
                logger.info("  - Amount successfully debited from source account");
                logger.info("  - Note: External email transfers are processed by external payment gateway");
                // For email transfers, we assume the external gateway will handle delivery
                
            } else {
                logger.info("  - Type: External account transfer");
                logger.info("  - External transfer to account: " + request.getToAccount());
                logger.info("  - Amount successfully debited from source account");
                logger.info("  - Note: External transfers are processed by external banking network");
                // For external account transfers, we assume the external bank will handle delivery
            }

            logger.info("Transfer execution completed successfully");
            logger.info("Source account balance updated from " + originalBalance + " to " + newBalance);
            return true;

        } catch (Exception e) {
            logger.log(Level.SEVERE, "CRITICAL ERROR during fund transfer execution", e);
            logger.severe("Transfer execution failed:");
            logger.severe("  - Account: " + fromAccount.getAccountNumber());
            logger.severe("  - Amount: " + request.getAmount());
            logger.severe("  - Error: " + e.getMessage());
            return false;
        } finally {
            logger.info("=================================================================");
            logger.info("FUND TRANSFER EXECUTION ENDED");
            logger.info("=================================================================");
        }
    }
    
    private boolean isInternalAccount(String toAccount) {
        // Check if the destination account is an internal bank account
        // Pattern: ACC1234567890, SAV1234567890, etc.
        return toAccount != null && toAccount.matches("^[A-Z]{3}\\d{10}$");
    }
    
    private boolean isEmailAddress(String toAccount) {
        // Simple email validation
        return toAccount != null && toAccount.contains("@") && toAccount.contains(".");
    }

    private void executeScheduledTransfer(Transaction transaction) {
        logger.info("=================================================================");
        logger.info("SCHEDULED TRANSFER EXECUTION STARTED");
        logger.info("=================================================================");
        logger.info("Executing scheduled transfer:");
        logger.info("  - Transaction ID: " + transaction.getTransactionId());
        logger.info("  - Reference: " + transaction.getReferenceNumber());
        logger.info("  - Amount: " + transaction.getAmount());
        logger.info("  - From Account ID: " + transaction.getFromAccountId());
        logger.info("  - To Account: " + transaction.getToAccountIdentifier());
        
        try {
            // Get the source account
            BankAccount fromAccount = accountService.getAccountById(transaction.getFromAccountId());
            if (fromAccount == null) {
                logger.severe("CRITICAL: Source account not found - Account ID: " + transaction.getFromAccountId());
                transaction.setStatus(TransactionStatus.FAILED);
                transaction.setFailureReason("Source account not found");
                transaction.setProcessedDate(LocalDateTime.now());
                em.merge(transaction);
                return;
            }
            
            // Check sufficient balance
            if (fromAccount.getBalance().compareTo(transaction.getAmount()) < 0) {
                logger.warning("INSUFFICIENT BALANCE - Required: " + transaction.getAmount() + 
                              ", Available: " + fromAccount.getBalance());
                transaction.setStatus(TransactionStatus.FAILED);
                transaction.setFailureReason("Insufficient balance");
                transaction.setProcessedDate(LocalDateTime.now());
                em.merge(transaction);
                return;
            }
            
            // Update transaction status to processing
            transaction.setStatus(TransactionStatus.PROCESSING);
            transaction.setProcessedDate(LocalDateTime.now());
            em.merge(transaction);
            
            // Create a TransferRequest object for the execution
            TransferRequest request = new TransferRequest();
            request.setFromAccountId(transaction.getFromAccountId());
            request.setToAccount(transaction.getToAccountIdentifier());
            request.setAmount(transaction.getAmount());
            request.setDescription(transaction.getDescription());
            request.setTransferType("IMMEDIATE"); // Execute as immediate for processing
            request.setUserId(transaction.getCreatedBy());
            
            // Execute the transfer using the existing executeTransfer method
            boolean transferSuccess = executeTransfer(fromAccount, request, transaction);
            
            if (transferSuccess) {
                logger.info("Scheduled transfer executed successfully");
                transaction.setStatus(TransactionStatus.COMPLETED);
                transaction.setProcessedDate(LocalDateTime.now());
                transaction.setProcessedBy(transaction.getCreatedBy());
                em.merge(transaction);
            } else {
                logger.severe("Scheduled transfer execution failed");
                transaction.setStatus(TransactionStatus.FAILED);
                transaction.setFailureReason("Transfer execution failed");
                transaction.setProcessedDate(LocalDateTime.now());
                em.merge(transaction);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error executing scheduled transfer", e);
            transaction.setStatus(TransactionStatus.FAILED);
            transaction.setFailureReason("System error: " + e.getMessage());
            transaction.setProcessedDate(LocalDateTime.now());
            em.merge(transaction);
        } finally {
            logger.info("=================================================================");
            logger.info("SCHEDULED TRANSFER EXECUTION ENDED");
            logger.info("=================================================================");
        }
    }

    private void processRecurringTransfer(Transaction transaction) {
        logger.info("=================================================================");
        logger.info("RECURRING TRANSFER PROCESSING STARTED");
        logger.info("=================================================================");
        logger.info("Processing recurring transfer:");
        logger.info("  - Transaction ID: " + transaction.getTransactionId());
        logger.info("  - Reference: " + transaction.getReferenceNumber());
        logger.info("  - Amount: " + transaction.getAmount());
        logger.info("  - Frequency: " + transaction.getFrequency());
        logger.info("  - Next Execution: " + transaction.getNextExecutionDate());
        
        try {
            // Check if the recurring transfer is still active and within date range
            LocalDateTime now = LocalDateTime.now();
            if (transaction.getEndDate() != null && now.isAfter(transaction.getEndDate())) {
                logger.info("Recurring transfer has expired, marking as completed");
                transaction.setStatus(TransactionStatus.COMPLETED);
                transaction.setProcessedDate(LocalDateTime.now());
                em.merge(transaction);
                return;
            }
            
            // Get the source account
            BankAccount fromAccount = accountService.getAccountById(transaction.getFromAccountId());
            if (fromAccount == null) {
                logger.severe("CRITICAL: Source account not found - Account ID: " + transaction.getFromAccountId());
                return;
            }
            
            // Check sufficient balance
            if (fromAccount.getBalance().compareTo(transaction.getAmount()) < 0) {
                logger.warning("INSUFFICIENT BALANCE for recurring transfer - Required: " + transaction.getAmount() + 
                              ", Available: " + fromAccount.getBalance());
                // Update next execution date and continue (don't mark as failed)
                transaction.setNextExecutionDate(calculateNextExecutionDate(
                    transaction.getNextExecutionDate(), 
                    transaction.getFrequency().toString()));
                em.merge(transaction);
                return;
            }
            
            // Create a new transaction instance for this execution
            Transaction newTransaction = new Transaction(
                transaction.getFromAccountId(),
                transaction.getToAccountIdentifier(),
                transaction.getAmount(),
                TransactionType.TRANSFER,
                TransferType.RECURRING,
                "Recurring transfer: " + transaction.getDescription(),
                transaction.getCreatedBy()
            );
            
            newTransaction.setStatus(TransactionStatus.PROCESSING);
            em.persist(newTransaction);
            em.flush();
            
            // Create a TransferRequest object for the execution
            TransferRequest request = new TransferRequest();
            request.setFromAccountId(transaction.getFromAccountId());
            request.setToAccount(transaction.getToAccountIdentifier());
            request.setAmount(transaction.getAmount());
            request.setDescription("Recurring transfer: " + transaction.getDescription());
            request.setTransferType("IMMEDIATE"); // Execute as immediate for processing
            request.setUserId(transaction.getCreatedBy());
            
            // Execute the transfer
            boolean transferSuccess = executeTransfer(fromAccount, request, newTransaction);
            
            if (transferSuccess) {
                logger.info("Recurring transfer executed successfully");
                newTransaction.setStatus(TransactionStatus.COMPLETED);
                newTransaction.setProcessedDate(LocalDateTime.now());
                newTransaction.setProcessedBy(transaction.getCreatedBy());
                em.merge(newTransaction);
                
                // Update the next execution date for the recurring transaction
                LocalDateTime nextExecution = calculateNextExecutionDate(
                    transaction.getNextExecutionDate(), 
                    transaction.getFrequency().toString());
                transaction.setNextExecutionDate(nextExecution);
                em.merge(transaction);
                
                logger.info("Next recurring transfer scheduled for: " + nextExecution);
            } else {
                logger.severe("Recurring transfer execution failed");
                newTransaction.setStatus(TransactionStatus.FAILED);
                newTransaction.setFailureReason("Transfer execution failed");
                newTransaction.setProcessedDate(LocalDateTime.now());
                em.merge(newTransaction);
                
                // Still update next execution date to try again next time
                transaction.setNextExecutionDate(calculateNextExecutionDate(
                    transaction.getNextExecutionDate(), 
                    transaction.getFrequency().toString()));
                em.merge(transaction);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing recurring transfer", e);
            // Update next execution date even on error to prevent infinite retries
            transaction.setNextExecutionDate(calculateNextExecutionDate(
                transaction.getNextExecutionDate(), 
                transaction.getFrequency().toString()));
            em.merge(transaction);
        } finally {
            logger.info("=================================================================");
            logger.info("RECURRING TRANSFER PROCESSING ENDED");
            logger.info("=================================================================");
        }
    }

    private LocalDateTime calculateNextExecutionDate(LocalDateTime startDate, String frequency) {
        switch (RecurrenceFrequency.valueOf(frequency)) {
            case DAILY:
                return startDate.plusDays(1);
            case WEEKLY:
                return startDate.plusWeeks(1);
            case MONTHLY:
                return startDate.plusMonths(1);
            case QUARTERLY:
                return startDate.plusMonths(3);
            case ANNUALLY:
                return startDate.plusYears(1);
            default:
                return startDate.plusMonths(1);
        }
    }

    private void cancelAssociatedTimers(Long transactionId) {
        // Implementation to cancel EJB timers associated with the transaction
        for (Timer timer : timerService.getTimers()) {
            if (timer.getInfo().equals(transactionId)) {
                timer.cancel();
                break;
            }
        }
    }
}
