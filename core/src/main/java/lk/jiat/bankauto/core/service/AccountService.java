package lk.jiat.bankauto.core.service;

import jakarta.ejb.Local;
import lk.jiat.bankauto.core.dto.AccountCreationRequest;
import lk.jiat.bankauto.core.model.BankAccount;

import java.util.List;

@Local
public interface AccountService {
    BankAccount createAccount(AccountCreationRequest request);
    List<BankAccount> getUserAccounts(Long userId);
    BankAccount getAccountById(Long accountId);
    BankAccount getAccountByNumber(String accountNumber);
    List<BankAccount> getPendingAccounts();
    BankAccount approveAccount(Long accountId, Long approvedBy);
    BankAccount rejectAccount(Long accountId, Long rejectedBy);
    String generateAccountNumber(String accountType);
}
