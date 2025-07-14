package lk.jiat.bankauto.core.dto;
//
//import java.io.Serializable;
//
//public class TransferResult implements Serializable {
//    private boolean success;
//    private String message;
//    private String referenceNumber;
//    private String transactionId;
//    private String errorCode;
//
//    public TransferResult() {}
//
//    public TransferResult(boolean success, String message) {
//        this.success = success;
//        this.message = message;
//    }
//
//    public static TransferResult success(String message, String referenceNumber) {
//        TransferResult result = new TransferResult(true, message);
//        result.setReferenceNumber(referenceNumber);
//        return result;
//    }
//
//    public static TransferResult failure(String message, String errorCode) {
//        TransferResult result = new TransferResult(false, message);
//        result.setErrorCode(errorCode);
//        return result;
//    }
//
//    public boolean isSuccess() {
//        return success;
//    }
//
//    public void setSuccess(boolean success) {
//        this.success = success;
//    }
//
//    public String getMessage() {
//        return message;
//    }
//
//    public void setMessage(String message) {
//        this.message = message;
//    }
//
//    public String getReferenceNumber() {
//        return referenceNumber;
//    }
//
//    public void setReferenceNumber(String referenceNumber) {
//        this.referenceNumber = referenceNumber;
//    }
//
//    public String getTransactionId() {
//        return transactionId;
//    }
//
//    public void setTransactionId(String transactionId) {
//        this.transactionId = transactionId;
//    }
//
//    public String getErrorCode() {
//        return errorCode;
//    }
//
//    public void setErrorCode(String errorCode) {
//        this.errorCode = errorCode;
//    }
//}


import com.google.gson.annotations.SerializedName;

public class TransferResult {

    @SerializedName("success")
    private boolean success;

    @SerializedName("message")
    private String message;

    @SerializedName("referenceNumber")
    private String referenceNumber;

    @SerializedName("transactionId")
    private String transactionId;

    @SerializedName("errorCode")
    private String errorCode;

    // Default constructor
    public TransferResult() {}

    // Constructor with success and message
    public TransferResult(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    // Static factory methods for convenience
    public static TransferResult success(String message, String referenceNumber) {
        TransferResult result = new TransferResult(true, message);
        result.setReferenceNumber(referenceNumber);
        return result;
    }

    public static TransferResult failure(String message, String errorCode) {
        TransferResult result = new TransferResult(false, message);
        result.setErrorCode(errorCode);
        return result;
    }

    // Getters and Setters
    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getReferenceNumber() {
        return referenceNumber;
    }

    public void setReferenceNumber(String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    @Override
    public String toString() {
        return "TransferResult{" +
                "success=" + success +
                ", message='" + message + '\'' +
                ", referenceNumber='" + referenceNumber + '\'' +
                ", errorCode='" + errorCode + '\'' +
                '}';
    }
}
