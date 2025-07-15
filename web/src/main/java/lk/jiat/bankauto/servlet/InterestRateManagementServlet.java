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
import lk.jiat.bankauto.core.service.InterestService;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.logging.Logger;

@WebServlet("/admin/interest-rates")
public class InterestRateManagementServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(InterestRateManagementServlet.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private InterestService interestService;

    private static final String[] ACCOUNT_TYPES = {
        "Savings Account",
        "Checking Account", 
        "Current Account",
        "Fixed Deposit"
    };

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            JsonArray ratesArray = new JsonArray();
            
            for (String accountType : ACCOUNT_TYPES) {
                JsonObject rateObj = new JsonObject();
                rateObj.addProperty("accountType", accountType);
                rateObj.addProperty("displayName", getDisplayName(accountType));
                
                BigDecimal currentRate = interestService.getInterestRate(accountType);
                rateObj.addProperty("currentRate", currentRate.toString());
                
                ratesArray.add(rateObj);
            }
            
            JsonObject responseObj = new JsonObject();
            responseObj.addProperty("success", true);
            responseObj.add("rates", ratesArray);
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(responseObj));
            
        } catch (Exception e) {
            logger.severe("Error fetching interest rates: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Failed to fetch interest rates: " + e.getMessage());
            
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
            
            if ("updateRate".equals(action)) {
                updateSingleRate(request, jsonResponse);
            } else if ("updateAllRates".equals(action)) {
                updateAllRates(request, jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid action: " + action);
            }
            
            out.write(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            logger.severe("Error processing interest rate update: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Server error occurred: " + e.getMessage());
            out.write(gson.toJson(jsonResponse));
        }
    }

    private void updateSingleRate(HttpServletRequest request, JsonObject jsonResponse) {
        try {
            String accountType = request.getParameter("accountType");
            String newRateStr = request.getParameter("newRate");
            
            if (accountType == null || newRateStr == null || newRateStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Account type and new rate are required");
                return;
            }
            
            BigDecimal newRate = new BigDecimal(newRateStr);
            
            if (newRate.compareTo(BigDecimal.ZERO) < 0 || newRate.compareTo(new BigDecimal("15")) > 0) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Interest rate must be between 0% and 15%");
                return;
            }
            
            interestService.setInterestRate(accountType, newRate);
            
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Interest rate updated successfully for " + getDisplayName(accountType));
            jsonResponse.addProperty("accountType", accountType);
            jsonResponse.addProperty("newRate", newRate.toString());
            
            logger.info("Updated interest rate for " + accountType + " to " + newRate + "%");
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid number format for interest rate");
        } catch (Exception e) {
            logger.severe("Error updating single interest rate: " + e.getMessage());
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Failed to update interest rate: " + e.getMessage());
        }
    }

    private void updateAllRates(HttpServletRequest request, JsonObject jsonResponse) {
        try {
            int updatedCount = 0;
            StringBuilder successMessage = new StringBuilder("Updated rates: ");
            
            for (String accountType : ACCOUNT_TYPES) {
                String paramName = getParamName(accountType);
                String newRateStr = request.getParameter(paramName);
                
                if (newRateStr != null && !newRateStr.trim().isEmpty()) {
                    BigDecimal newRate = new BigDecimal(newRateStr);
                    
                    if (newRate.compareTo(BigDecimal.ZERO) >= 0 && newRate.compareTo(new BigDecimal("15")) <= 0) {
                        interestService.setInterestRate(accountType, newRate);
                        updatedCount++;
                        
                        if (updatedCount > 1) successMessage.append(", ");
                        successMessage.append(getDisplayName(accountType)).append(" (").append(newRate).append("%)");
                    }
                }
            }
            
            if (updatedCount > 0) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", successMessage.toString());
                jsonResponse.addProperty("updatedCount", updatedCount);
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "No valid interest rates provided to update");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid number format for one or more interest rates");
        } catch (Exception e) {
            logger.severe("Error updating multiple interest rates: " + e.getMessage());
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Failed to update interest rates: " + e.getMessage());
        }
    }

    private String getDisplayName(String accountType) {
        switch (accountType) {
            case "Savings Account": return "Savings";
            case "Checking Account": return "Checking";
            case "Current Account": return "Current";
            case "Fixed Deposit": return "Fixed Deposit";
            default: return accountType;
        }
    }

    private String getParamName(String accountType) {
        switch (accountType) {
            case "Savings Account": return "savings";
            case "Checking Account": return "checking";
            case "Current Account": return "current";
            case "Fixed Deposit": return "fixed";
            default: return accountType.toLowerCase().replace(" ", "");
        }
    }
}
