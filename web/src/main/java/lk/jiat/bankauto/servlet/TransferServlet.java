package lk.jiat.bankauto.servlet;

import com.google.gson.*;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bankauto.core.dto.TransferRequest;
import lk.jiat.bankauto.core.dto.TransferResult;
import lk.jiat.bankauto.core.model.Transaction;
import lk.jiat.bankauto.core.service.TransferService;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "TransferServlet", urlPatterns = {
        "/api/transfers/process",
        "/api/transfers/history",
        "/api/transfers/pending",
        "/api/transfers/cancel"
})
public class TransferServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(TransferServlet.class.getName());
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
        private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

        @Override
        public JsonElement serialize(LocalDateTime localDateTime, Type type, JsonSerializationContext context) {
            return new JsonPrimitive(formatter.format(localDateTime));
        }
    }

    // Custom LocalDateTime deserializer for Gson
    private static class LocalDateTimeDeserializer implements JsonDeserializer<LocalDateTime> {
        private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

        @Override
        public LocalDateTime deserialize(JsonElement json, Type type, JsonDeserializationContext context)
                throws JsonParseException {
            return LocalDateTime.parse(json.getAsString(), formatter);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = request.getServletPath();
        }

        try {
            // Check user authentication
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"success\":false,\"message\":\"User not authenticated\"}");
                return;
            }

            Long userId = (Long) session.getAttribute("userId");

            switch (pathInfo) {
                case "/api/transfers/process":
                    processTransfer(request, response, userId);
                    break;
                case "/api/transfers/cancel":
                    cancelTransfer(request, response, userId);
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"success\":false,\"message\":\"Endpoint not found\"}");
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in TransferServlet POST", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Internal server error\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = request.getServletPath();
        }

        try {
            // Check user authentication
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"success\":false,\"message\":\"User not authenticated\"}");
                return;
            }

            Long userId = (Long) session.getAttribute("userId");

            switch (pathInfo) {
                case "/api/transfers/history":
                    getTransferHistory(request, response, userId);
                    break;
                case "/api/transfers/pending":
                    getPendingTransfers(request, response, userId);
                    break;
                case "/api/transactions/stats":
                    getTransactionStats(request, response, userId);
                    break;
                case "/api/transfers/details":
                    getTransferDetails(request, response, userId);
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"success\":false,\"message\":\"Endpoint not found\"}");
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in TransferServlet GET", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Internal server error\"}");
        }
    }

    private void processTransfer(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {

        logger.info("=================================================================");
        logger.info("TRANSFER PROCESSING STARTED - User ID: " + userId);
        logger.info("=================================================================");
        
        long startTime = System.currentTimeMillis();

        try {
            // Log request details
            logger.info("Request details - Remote Address: " + request.getRemoteAddr());
            logger.info("Request details - User Agent: " + request.getHeader("User-Agent"));
            logger.info("Request details - Session ID: " + request.getSession().getId());
            
            // Read JSON from request body
            logger.info("Reading JSON from request body...");
            String jsonString = readRequestBody(request);
            logger.info("Raw JSON received: " + jsonString);

            // Parse request JSON using Gson
            logger.info("Parsing JSON to TransferRequest object...");
            TransferRequest transferRequest = gson.fromJson(jsonString, TransferRequest.class);
            transferRequest.setUserId(userId);
            
            // Log parsed transfer request details
            logger.info("Parsed transfer request:");
            logger.info("  - User ID: " + transferRequest.getUserId());
            logger.info("  - From Account ID: " + transferRequest.getFromAccountId());
            logger.info("  - To Account: " + transferRequest.getToAccount());
            logger.info("  - Amount: " + transferRequest.getAmount());
            logger.info("  - Transfer Type: " + transferRequest.getTransferType());
            logger.info("  - Description: " + transferRequest.getDescription());
            if (transferRequest.getScheduledDateTime() != null) {
                logger.info("  - Scheduled Date/Time: " + transferRequest.getScheduledDateTime());
            }
            if (transferRequest.getFrequency() != null) {
                logger.info("  - Frequency: " + transferRequest.getFrequency());
            }

            // Validate input
            logger.info("Validating transfer request...");
            if (!isValidTransferRequest(transferRequest)) {
                logger.warning("Transfer request validation failed");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"Invalid transfer request data\"}");
                return;
            }
            logger.info("Transfer request validation passed");

            // Process transfer based on type
            String transferType = transferRequest.getTransferType().toUpperCase();
            logger.info("Processing transfer of type: " + transferType);
            
            TransferResult result;
            long serviceStartTime = System.currentTimeMillis();

            switch (transferType) {
                case "IMMEDIATE":
                    logger.info("Calling TransferService.processImmediateTransfer()...");
                    result = transferService.processImmediateTransfer(transferRequest);
                    break;
                case "SCHEDULED":
                    logger.info("Calling TransferService.scheduleTransfer()...");
                    result = transferService.scheduleTransfer(transferRequest);
                    break;
                case "RECURRING":
                    logger.info("Calling TransferService.setupRecurringTransfer()...");
                    result = transferService.setupRecurringTransfer(transferRequest);
                    break;
                default:
                    logger.warning("Invalid transfer type received: " + transferType);
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"success\":false,\"message\":\"Invalid transfer type\"}");
                    return;
            }
            
            long serviceTime = System.currentTimeMillis() - serviceStartTime;
            logger.info("Transfer service call completed in " + serviceTime + "ms");
            
            // Log transfer result
            logger.info("Transfer result received:");
            logger.info("  - Success: " + result.isSuccess());
            logger.info("  - Message: " + result.getMessage());
            logger.info("  - Reference Number: " + result.getReferenceNumber());
            logger.info("  - Error Code: " + result.getErrorCode());

            // Return result using Gson
            logger.info("Converting result to JSON response...");
            String jsonResponse = gson.toJson(result);
            logger.info("JSON response: " + jsonResponse);
            response.getWriter().write(jsonResponse);

            long totalTime = System.currentTimeMillis() - startTime;
            logger.info("Total transfer processing time: " + totalTime + "ms");

            if (result.isSuccess()) {
                logger.info("Transfer processed successfully: " + result.getReferenceNumber());
                logger.info("SUCCESS: Transfer completed for User ID: " + userId);
            } else {
                logger.warning("Transfer failed: " + result.getMessage());
                logger.warning("FAILURE: Transfer failed for User ID: " + userId + " - " + result.getErrorCode());
            }

        } catch (Exception e) {
            long totalTime = System.currentTimeMillis() - startTime;
            logger.log(Level.SEVERE, "CRITICAL ERROR processing transfer after " + totalTime + "ms", e);
            logger.severe("Error details:");
            logger.severe("  - User ID: " + userId);
            logger.severe("  - Error Type: " + e.getClass().getSimpleName());
            logger.severe("  - Error Message: " + e.getMessage());
            logger.severe("  - Stack Trace: " + java.util.Arrays.toString(e.getStackTrace()));
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to process transfer\"}");
        } finally {
            logger.info("=================================================================");
            logger.info("TRANSFER PROCESSING ENDED - User ID: " + userId);
            logger.info("=================================================================");
        }
    }

    private void getTransferHistory(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {

        try {
            String accountIdParam = request.getParameter("accountId");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");

            // Allow fetching all transactions if no accountId specified
            Long accountId = null;
            if (accountIdParam != null && !accountIdParam.isEmpty() && !accountIdParam.equals("all")) {
                accountId = Long.parseLong(accountIdParam);
            }

            LocalDateTime startDate = null;
            LocalDateTime endDate = null;

            if (startDateParam != null && !startDateParam.isEmpty()) {
                startDate = LocalDateTime.parse(startDateParam + "T00:00:00");
            }

            if (endDateParam != null && !endDateParam.isEmpty()) {
                endDate = LocalDateTime.parse(endDateParam + "T23:59:59");
            }

            List<Transaction> transactions = transferService.getTransactionHistory(accountId, startDate, endDate);

            // Convert to JSON using Gson
            String jsonResponse = gson.toJson(transactions);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching transfer history", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to fetch transfer history\"}");
        }
    }

    private void getPendingTransfers(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {

        try {
            List<Transaction> pendingTransfers = transferService.getPendingTransfers(userId);

            // Convert to JSON using Gson
            String jsonResponse = gson.toJson(pendingTransfers);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching pending transfers", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to fetch pending transfers\"}");
        }
    }

    private void getTransactionStats(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {

        try {
            // Get today's date range
            LocalDateTime startOfDay = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0);
            LocalDateTime endOfDay = LocalDateTime.now().withHour(23).withMinute(59).withSecond(59).withNano(999999999);

            // Get stats from service
            Map<String, Object> stats = new HashMap<>();

            // Today's transfers count - get all transactions for today
            List<Transaction> todayTransactions = transferService.getTransactionHistory(null, startOfDay, endOfDay);
            stats.put("todayCount", todayTransactions.size());

            // Get pending transfers
            List<Transaction> pendingTransfers = transferService.getPendingTransfers(userId);

            // Count by status and type
            long scheduledCount = pendingTransfers.stream()
                    .filter(t -> "SCHEDULED".equals(t.getStatus().toString()))
                    .count();

            long recurringCount = pendingTransfers.stream()
                    .filter(t -> "RECURRING".equals(t.getTransferType().toString()))
                    .count();

            long completedCount = todayTransactions.stream()
                    .filter(t -> "COMPLETED".equals(t.getStatus().toString()))
                    .count();

            stats.put("scheduledCount", scheduledCount);
            stats.put("recurringCount", recurringCount);
            stats.put("completedCount", completedCount);
            stats.put("success", true);

            // Convert to JSON using Gson
            String jsonResponse = gson.toJson(stats);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching transaction stats", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to fetch statistics\"}");
        }
    }

    private void getTransferDetails(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {

        try {
            String transactionIdParam = request.getParameter("transactionId");

            if (transactionIdParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"Transaction ID is required\"}");
                return;
            }

            Long transactionId = Long.parseLong(transactionIdParam);
            Transaction transaction = transferService.getTransactionById(transactionId);

            if (transaction != null) {
                // Convert to JSON using Gson
                String jsonResponse = gson.toJson(transaction);
                response.getWriter().write(jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"success\":false,\"message\":\"Transaction not found\"}");
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching transfer details", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to fetch transfer details\"}");
        }
    }

    private void cancelTransfer(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws IOException {

        try {
            String transactionIdParam = request.getParameter("transactionId");

            if (transactionIdParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"Transaction ID is required\"}");
                return;
            }

            Long transactionId = Long.parseLong(transactionIdParam);
            boolean cancelled = transferService.cancelTransfer(transactionId, userId);

            Map<String, Object> result = new HashMap<>();
            result.put("success", cancelled);
            result.put("message", cancelled ? "Transfer cancelled successfully" : "Failed to cancel transfer");

            // Convert to JSON using Gson
            String jsonResponse = gson.toJson(result);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error cancelling transfer", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Failed to cancel transfer\"}");
        }
    }

    /**
     * Helper method to read request body as string
     */
    private String readRequestBody(HttpServletRequest request) throws IOException {
        logger.info("Reading request body...");
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;

        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }

        String requestBody = buffer.toString();
        logger.info("Request body length: " + requestBody.length() + " characters");
        return requestBody;
    }

    private boolean isValidTransferRequest(TransferRequest request) {
        logger.info("Validating transfer request structure...");
        
        boolean isValid = request.getFromAccountId() != null &&
                request.getToAccount() != null && !request.getToAccount().trim().isEmpty() &&
                request.getAmount() != null && request.getAmount().compareTo(BigDecimal.ZERO) > 0 &&
                request.getTransferType() != null && !request.getTransferType().trim().isEmpty();
        
        logger.info("Transfer request validation result: " + isValid);
        
        if (!isValid) {
            logger.warning("Invalid request details:");
            logger.warning("  - Request object: " + (request != null ? "present" : "null"));
            if (request != null) {
                logger.warning("  - From Account ID: " + (request.getFromAccountId() != null ? "present" : "null"));
                logger.warning("  - To Account: " + (request.getToAccount() != null && !request.getToAccount().trim().isEmpty() ? "present" : "null/empty"));
                logger.warning("  - Amount: " + (request.getAmount() != null && request.getAmount().compareTo(BigDecimal.ZERO) > 0 ? "present" : "null/invalid"));
                logger.warning("  - Transfer Type: " + (request.getTransferType() != null && !request.getTransferType().trim().isEmpty() ? "present" : "null/empty"));
            }
        }
        
        return isValid;
    }
}
