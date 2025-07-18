package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bankauto.core.dto.ResponseMessage;
import lk.jiat.bankauto.core.model.Transaction;
import lk.jiat.bankauto.core.service.AccountService;
import lk.jiat.bankauto.core.service.TransferService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/user/history")
public class TransactionHistoryServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(TransactionHistoryServlet.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private TransferService transferService;

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("TransactionHistoryServlet: Processing GET request for transaction history");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            logger.warning("No session found for transaction history request");
            ResponseMessage errorResponse = new ResponseMessage(false, "Session expired");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(errorResponse));
            return;
        }

        try {
            // Get user ID from session
            Long userId = (Long) session.getAttribute("userId");
            if (userId == null) {
                logger.warning("User ID not found in session");
                ResponseMessage errorResponse = new ResponseMessage(false, "User not authenticated");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write(gson.toJson(errorResponse));
                return;
            }

            logger.info("Loading transaction history for user: " + userId);

            // Get user's account IDs
            List<Long> userAccountIds = accountService.getAccountIdsByUserId(userId);

            if (userAccountIds.isEmpty()) {
                logger.info("No accounts found for user: " + userId);
                JsonObject successResponse = new JsonObject();
                successResponse.addProperty("success", true);
                successResponse.addProperty("message", "No accounts found");
                successResponse.add("transactions", new JsonArray());

                response.getWriter().write(gson.toJson(successResponse));
                return;
            }

            // Get recent transactions for all user accounts (last 30 days)
            LocalDateTime startDate = LocalDateTime.now().minusDays(30);
            LocalDateTime endDate = LocalDateTime.now();

            JsonArray allTransactions = new JsonArray();

            for (Long accountId : userAccountIds) {
                List<Transaction> accountTransactions = transferService.getTransactionHistory(
                        accountId, startDate, endDate
                );

                for (Transaction transaction : accountTransactions) {
                    JsonObject txnObj = convertTransactionToJson(transaction, accountId);
                    allTransactions.add(txnObj);
                }
            }

            // Sort transactions by date (newest first) and limit to 10
            JsonArray sortedTransactions = sortAndLimitTransactions(allTransactions, 10);

            // Create success response
            JsonObject successResponse = new JsonObject();
            successResponse.addProperty("success", true);
            successResponse.addProperty("message", "Transactions loaded successfully");
            successResponse.add("transactions", sortedTransactions);

            logger.info("Successfully loaded " + sortedTransactions.size() + " transactions for user: " + userId);
            response.getWriter().write(gson.toJson(successResponse));

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error loading transaction history", e);
            ResponseMessage errorResponse = new ResponseMessage(false, "Failed to load transactions");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(errorResponse));
        }
    }

    private JsonObject convertTransactionToJson(Transaction transaction, Long userAccountId) {
        JsonObject txnObj = new JsonObject();

        txnObj.addProperty("id", transaction.getTransactionId());
        txnObj.addProperty("date", transaction.getTransactionDate().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        txnObj.addProperty("type", formatTransactionType(transaction));
        txnObj.addProperty("description", formatDescription(transaction, userAccountId));

        // Determine if this is a debit or credit for the user
        double amount = transaction.getAmount().doubleValue();
        if (transaction.getFromAccountId().equals(userAccountId)) {
            // This is a debit transaction for the user
            amount = -amount;
        }

        txnObj.addProperty("amount", amount);
        txnObj.addProperty("status", transaction.getStatus().toString());
        txnObj.addProperty("referenceNumber", transaction.getReferenceNumber());

        return txnObj;
    }

    private String formatTransactionType(Transaction transaction) {
        switch (transaction.getTransactionType()) {
            case TRANSFER:
                switch (transaction.getTransferType()) {
                    case IMMEDIATE:
                        return "Transfer";
                    case SCHEDULED:
                        return "Scheduled Transfer";
                    case RECURRING:
                        return "Recurring Transfer";
                    default:
                        return "Transfer";
                }
            case DEPOSIT:
                return "Deposit";
            case WITHDRAWAL:
                return "Withdrawal";
            case PAYMENT:
                return "Payment";
            default:
                return transaction.getTransactionType().toString();
        }
    }

    private String formatDescription(Transaction transaction, Long userAccountId) {
        StringBuilder desc = new StringBuilder();

        if (transaction.getDescription() != null && !transaction.getDescription().isEmpty()) {
            desc.append(transaction.getDescription());
        } else {
            // Generate default description based on transaction type
            if (transaction.getTransactionType() == lk.jiat.bankauto.core.enums.TransactionType.TRANSFER) {
                if (transaction.getFromAccountId().equals(userAccountId)) {
                    desc.append("Transfer to ").append(transaction.getToAccountIdentifier());
                } else {
                    desc.append("Transfer from ").append(transaction.getFromAccountId());
                }
            } else {
                desc.append(transaction.getTransactionType().toString());
            }
        }

        return desc.toString();
    }

    private JsonArray sortAndLimitTransactions(JsonArray transactions, int limit) {
        // Convert to list for sorting
        List<JsonObject> transactionList = new ArrayList<>();
        for (int i = 0; i < transactions.size(); i++) {
            transactionList.add(transactions.get(i).getAsJsonObject());
        }

        // Sort by date (newest first)
        transactionList.sort((a, b) -> {
            String dateA = a.get("date").getAsString();
            String dateB = b.get("date").getAsString();
            return dateB.compareTo(dateA);
        });

        // Limit results
        JsonArray limitedTransactions = new JsonArray();
        for (int i = 0; i < Math.min(limit, transactionList.size()); i++) {
            limitedTransactions.add(transactionList.get(i));
        }

        return limitedTransactions;
    }
}
