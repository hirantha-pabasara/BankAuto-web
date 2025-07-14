package lk.jiat.bankauto.core.dto;
//
//import java.io.Serializable;
//import java.math.BigDecimal;
//import java.time.LocalDateTime;
//
//public class TransferRequest implements Serializable {
//    private Long fromAccountId;
//    private String fromAccountNumber;
//    private String toAccount;
//    private BigDecimal amount;
//    private String description;
//    private String transferType; // IMMEDIATE, SCHEDULED, RECURRING
//    private LocalDateTime scheduledDateTime;
//    private LocalDateTime startDate;
//    private LocalDateTime endDate;
//    private String frequency; // WEEKLY, MONTHLY, QUARTERLY, ANNUALLY
//    private String timestamp;
//    private Long userId;
//
//    public TransferRequest() {}
//
//    public Long getFromAccountId() {
//        return fromAccountId;
//    }
//
//    public void setFromAccountId(Long fromAccountId) {
//        this.fromAccountId = fromAccountId;
//    }
//
//    public String getFromAccountNumber() {
//        return fromAccountNumber;
//    }
//
//    public void setFromAccountNumber(String fromAccountNumber) {
//        this.fromAccountNumber = fromAccountNumber;
//    }
//
//    public String getToAccount() {
//        return toAccount;
//    }
//
//    public void setToAccount(String toAccount) {
//        this.toAccount = toAccount;
//    }
//
//    public BigDecimal getAmount() {
//        return amount;
//    }
//
//    public void setAmount(BigDecimal amount) {
//        this.amount = amount;
//    }
//
//    public String getDescription() {
//        return description;
//    }
//
//    public void setDescription(String description) {
//        this.description = description;
//    }
//
//    public String getTransferType() {
//        return transferType;
//    }
//
//    public void setTransferType(String transferType) {
//        this.transferType = transferType;
//    }
//
//    public LocalDateTime getScheduledDateTime() {
//        return scheduledDateTime;
//    }
//
//    public void setScheduledDateTime(LocalDateTime scheduledDateTime) {
//        this.scheduledDateTime = scheduledDateTime;
//    }
//
//    public LocalDateTime getStartDate() {
//        return startDate;
//    }
//
//    public void setStartDate(LocalDateTime startDate) {
//        this.startDate = startDate;
//    }
//
//    public LocalDateTime getEndDate() {
//        return endDate;
//    }
//
//    public void setEndDate(LocalDateTime endDate) {
//        this.endDate = endDate;
//    }
//
//    public String getFrequency() {
//        return frequency;
//    }
//
//    public void setFrequency(String frequency) {
//        this.frequency = frequency;
//    }
//
//    public String getTimestamp() {
//        return timestamp;
//    }
//
//    public void setTimestamp(String timestamp) {
//        this.timestamp = timestamp;
//    }
//
//    public Long getUserId() {
//        return userId;
//    }
//
//    public void setUserId(Long userId) {
//        this.userId = userId;
//    }
//}

import com.google.gson.annotations.SerializedName;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class TransferRequest {

    @SerializedName("fromAccountId")
    private Long fromAccountId;

    @SerializedName("fromAccountNumber")
    private String fromAccountNumber;

    @SerializedName("toAccount")
    private String toAccount;

    @SerializedName("amount")
    private BigDecimal amount;

    @SerializedName("description")
    private String description;

    @SerializedName("transferType")
    private String transferType; // IMMEDIATE, SCHEDULED, RECURRING

    @SerializedName("scheduledDateTime")
    private LocalDateTime scheduledDateTime;

    @SerializedName("startDate")
    private LocalDateTime startDate;

    @SerializedName("endDate")
    private LocalDateTime endDate;

    @SerializedName("frequency")
    private String frequency; // WEEKLY, MONTHLY, QUARTERLY, ANNUALLY

    @SerializedName("timestamp")
    private String timestamp;

    @SerializedName("userId")
    private Long userId;

    // Default constructor
    public TransferRequest() {}

    // Constructor with essential fields
    public TransferRequest(Long fromAccountId, String toAccount, BigDecimal amount, String transferType) {
        this.fromAccountId = fromAccountId;
        this.toAccount = toAccount;
        this.amount = amount;
        this.transferType = transferType;
    }

    // Getters and Setters
    public Long getFromAccountId() {
        return fromAccountId;
    }

    public void setFromAccountId(Long fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    public String getFromAccountNumber() {
        return fromAccountNumber;
    }

    public void setFromAccountNumber(String fromAccountNumber) {
        this.fromAccountNumber = fromAccountNumber;
    }

    public String getToAccount() {
        return toAccount;
    }

    public void setToAccount(String toAccount) {
        this.toAccount = toAccount;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTransferType() {
        return transferType;
    }

    public void setTransferType(String transferType) {
        this.transferType = transferType;
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

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "TransferRequest{" +
                "fromAccountId=" + fromAccountId +
                ", toAccount='" + toAccount + '\'' +
                ", amount=" + amount +
                ", transferType='" + transferType + '\'' +
                ", scheduledDateTime=" + scheduledDateTime +
                ", userId=" + userId +
                '}';
    }
}