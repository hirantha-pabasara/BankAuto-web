package lk.jiat.bankauto.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bankauto.core.dto.TransferRequest;
import lk.jiat.bankauto.core.dto.TransferResult;
import lk.jiat.bankauto.core.model.Transaction;

import java.time.LocalDateTime;
import java.util.List;

@Remote
public interface TransferService {
    TransferResult processImmediateTransfer(TransferRequest request);
    TransferResult scheduleTransfer(TransferRequest request);
    TransferResult setupRecurringTransfer(TransferRequest request);
    void processScheduledTransfers();
    void processRecurringTransfers();
    List<Transaction> getTransactionHistory(Long accountId, LocalDateTime startDate, LocalDateTime endDate);
    Transaction getTransactionById(Long transactionId);
    boolean cancelTransfer(Long transactionId, Long userId);
    TransferResult validateTransferRequest(TransferRequest request);
    List<Transaction> getPendingTransfers(Long userId);
    List<Transaction> getTransactionsByUserName(String userName, LocalDateTime startDate, LocalDateTime endDate);
}
