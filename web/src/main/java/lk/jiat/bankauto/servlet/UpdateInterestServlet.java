package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.service.InterestService;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet("/admin/update-interest")
public class UpdateInterestServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(UpdateInterestServlet.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private InterestService interestService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Get current interest rates for all account types
            Map<String, String> rates = new HashMap<>();
            rates.put("savings", interestService.getInterestRate("Savings Account").toString());
            rates.put("checking", interestService.getInterestRate("Checking Account").toString());
            rates.put("current", interestService.getInterestRate("Current Account").toString());
            rates.put("fixed", interestService.getInterestRate("Fixed Deposit").toString());
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(rates));
            
        } catch (Exception e) {
            logger.severe("Error fetching interest rates: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Failed to fetch interest rates");
            
            response.getWriter().write(gson.toJson(errorResponse));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            String action = request.getParameter("action");
            logger.info("=== DEBUG: doPost called with action: " + action + " ===");
            
            if ("update".equals(action)) {
                // Update interest rates
                updateInterestRates(request, jsonResponse);
                
            } else if ("apply".equals(action)) {
                // Apply interest to all accounts
                int accountsProcessed = interestService.applyInterestToAllAccounts();
                
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Interest applied to " + accountsProcessed + " accounts");
                jsonResponse.addProperty("accountsProcessed", accountsProcessed);
                
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid action: " + action);
                logger.warning("Invalid action received: " + action);
            }
            
            out.write(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            logger.severe("Error processing interest update: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Server error occurred: " + e.getMessage());
            out.write(gson.toJson(jsonResponse));
            
        } finally {
            out.close();
        }
    }
    
    private void updateInterestRates(HttpServletRequest request, JsonObject jsonResponse) {
        try {
            // Debug: Log all received parameters
            logger.info("=== DEBUG: Received parameters ===");
            logger.info("Action: " + request.getParameter("action"));
            logger.info("Savings: " + request.getParameter("savings"));
            logger.info("Checking: " + request.getParameter("checking"));
            logger.info("Current: " + request.getParameter("current"));
            logger.info("Fixed: " + request.getParameter("fixed"));
            logger.info("====================================");
            
            StringBuilder message = new StringBuilder("Updated rates: ");
            boolean hasUpdates = false;
            
            // Update Savings Account rate
            String savingsRate = request.getParameter("savings");
            if (savingsRate != null && !savingsRate.trim().isEmpty()) {
                BigDecimal rate = new BigDecimal(savingsRate);
                interestService.setInterestRate("Savings Account", rate);
                message.append("Savings(").append(savingsRate).append("%) ");
                hasUpdates = true;
            }
            
            // Update Checking Account rate
            String checkingRate = request.getParameter("checking");
            if (checkingRate != null && !checkingRate.trim().isEmpty()) {
                BigDecimal rate = new BigDecimal(checkingRate);
                interestService.setInterestRate("Checking Account", rate);
                message.append("Checking(").append(checkingRate).append("%) ");
                hasUpdates = true;
            }
            
            // Update Current Account rate
            String currentRate = request.getParameter("current");
            if (currentRate != null && !currentRate.trim().isEmpty()) {
                BigDecimal rate = new BigDecimal(currentRate);
                interestService.setInterestRate("Current Account", rate);
                message.append("Current(").append(currentRate).append("%) ");
                hasUpdates = true;
            }
            
            // Update Fixed Deposit rate
            String fixedRate = request.getParameter("fixed");
            if (fixedRate != null && !fixedRate.trim().isEmpty()) {
                BigDecimal rate = new BigDecimal(fixedRate);
                interestService.setInterestRate("Fixed Deposit", rate);
                message.append("Fixed(").append(fixedRate).append("%) ");
                hasUpdates = true;
            }
            
            if (hasUpdates) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", message.toString());
                logger.info("Interest rates updated: " + message.toString());
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "No rates provided to update");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid number format in interest rate: " + e.getMessage());
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid interest rate format. Please enter valid numbers.");
            
        } catch (Exception e) {
            logger.severe("Error updating interest rates: " + e.getMessage());
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Failed to update interest rates: " + e.getMessage());
        }
    }
}
