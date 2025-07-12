package lk.jiat.bankauto.core.dto;

import java.math.BigDecimal;

public class AccountCreationRequest {
    private Long userId;
    private String accountType;
    private String accountName;
    private BigDecimal initialDeposit;
    private String currency;
    private String purpose;
    private String documents;
    private Boolean paperlessStatements;
    private Boolean mobileAlerts;
    private Boolean agreeTerms;

    public AccountCreationRequest() {}

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public BigDecimal getInitialDeposit() {
        return initialDeposit;
    }

    public void setInitialDeposit(BigDecimal initialDeposit) {
        this.initialDeposit = initialDeposit;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getDocuments() {
        return documents;
    }

    public void setDocuments(String documents) {
        this.documents = documents;
    }

    public Boolean getPaperlessStatements() {
        return paperlessStatements;
    }

    public void setPaperlessStatements(Boolean paperlessStatements) {
        this.paperlessStatements = paperlessStatements;
    }

    public Boolean getMobileAlerts() {
        return mobileAlerts;
    }

    public void setMobileAlerts(Boolean mobileAlerts) {
        this.mobileAlerts = mobileAlerts;
    }

    public Boolean getAgreeTerms() {
        return agreeTerms;
    }

    public void setAgreeTerms(Boolean agreeTerms) {
        this.agreeTerms = agreeTerms;
    }
}
