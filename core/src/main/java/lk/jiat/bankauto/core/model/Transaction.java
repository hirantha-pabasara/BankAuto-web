package lk.jiat.bankauto.core.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lk.jiat.bankauto.core.enums.RecurrenceFrequency;
import lk.jiat.bankauto.core.enums.TransactionStatus;
import lk.jiat.bankauto.core.enums.TransactionType;
import lk.jiat.bankauto.core.enums.TransferType;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
@NamedQueries({
        @NamedQuery(name = "Transaction.findByAccountId",
                query = "SELECT t FROM Transaction t WHERE t.fromAccountId = :accountId OR t.toAccountId = :accountId ORDER BY t.transactionDate DESC"),
        @NamedQuery(name = "Transaction.findByDateRange",
                query = "SELECT t FROM Transaction t WHERE t.transactionDate BETWEEN :startDate AND :endDate ORDER BY t.transactionDate DESC"),
        @NamedQuery(name = "Transaction.findScheduledTransfers",
                query = "SELECT t FROM Transaction t WHERE t.status = 'SCHEDULED' AND t.scheduledDateTime <= :currentTime"),
        @NamedQuery(name = "Transaction.findRecurringTransfers",
                query = "SELECT t FROM Transaction t WHERE t.transferType = 'RECURRING' AND t.status = 'ACTIVE'"),
        @NamedQuery(name = "Transaction.findByAccountIdAndDateRange",
                query = "SELECT t FROM Transaction t WHERE (t.fromAccountId = :accountId OR t.toAccountId = :accountId) AND t.transactionDate BETWEEN :startDate AND :endDate ORDER BY t.transactionDate DESC")

})
public class Transaction implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaction_id")
    private Long transactionId;

    @NotNull
    @Column(name = "from_account_id")
    private Long fromAccountId;

    @Column(name = "to_account_id")
    private Long toAccountId;

    @NotBlank
    @Size(max = 50)
    @Column(name = "to_account_identifier")
    private String toAccountIdentifier; // Account number or email

    @NotNull
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @Digits(integer = 10, fraction = 2)
    @Column(name = "amount", precision = 12, scale = 2)
    private BigDecimal amount;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "transaction_type")
    private TransactionType transactionType;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "transfer_type")
    private TransferType transferType;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private TransactionStatus status;

    @Size(max = 200)
    @Column(name = "description")
    private String description;

    @NotNull
    @Column(name = "transaction_date")
    private LocalDateTime transactionDate;

    @Column(name = "scheduled_date_time")
    private LocalDateTime scheduledDateTime;

    @Column(name = "start_date")
    private LocalDateTime startDate;

    @Column(name = "end_date")
    private LocalDateTime endDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "frequency")
    private RecurrenceFrequency frequency;

    @Column(name = "next_execution_date")
    private LocalDateTime nextExecutionDate;

    @Column(name = "processed_date")
    private LocalDateTime processedDate;

    @NotNull
    @Column(name = "created_by")
    private Long createdBy;

    @Column(name = "processed_by")
    private Long processedBy;

    @Size(max = 100)
    @Column(name = "reference_number")
    private String referenceNumber;

    @Column(name = "balance_after_transaction", precision = 12, scale = 2)
    private BigDecimal balanceAfterTransaction;

    @Size(max = 500)
    @Column(name = "failure_reason")
    private String failureReason;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Constructors
    public Transaction() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public Transaction(Long fromAccountId, String toAccountIdentifier, BigDecimal amount,
                       TransactionType transactionType, TransferType transferType,
                       String description, Long createdBy) {
        this();
        this.fromAccountId = fromAccountId;
        this.toAccountIdentifier = toAccountIdentifier;
        this.amount = amount;
        this.transactionType = transactionType;
        this.transferType = transferType;
        this.description = description;
        this.createdBy = createdBy;
        this.status = TransactionStatus.PENDING;
        this.transactionDate = LocalDateTime.now();
        this.referenceNumber = generateReferenceNumber();
    }

    // Lifecycle callbacks
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        if (this.referenceNumber == null) {
            this.referenceNumber = generateReferenceNumber();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // Helper method to generate reference number
    private String generateReferenceNumber() {
        return "TXN" + System.currentTimeMillis() + String.format("%04d", (int)(Math.random() * 10000));
    }

    public Long getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Long transactionId) {
        this.transactionId = transactionId;
    }

    public Long getFromAccountId() {
        return fromAccountId;
    }

    public void setFromAccountId(Long fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    public Long getToAccountId() {
        return toAccountId;
    }

    public void setToAccountId(Long toAccountId) {
        this.toAccountId = toAccountId;
    }

    public String getToAccountIdentifier() {
        return toAccountIdentifier;
    }

    public void setToAccountIdentifier(String toAccountIdentifier) {
        this.toAccountIdentifier = toAccountIdentifier;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public TransferType getTransferType() {
        return transferType;
    }

    public void setTransferType(TransferType transferType) {
        this.transferType = transferType;
    }

    public TransactionStatus getStatus() {
        return status;
    }

    public void setStatus(TransactionStatus status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(LocalDateTime transactionDate) {
        this.transactionDate = transactionDate;
    }

    public LocalDateTime getScheduledDateTime() {
        return scheduledDateTime;
    }

    public void setScheduledDateTime(LocalDateTime scheduledDateTime) {
        this.scheduledDateTime = scheduledDateTime;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public RecurrenceFrequency getFrequency() {
        return frequency;
    }

    public void setFrequency(RecurrenceFrequency frequency) {
        this.frequency = frequency;
    }

    public LocalDateTime getNextExecutionDate() {
        return nextExecutionDate;
    }

    public void setNextExecutionDate(LocalDateTime nextExecutionDate) {
        this.nextExecutionDate = nextExecutionDate;
    }

    public LocalDateTime getProcessedDate() {
        return processedDate;
    }

    public void setProcessedDate(LocalDateTime processedDate) {
        this.processedDate = processedDate;
    }

    public Long getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }

    public Long getProcessedBy() {
        return processedBy;
    }

    public void setProcessedBy(Long processedBy) {
        this.processedBy = processedBy;
    }

    public String getReferenceNumber() {
        return referenceNumber;
    }

    public void setReferenceNumber(String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    public BigDecimal getBalanceAfterTransaction() {
        return balanceAfterTransaction;
    }

    public void setBalanceAfterTransaction(BigDecimal balanceAfterTransaction) {
        this.balanceAfterTransaction = balanceAfterTransaction;
    }

    public String getFailureReason() {
        return failureReason;
    }

    public void setFailureReason(String failureReason) {
        this.failureReason = failureReason;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}

