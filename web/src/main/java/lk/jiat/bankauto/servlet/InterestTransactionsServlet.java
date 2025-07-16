package lk.jiat.bankauto.servlet;

import com.google.gson.*;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bankauto.core.model.Transaction;
import lk.jiat.bankauto.core.service.TransferService;

import java.io.IOException;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet(name = "InterestTransactionsServlet", urlPatterns = {
        "/api/interest/transactions",
        "/api/interest/summary"
})
public class InterestTransactionsServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(InterestTransactionsServlet.class.getName());
    private static final Gson gson;

    @EJB
    private TransferService transferService;

    // Initialize Gson with custom LocalDateTime serializer/deserializer
    static {
        gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeSerializer())
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeDeserializer())
                .setPrettyPrinting()
                .create();
    }

    // Custom LocalDateTime serializer for Gson
    private static class LocalDateTimeSerializer implements JsonSerializer<LocalDateTime> {
        @Override
        public JsonElement serialize(LocalDateTime localDateTime, Type type, JsonSerializationContext context) {
            return new JsonPrimitive(localDateTime.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        }
    }

    // Custom LocalDateTime deserializer for Gson
    private static class LocalDateTimeDeserializer implements JsonDeserializer<LocalDateTime> {
        @Override
        public LocalDateTime deserialize(JsonElement json, Type type, JsonDeserializationContext context)
                throws JsonParseException {
            return LocalDateTime.parse(json.getAsString(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"Please log in to continue\"}");
            return;
        }

        Long userId = (Long) session.getAttribute("userId");
        String pathInfo = request.getServletPath();

        try {
            if (pathInfo.equals("/api/interest/transactions")) {
                getInterestTransactions(request, response, userId);
            } else if (pathInfo.equals("/api/interest/summary")) {
                getInterestSummary(request, response, userId);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"success\":false,\"message\":\"Endpoint not found\"}");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing interest transactions request", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Internal server error\"}");
        }
    }

    /**
     * Get interest transactions for a specific account or all accounts
     */
    private void getInterestTransactions(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {
        
        try {
            logger.info("Fetching interest transactions for user: " + userId);
            
            // Get parameters
            String accountIdParam = request.getParameter("accountId");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            
            Long accountId = null;
            if (accountIdParam != null && !accountIdParam.trim().isEmpty()) {
                accountId = Long.parseLong(accountIdParam);
            }

            LocalDateTime startDate = null;
            LocalDateTime endDate = null;
            
            if (startDateParam != null && !startDateParam.trim().isEmpty()) {
                startDate = LocalDateTime.parse(startDateParam + "T00:00:00");
            }
            
            if (endDateParam != null && !endDateParam.trim().isEmpty()) {
                endDate = LocalDateTime.parse(endDateParam + "T23:59:59");
            }

            // Get all transactions for the date range
            List<Transaction> allTransactions = transferService.getTransactionHistory(accountId, startDate, endDate);
            
            // Filter for interest transactions only
            List<Transaction> interestTransactions = allTransactions.stream()
                    .filter(transaction -> "INTEREST".equals(transaction.getTransactionType().name()))
                    .collect(Collectors.toList());

            logger.info("Found " + interestTransactions.size() + " interest transactions out of " + 
                       allTransactions.size() + " total transactions");

            // Convert to JSON response
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("transactions", interestTransactions);
            result.put("totalCount", interestTransactions.size());

            String jsonResponse = gson.toJson(result);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching interest transactions", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to fetch interest transactions\"}");
        }
    }

    /**
     * Get interest summary (total interest earned, count, etc.)
     */
    private void getInterestSummary(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {
        
        try {
            logger.info("Fetching interest summary for user: " + userId);
            
            // Get parameters for date range
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            
            LocalDateTime startDate = null;
            LocalDateTime endDate = null;
            
            if (startDateParam != null && !startDateParam.trim().isEmpty()) {
                startDate = LocalDateTime.parse(startDateParam + "T00:00:00");
            } else {
                // Default to current year if no start date provided
                startDate = LocalDateTime.now().withDayOfYear(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
            }
            
            if (endDateParam != null && !endDateParam.trim().isEmpty()) {
                endDate = LocalDateTime.parse(endDateParam + "T23:59:59");
            } else {
                // Default to now if no end date provided
                endDate = LocalDateTime.now();
            }

            // Get all transactions for the date range
            List<Transaction> allTransactions = transferService.getTransactionHistory(null, startDate, endDate);
            
            // Filter and calculate interest summary
            List<Transaction> interestTransactions = allTransactions.stream()
                    .filter(transaction -> "INTEREST".equals(transaction.getTransactionType().name()))
                    .collect(Collectors.toList());

            // Calculate totals
            double totalInterestEarned = interestTransactions.stream()
                    .mapToDouble(transaction -> transaction.getAmount().doubleValue())
                    .sum();

            int totalInterestPayments = interestTransactions.size();

            // Get current month's interest
            LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
            LocalDateTime endOfMonth = LocalDateTime.now();
            
            double currentMonthInterest = interestTransactions.stream()
                    .filter(transaction -> {
                        LocalDateTime transactionDate = transaction.getTransactionDate();
                        return transactionDate.isAfter(startOfMonth) && transactionDate.isBefore(endOfMonth.plusDays(1));
                    })
                    .mapToDouble(transaction -> transaction.getAmount().doubleValue())
                    .sum();

            // Prepare summary response
            Map<String, Object> summary = new HashMap<>();
            summary.put("success", true);
            summary.put("totalInterestEarned", String.format("%.2f", totalInterestEarned));
            summary.put("totalPayments", totalInterestPayments);
            summary.put("currentMonthInterest", String.format("%.2f", currentMonthInterest));
            summary.put("periodStart", startDate.toLocalDate().toString());
            summary.put("periodEnd", endDate.toLocalDate().toString());

            // Add recent transactions (last 5)
            List<Transaction> recentInterestTransactions = interestTransactions.stream()
                    .sorted((t1, t2) -> t2.getTransactionDate().compareTo(t1.getTransactionDate()))
                    .limit(5)
                    .collect(Collectors.toList());
            
            summary.put("recentTransactions", recentInterestTransactions);

            logger.info("Interest summary calculated: Total earned $" + String.format("%.2f", totalInterestEarned) + 
                       ", Payments: " + totalInterestPayments + ", Current month: $" + String.format("%.2f", currentMonthInterest));

            String jsonResponse = gson.toJson(summary);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching interest summary", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to fetch interest summary\"}");
        }
    }
}
