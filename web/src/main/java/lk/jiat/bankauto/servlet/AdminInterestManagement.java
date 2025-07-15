//package lk.jiat.bankauto.servlet;
//
//import com.google.gson.Gson;
//import com.google.gson.JsonObject;
//import jakarta.ejb.EJB;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import lk.jiat.bankauto.core.service.InterestService;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.math.BigDecimal;
//import java.util.HashMap;
//import java.util.Map;
//import java.util.logging.Logger;
//
//@WebServlet("/admin/interest-management")
//public class AdminInterestManagement extends HttpServlet {
//
//    private static final Logger logger = Logger.getLogger(AdminInterestManagement.class.getName());
//    private final Gson gson = new Gson();
//
//    @EJB
//    private InterestService interestService;
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//
//        try {
//            // Get current interest rates for all account types
//            Map<String, BigDecimal> rates = new HashMap<>();
//            rates.put("Savings Account", interestService.getInterestRate("Savings Account"));
//            rates.put("Checking Account", interestService.getInterestRate("Checking Account"));
//            rates.put("Current Account", interestService.getInterestRate("Current Account"));
//            rates.put("Fixed Deposit", interestService.getInterestRate("Fixed Deposit"));
//
//            response.setStatus(HttpServletResponse.SC_OK);
//            response.getWriter().write(gson.toJson(rates));
//
//        } catch (Exception e) {
//            logger.severe("Error fetching interest rates: " + e.getMessage());
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//
//            JsonObject errorResponse = new JsonObject();
//            errorResponse.addProperty("success", false);
//            errorResponse.addProperty("message", "Failed to fetch interest rates");
//
//            response.getWriter().write(gson.toJson(errorResponse));
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//
//        PrintWriter out = response.getWriter();
//        JsonObject jsonResponse = new JsonObject();
//
//        try {
//            String action = request.getParameter("action");
//
//            if ("updateRates".equals(action)) {
//                // Update interest rates
//                String savingsRate = request.getParameter("savingsRate");
//                String checkingRate = request.getParameter("checkingRate");
//                String currentRate = request.getParameter("currentRate");
//                String fixedRate = request.getParameter("fixedRate");
//
//                boolean success = true;
//                StringBuilder message = new StringBuilder("Interest rates updated: ");
//
//                if (savingsRate != null && !savingsRate.isEmpty()) {
//                    try {
//                        interestService.setInterestRate("Savings Account", new BigDecimal(savingsRate));
//                        message.append("Savings(").append(savingsRate).append("%) ");
//                    } catch (Exception e) {
//                        success = false;
//                        logger.warning("Failed to set savings rate: " + e.getMessage());
//                    }
//                }
//
//                if (checkingRate != null && !checkingRate.isEmpty()) {
//                    try {
//                        interestService.setInterestRate("Checking Account", new BigDecimal(checkingRate));
//                        message.append("Checking(").append(checkingRate).append("%) ");
//                    } catch (Exception e) {
//                        success = false;
//                        logger.warning("Failed to set checking rate: " + e.getMessage());
//                    }
//                }
//
//                if (currentRate != null && !currentRate.isEmpty()) {
//                    try {
//                        interestService.setInterestRate("Current Account", new BigDecimal(currentRate));
//                        message.append("Current(").append(currentRate).append("%) ");
//                    } catch (Exception e) {
//                        success = false;
//                        logger.warning("Failed to set current rate: " + e.getMessage());
//                    }
//                }
//
//                if (fixedRate != null && !fixedRate.isEmpty()) {
//                    try {
//                        interestService.setInterestRate("Fixed Deposit", new BigDecimal(fixedRate));
//                        message.append("Fixed(").append(fixedRate).append("%) ");
//                    } catch (Exception e) {
//                        success = false;
//                        logger.warning("Failed to set fixed rate: " + e.getMessage());
//                    }
//                }
//
//                jsonResponse.addProperty("success", success);
//                jsonResponse.addProperty("message", message.toString());
//
//            } else if ("applyInterest".equals(action)) {
//                // Apply interest to all accounts
//                int accountsProcessed = interestService.applyInterestToAllAccounts();
//
//                jsonResponse.addProperty("success", true);
//                jsonResponse.addProperty("message", "Interest applied to " + accountsProcessed + " accounts");
//                jsonResponse.addProperty("accountsProcessed", accountsProcessed);
//
//            } else {
//                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//                jsonResponse.addProperty("success", false);
//                jsonResponse.addProperty("message", "Invalid action");
//            }
//
//            out.write(gson.toJson(jsonResponse));
//
//        } catch (NumberFormatException e) {
//            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//            jsonResponse.addProperty("success", false);
//            jsonResponse.addProperty("message", "Invalid interest rate format");
//            out.write(gson.toJson(jsonResponse));
//
//        } catch (Exception e) {
//            logger.severe("Error processing interest management: " + e.getMessage());
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            jsonResponse.addProperty("success", false);
//            jsonResponse.addProperty("message", "Server error occurred");
//            out.write(gson.toJson(jsonResponse));
//
//        } finally {
//            out.close();
//        }
//    }
//}
