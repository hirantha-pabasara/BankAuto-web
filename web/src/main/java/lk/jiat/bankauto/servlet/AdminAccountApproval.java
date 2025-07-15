package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.service.AccountService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/admin/account-approval")
public class AdminAccountApproval extends HttpServlet {

    private static final Logger logger = Logger.getLogger(AdminAccountApproval.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            List<BankAccount> pendingAccounts = accountService.getPendingAccounts();
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(pendingAccounts));
            
        } catch (Exception e) {
            logger.severe("Error fetching pending accounts: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Failed to fetch pending accounts");
            
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
            String accountIdStr = request.getParameter("accountId");
            
            if (action == null || accountIdStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Action and account ID are required");
                out.write(gson.toJson(jsonResponse));
                return;
            }
            
            Long accountId = Long.parseLong(accountIdStr);
            Long adminUserId = 1L; // Get from session in real implementation
            
            BankAccount account = null;
            
            if ("approve".equals(action)) {
                account = accountService.approveAccount(accountId, adminUserId);
                if (account != null) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Account approved successfully");
                    logger.info("Account approved: " + account.getAccountNumber());
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Failed to approve account");
                }
                
            } else if ("reject".equals(action)) {
                account = accountService.rejectAccount(accountId, adminUserId);
                if (account != null) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Account rejected successfully");
                    logger.info("Account rejected: " + account.getAccountNumber());
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Failed to reject account");
                }
                
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid action");
            }
            
            out.write(gson.toJson(jsonResponse));
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid account ID");
            out.write(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            logger.severe("Error processing account approval: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Server error occurred");
            out.write(gson.toJson(jsonResponse));
            
        } finally {
            out.close();
        }
    }
}
