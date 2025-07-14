//package lk.jiat.bankauto.core.util;
//
//import lk.jiat.bankauto.core.enums.TransactionType;
//
//import java.io.Serializable;
//import java.time.LocalDate;
//
//public class TransactionFilter implements Serializable {
//    private String accountId;
//    private String transactionType;
//    private LocalDate startDate;
//    private LocalDate endDate;
//    private Integer page;
//    private Integer size;
//    private String sortBy;
//    private String sortDirection;
//
//    // Default constructor
//    public TransactionFilter() {
//        this.page = 1;
//        this.size = 10;
//        this.sortBy = "transactionDate";
//        this.sortDirection = "DESC";
//    }
//
//    // Constructor with basic filters
//    public TransactionFilter(String accountId, String transactionType, LocalDate startDate, LocalDate endDate) {
//        this();
//        this.accountId = accountId;
//        this.transactionType = transactionType;
//        this.startDate = startDate;
//        this.endDate = endDate;
//    }
//
//    // Constructor with pagination
//    public TransactionFilter(String accountId, String transactionType, LocalDate startDate,
//                             LocalDate endDate, Integer page, Integer size) {
//        this(accountId, transactionType, startDate, endDate);
//        this.page = page != null ? page : 1;
//        this.size = size != null ? size : 10;
//    }
//
//    // Constructor with all parameters
//    public TransactionFilter(String accountId, String transactionType, LocalDate startDate,
//                             LocalDate endDate, Integer page, Integer size, String sortBy, String sortDirection) {
//        this(accountId, transactionType, startDate, endDate, page, size);
//        this.sortBy = sortBy != null ? sortBy : "transactionDate";
//        this.sortDirection = sortDirection != null ? sortDirection : "DESC";
//    }
//
//    public String getAccountId() {
//        return accountId;
//    }
//
//    public void setAccountId(String accountId) {
//        this.accountId = accountId;
//    }
//
//    public String getTransactionType() {
//        return transactionType;
//    }
//
//    public void setTransactionType(String transactionType) {
//        this.transactionType = transactionType;
//    }
//
//    public LocalDate getStartDate() {
//        return startDate;
//    }
//
//    public void setStartDate(LocalDate startDate) {
//        this.startDate = startDate;
//    }
//
//    public LocalDate getEndDate() {
//        return endDate;
//    }
//
//    public void setEndDate(LocalDate endDate) {
//        this.endDate = endDate;
//    }
//
//    public Integer getPage() {
//        return page;
//    }
//
//    public void setPage(Integer page) {
//        this.page = page;
//    }
//
//    public Integer getSize() {
//        return size;
//    }
//
//    public void setSize(Integer size) {
//        this.size = size;
//    }
//
//    public String getSortBy() {
//        return sortBy;
//    }
//
//    public void setSortBy(String sortBy) {
//        this.sortBy = sortBy;
//    }
//
//    public String getSortDirection() {
//        return sortDirection;
//    }
//
//    public void setSortDirection(String sortDirection) {
//        this.sortDirection = sortDirection;
//    }
//}

package lk.jiat.bankauto.core.util;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * Utility class for filtering transactions
 * Used to encapsulate filtering criteria for transaction queries
 */
public class TransactionFilter implements Serializable {

    private String accountId;
    private String transactionType;
    private LocalDate startDate;
    private LocalDate endDate;
    private Integer page;
    private Integer size;
    private String sortBy;
    private String sortDirection;

    // Default constructor
    public TransactionFilter() {
        this.page = 1;
        this.size = 10;
        this.sortBy = "transactionDate";
        this.sortDirection = "DESC";
    }

    // Constructor with basic filters
    public TransactionFilter(String accountId, String transactionType, LocalDate startDate, LocalDate endDate) {
        this();
        this.accountId = accountId;
        this.transactionType = transactionType;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Constructor with pagination
    public TransactionFilter(String accountId, String transactionType, LocalDate startDate,
                             LocalDate endDate, Integer page, Integer size) {
        this(accountId, transactionType, startDate, endDate);
        this.page = page != null ? page : 1;
        this.size = size != null ? size : 10;
    }

    // Constructor with all parameters
    public TransactionFilter(String accountId, String transactionType, LocalDate startDate,
                             LocalDate endDate, Integer page, Integer size, String sortBy, String sortDirection) {
        this(accountId, transactionType, startDate, endDate, page, size);
        this.sortBy = sortBy != null ? sortBy : "transactionDate";
        this.sortDirection = sortDirection != null ? sortDirection : "DESC";
    }

    // Getters and Setters
    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page != null && page > 0 ? page : 1;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size != null && size > 0 ? size : 10;
        // Limit maximum page size for performance
        if (this.size > 100) {
            this.size = 100;
        }
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        // Validate sort field to prevent SQL injection
        if (isValidSortField(sortBy)) {
            this.sortBy = sortBy;
        } else {
            this.sortBy = "transactionDate";
        }
    }

    public String getSortDirection() {
        return sortDirection;
    }

    public void setSortDirection(String sortDirection) {
        if ("ASC".equalsIgnoreCase(sortDirection) || "DESC".equalsIgnoreCase(sortDirection)) {
            this.sortDirection = sortDirection.toUpperCase();
        } else {
            this.sortDirection = "DESC";
        }
    }

    // Utility methods

    /**
     * Check if account filter is applied
     * @return true if account filter is set and not "all"
     */
    public boolean hasAccountFilter() {
        return accountId != null && !accountId.trim().isEmpty() && !"all".equalsIgnoreCase(accountId);
    }

    /**
     * Check if transaction type filter is applied
     * @return true if transaction type filter is set and not "all"
     */
    public boolean hasTransactionTypeFilter() {
        return transactionType != null && !transactionType.trim().isEmpty() && !"all".equalsIgnoreCase(transactionType);
    }

    /**
     * Check if date range filter is applied
     * @return true if either start date or end date is set
     */
    public boolean hasDateRangeFilter() {
        return startDate != null || endDate != null;
    }

    /**
     * Check if start date filter is applied
     * @return true if start date is set
     */
    public boolean hasStartDateFilter() {
        return startDate != null;
    }

    /**
     * Check if end date filter is applied
     * @return true if end date is set
     */
    public boolean hasEndDateFilter() {
        return endDate != null;
    }

    /**
     * Get the offset for pagination
     * @return offset value for database queries
     */
    public int getOffset() {
        return (page - 1) * size;
    }

    /**
     * Validate if the sort field is allowed to prevent SQL injection
     * @param sortField the field to validate
     * @return true if the field is valid
     */
    private boolean isValidSortField(String sortField) {
        if (sortField == null || sortField.trim().isEmpty()) {
            return false;
        }

        // List of allowed sort fields
        String[] allowedFields = {
                "transactionDate", "amount", "transactionType", "status",
                "createdAt", "accountNumber", "description", "id"
        };

        for (String field : allowedFields) {
            if (field.equalsIgnoreCase(sortField.trim())) {
                return true;
            }
        }

        return false;
    }

    /**
     * Reset all filters to default values
     */
    public void reset() {
        this.accountId = null;
        this.transactionType = null;
        this.startDate = null;
        this.endDate = null;
        this.page = 1;
        this.size = 10;
        this.sortBy = "transactionDate";
        this.sortDirection = "DESC";
    }

    /**
     * Check if any filters are applied
     * @return true if any filter is applied
     */
    public boolean hasAnyFilter() {
        return hasAccountFilter() || hasTransactionTypeFilter() || hasDateRangeFilter();
    }

    /**
     * Create a copy of this filter
     * @return a new TransactionFilter instance with the same values
     */
    public TransactionFilter copy() {
        return new TransactionFilter(
                this.accountId,
                this.transactionType,
                this.startDate,
                this.endDate,
                this.page,
                this.size,
                this.sortBy,
                this.sortDirection
        );
    }

    /**
     * Validate the filter parameters
     * @throws IllegalArgumentException if validation fails
     */
    public void validate() {
        if (page != null && page < 1) {
            throw new IllegalArgumentException("Page number must be greater than 0");
        }

        if (size != null && size < 1) {
            throw new IllegalArgumentException("Page size must be greater than 0");
        }

        if (size != null && size > 100) {
            throw new IllegalArgumentException("Page size cannot exceed 100");
        }

        if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date cannot be after end date");
        }

        // Validate date range is not too large (optional business rule)
        if (startDate != null && endDate != null) {
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate);
            if (daysBetween > 365) {
                throw new IllegalArgumentException("Date range cannot exceed 365 days");
            }
        }
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "TransactionFilter{" +
                "accountId='" + accountId + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", page=" + page +
                ", size=" + size +
                ", sortBy='" + sortBy + '\'' +
                ", sortDirection='" + sortDirection + '\'' +
                '}';
    }

    // equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TransactionFilter that = (TransactionFilter) o;

        if (accountId != null ? !accountId.equals(that.accountId) : that.accountId != null) return false;
        if (transactionType != null ? !transactionType.equals(that.transactionType) : that.transactionType != null)
            return false;
        if (startDate != null ? !startDate.equals(that.startDate) : that.startDate != null) return false;
        if (endDate != null ? !endDate.equals(that.endDate) : that.endDate != null) return false;
        if (page != null ? !page.equals(that.page) : that.page != null) return false;
        if (size != null ? !size.equals(that.size) : that.size != null) return false;
        if (sortBy != null ? !sortBy.equals(that.sortBy) : that.sortBy != null) return false;
        return sortDirection != null ? sortDirection.equals(that.sortDirection) : that.sortDirection == null;
    }

    @Override
    public int hashCode() {
        int result = accountId != null ? accountId.hashCode() : 0;
        result = 31 * result + (transactionType != null ? transactionType.hashCode() : 0);
        result = 31 * result + (startDate != null ? startDate.hashCode() : 0);
        result = 31 * result + (endDate != null ? endDate.hashCode() : 0);
        result = 31 * result + (page != null ? page.hashCode() : 0);
        result = 31 * result + (size != null ? size.hashCode() : 0);
        result = 31 * result + (sortBy != null ? sortBy.hashCode() : 0);
        result = 31 * result + (sortDirection != null ? sortDirection.hashCode() : 0);
        return result;
    }

    // Static factory methods for common filter scenarios

    /**
     * Create a filter for a specific account
     * @param accountId the account ID to filter by
     * @return new TransactionFilter instance
     */
    public static TransactionFilter forAccount(String accountId) {
        TransactionFilter filter = new TransactionFilter();
        filter.setAccountId(accountId);
        return filter;
    }

    /**
     * Create a filter for a specific transaction type
     * @param transactionType the transaction type to filter by
     * @return new TransactionFilter instance
     */
    public static TransactionFilter forTransactionType(String transactionType) {
        TransactionFilter filter = new TransactionFilter();
        filter.setTransactionType(transactionType);
        return filter;
    }

    /**
     * Create a filter for a specific date range
     * @param startDate the start date
     * @param endDate the end date
     * @return new TransactionFilter instance
     */
    public static TransactionFilter forDateRange(LocalDate startDate, LocalDate endDate) {
        TransactionFilter filter = new TransactionFilter();
        filter.setStartDate(startDate);
        filter.setEndDate(endDate);
        return filter;
    }

    /**
     * Create a filter with pagination
     * @param page the page number
     * @param size the page size
     * @return new TransactionFilter instance
     */
    public static TransactionFilter withPagination(int page, int size) {
        TransactionFilter filter = new TransactionFilter();
        filter.setPage(page);
        filter.setSize(size);
        return filter;
    }
}
