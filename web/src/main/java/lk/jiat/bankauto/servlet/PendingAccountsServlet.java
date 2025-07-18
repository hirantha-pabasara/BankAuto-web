//package lk.jiat.bankauto.servlet;
//
//import jakarta.ejb.EJB;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import lk.jiat.bankauto.core.model.BankAccount;
//import lk.jiat.bankauto.core.model.User;
//import lk.jiat.bankauto.core.service.AccountService;
//import lk.jiat.bankauto.core.service.AdminAuthService;
//import lk.jiat.bankauto.core.service.UserService;
//
//import java.io.IOException;
//import java.util.List;
//import java.util.logging.Logger;
//
//@WebServlet("/admin/pendingAccounts")
//public class PendingAccountsServlet extends HttpServlet {
//    private static final Logger logger = Logger.getLogger(PendingAccountsServlet.class.getName());
//
//    @EJB
//    private AccountService accountService;
//
//    @EJB
//    private AdminAuthService adminAuthService;
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        System.out.println("PendingAccountsServlet: doGet called");
//
//        try {
//            // Get pending accounts with user details
//            List<Object[]> pendingAccountsWithUsers = accountService.getPendingAccountsWithUserDetails();
//
//            // Set attributes for JSP
//            request.setAttribute("pendingAccounts", pendingAccountsWithUsers);
//
//            // Forward to JSP
//            request.getRequestDispatcher("/WEB-INF/jsp/pendingAccounts.jsp")
//                    .forward(request, response);
//
//        } catch (Exception e) {
//            logger.severe("Error loading pending accounts: " + e.getMessage());
//            request.setAttribute("error", "Failed to load pending accounts");
//            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp")
//                    .forward(request, response);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//        String accountIdStr = request.getParameter("accountId");
//
//        if (action == null || accountIdStr == null) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
//            return;
//        }
//
//        try {
//            Long accountId = Long.parseLong(accountIdStr);
//
//            // Get admin user from session
//            HttpSession session = request.getSession();
//            User adminUser = (User) session.getAttribute("user");
//
//            if (adminUser == null) {
//                response.sendRedirect(request.getContextPath() + "/login");
//                return;
//            }
//
//            BankAccount result = null;
//            String message = "";
//
//            switch (action) {
//                case "approve":
//                    result = accountService.approveAccount(accountId, adminUser.getId());
//                    message = "Account approved successfully";
//                    break;
//                case "reject":
//                    result = accountService.rejectAccount(accountId, adminUser.getId());
//                    message = "Account rejected successfully";
//                    break;
//                default:
//                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
//                    return;
//            }
//
//            if (result != null) {
//                request.setAttribute("success", message);
//            } else {
//                request.setAttribute("error", "Operation failed");
//            }
//
//            // Redirect to avoid form resubmission
//            response.sendRedirect(request.getContextPath() + "/admin/pendingAccounts");
//
//        } catch (NumberFormatException e) {
//            logger.severe("Invalid account ID format: " + accountIdStr);
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid account ID");
//        } catch (Exception e) {
//            logger.severe("Error processing account action: " + e.getMessage());
//            request.setAttribute("error", "Operation failed: " + e.getMessage());
//            doGet(request, response);
//        }
//    }
//}

package lk.jiat.bankauto.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.AccountService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSerializer;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet("/api/pendingAccounts")
@MultipartConfig
public class PendingAccountsServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PendingAccountsServlet.class.getName());

    @EJB
    private AccountService accountService;

    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        // Configure Gson with LocalDateTime serializer
        this.gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context) ->
                        context.serialize(src.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))))
                .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            List<Object[]> pendingAccountsWithUsers = accountService.getPendingAccountsWithUserDetails();
            List<Map<String, Object>> accountList = new ArrayList<>();

            for (Object[] row : pendingAccountsWithUsers) {
                BankAccount account = (BankAccount) row[0];
                User user = (User) row[1];

                Map<String, Object> accountData = new HashMap<>();
                accountData.put("accountId", account.getId());
                accountData.put("accountNumber", account.getAccountNumber());
                accountData.put("accountType", account.getAccountType());
                accountData.put("accountName", account.getAccountName());
                accountData.put("balance", account.getBalance());
                accountData.put("currency", account.getCurrency());
                accountData.put("status", account.getStatus().toString());
                accountData.put("createdAt", account.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

                accountData.put("userId", user.getId());
                accountData.put("fullName", user.getFname() + " " + user.getLname());
                accountData.put("email", user.getEmail());
                accountData.put("phoneNumber", user.getPhoneNumber());

                accountList.add(accountData);
            }

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("data", accountList);

            PrintWriter out = response.getWriter();
            out.print(gson.toJson(result));
            out.flush();

        } catch (Exception e) {
            logger.severe("Error fetching pending accounts: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Failed to load pending accounts");

            PrintWriter out = response.getWriter();
            out.print(gson.toJson(error));
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String accountIdStr = request.getParameter("accountId");

        Map<String, Object> result = new HashMap<>();

        try {
            if (action == null || accountIdStr == null) {
                throw new IllegalArgumentException("Missing required parameters");
            }

            Long accountId = Long.parseLong(accountIdStr);

            // Get admin user from session
            HttpSession session = request.getSession();
            User adminUser = (User) session.getAttribute("admin");

            if (adminUser == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                result.put("success", false);
                result.put("message", "User not authenticated");

                PrintWriter out = response.getWriter();
                out.print(gson.toJson(result));
                return;
            }

            BankAccount processedAccount = null;
            String message = "";

            switch (action) {
                case "approve":
                    processedAccount = accountService.approveAccount(accountId, adminUser.getId());
                    message = "Account approved successfully";
                    break;
                case "reject":
                    processedAccount = accountService.rejectAccount(accountId, adminUser.getId());
                    message = "Account rejected successfully";
                    break;
                default:
                    throw new IllegalArgumentException("Invalid action: " + action);
            }

            if (processedAccount != null) {
                result.put("success", true);
                result.put("message", message);
                result.put("accountId", accountId);
                result.put("newStatus", processedAccount.getStatus().toString());
            } else {
                result.put("success", false);
                result.put("message", "Operation failed - account not found or invalid status");
            }

        } catch (NumberFormatException e) {
            logger.severe("Invalid account ID format: " + accountIdStr);
            result.put("success", false);
            result.put("message", "Invalid account ID format");
        } catch (Exception e) {
            logger.severe("Error processing account action: " + e.getMessage());
            result.put("success", false);
            result.put("message", "Operation failed: " + e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(gson.toJson(result));
        out.flush();
    }
}
