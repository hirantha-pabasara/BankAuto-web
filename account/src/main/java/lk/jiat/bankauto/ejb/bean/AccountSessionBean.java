package lk.jiat.bankauto.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.bankauto.core.dto.AccountCreationRequest;
import lk.jiat.bankauto.core.enums.AccountStatus;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.service.AccountService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class AccountSessionBean implements AccountService {
    private static final Logger logger = Logger.getLogger(AccountSessionBean.class.getName());

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager em;

    @Override
    public BankAccount createAccount(AccountCreationRequest request) {
        try {
            // Generate account number
            String accountNumber = generateAccountNumber(request.getAccountType());

            // Create new account entity
            BankAccount account = new BankAccount(
                    request.getUserId(),
                    request.getAccountType(),
                    request.getAccountName(),
                    accountNumber,
                    request.getInitialDeposit(),
                    request.getCurrency(),
                    request.getPurpose()
            );

            account.setDocuments(request.getDocuments());
            account.setPaperlessStatements(request.getPaperlessStatements());
            account.setMobileAlerts(request.getMobileAlerts());
            account.setStatus(AccountStatus.PENDING_APPROVAL);

            // Persist to database
            em.persist(account);
            em.flush();

            logger.info("Account created successfully: " + accountNumber);
            return account;

        } catch (Exception e) {
            logger.severe("Error creating account: " + e.getMessage());
            throw new RuntimeException("Failed to create account", e);
        }
    }

    @Override
    public List<BankAccount> getUserAccounts(Long userId) {
        TypedQuery<BankAccount> query = em.createQuery(
                "SELECT a FROM BankAccount a WHERE a.userId = :userId ORDER BY a.createdAt DESC",
                BankAccount.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public BankAccount getAccountById(Long accountId) {
        return em.find(BankAccount.class, accountId);
    }

    @Override
    public BankAccount getAccountByNumber(String accountNumber) {
        TypedQuery<BankAccount> query = em.createQuery(
                "SELECT a FROM BankAccount a WHERE a.accountNumber = :accountNumber",
                BankAccount.class);
        query.setParameter("accountNumber", accountNumber);
        List<BankAccount> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<BankAccount> getPendingAccounts() {
        TypedQuery<BankAccount> query = em.createQuery(
                "SELECT a FROM BankAccount a WHERE a.status = :status ORDER BY a.createdAt ASC",
                BankAccount.class);
        query.setParameter("status", AccountStatus.PENDING_APPROVAL);
        return query.getResultList();
    }

    @Override
    public BankAccount approveAccount(Long accountId, Long approvedBy) {
        BankAccount account = em.find(BankAccount.class, accountId);
        if (account != null && account.getStatus() == AccountStatus.PENDING_APPROVAL) {
            account.setStatus(AccountStatus.ACTIVE);
            account.setApprovedBy(approvedBy);
            account.setApprovedAt(LocalDateTime.now());
            em.merge(account);
            logger.info("Account approved: " + account.getAccountNumber());
        }
        return account;
    }

    @Override
    public BankAccount rejectAccount(Long accountId, Long rejectedBy) {
        BankAccount account = em.find(BankAccount.class, accountId);
        if (account != null && account.getStatus() == AccountStatus.PENDING_APPROVAL) {
            account.setStatus(AccountStatus.CLOSED);
            account.setApprovedBy(rejectedBy);
            account.setApprovedAt(LocalDateTime.now());
            em.merge(account);
            logger.info("Account rejected: " + account.getAccountNumber());
        }
        return account;
    }

    @Override
    public String generateAccountNumber(String accountType) {
        String prefix;
        switch (accountType.toLowerCase()) {
            case "savings account":
                prefix = "SAV";
                break;
            case "checking account":
                prefix = "CHK";
                break;
            case "current account":
                prefix = "CUR";
                break;
            case "fixed deposit":
                prefix = "FD";
                break;
            default:
                prefix = "ACC";
        }

        // Generate random 10-digit number
        long number = (long) (Math.random() * 9000000000L) + 1000000000L;
        return prefix + number;
    }

    @Override
    public boolean hasAccountType(Long userId, String accountType) {
        TypedQuery<Long> query = em.createNamedQuery("BankAccount.hasAccountType", Long.class);
        query.setParameter("userId", userId);
        query.setParameter("accountType", accountType);
        return query.getSingleResult() > 0;
    }
}
