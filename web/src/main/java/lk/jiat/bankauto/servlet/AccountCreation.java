package lk.jiat.bankauto.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.jiat.bankauto.core.dto.AccountCreationRequest;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.service.AccountService;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.logging.Logger;

@WebServlet("/user/account-creation")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 5,        // 5MB
        maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class AccountCreation extends HttpServlet {

    private static final Logger logger = Logger.getLogger(AccountCreation.class.getName());

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get user session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                out.print("{\"success\": false, \"message\": \"Session expired. Please login again.\"}");
                return;
            }

            Long userId = (Long) session.getAttribute("userId");

            // Create request DTO
            AccountCreationRequest accountRequest = createRequestFromParameters(request, userId);

            // Validate request
            String validationError = validateRequest(accountRequest);
            if (validationError != null) {
                out.print("{\"success\": false, \"message\": \"" + validationError + "\"}");
                return;
            }

            // Create account using EJB
            BankAccount createdAccount = accountService.createAccount(accountRequest);

            if (createdAccount != null) {
                out.print("{\"success\": true, \"message\": \"Account application submitted successfully!\", \"accountNumber\": \"" + createdAccount.getAccountNumber() + "\"}");
                logger.info("Account created successfully for user: " + userId);
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to submit application. Please try again.\"}");
            }

        } catch (Exception e) {
            logger.severe("Error in account creation: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"An error occurred. Please try again.\"}");
        } finally {
            out.close();
        }
    }

    private AccountCreationRequest createRequestFromParameters(HttpServletRequest request, Long userId)
            throws IOException, ServletException {

        AccountCreationRequest accountRequest = new AccountCreationRequest();
        accountRequest.setUserId(userId);
        accountRequest.setAccountType(request.getParameter("accountType"));
        accountRequest.setAccountName(request.getParameter("accountName"));
        accountRequest.setCurrency(request.getParameter("currency"));
        accountRequest.setPurpose(request.getParameter("purpose"));
        accountRequest.setPaperlessStatements("true".equals(request.getParameter("paperlessStatements")));
        accountRequest.setMobileAlerts("true".equals(request.getParameter("mobileAlerts")));
        accountRequest.setAgreeTerms("true".equals(request.getParameter("agreeTerms")));

        // Parse initial deposit
        String initialDepositStr = request.getParameter("initialDeposit");
        if (initialDepositStr != null && !initialDepositStr.trim().isEmpty()) {
            try {
                accountRequest.setInitialDeposit(new BigDecimal(initialDepositStr));
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid initial deposit amount");
            }
        }

        // Handle file uploads
        StringBuilder documentPaths = new StringBuilder();
        Collection<Part> fileParts = request.getParts();
        for (Part filePart : fileParts) {
            if ("documentUpload".equals(filePart.getName()) && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    if (documentPaths.length() > 0) {
                        documentPaths.append(",");
                    }
                    documentPaths.append(fileName);
                }
            }
        }
        accountRequest.setDocuments(documentPaths.toString());

        return accountRequest;
    }

    private String validateRequest(AccountCreationRequest request) {
        if (request.getAccountType() == null || request.getAccountType().trim().isEmpty()) {
            return "Account type is required";
        }
        if (request.getAccountName() == null || request.getAccountName().trim().isEmpty()) {
            return "Account name is required";
        }
        if (request.getInitialDeposit() == null || request.getInitialDeposit().compareTo(BigDecimal.ZERO) < 0) {
            return "Valid initial deposit is required";
        }
        if (request.getAgreeTerms() == null || !request.getAgreeTerms()) {
            return "You must agree to the terms and conditions";
        }

        if (accountService.hasAccountType(request.getUserId(), request.getAccountType())) {
            return "You already have a " + request.getAccountType() + ". Only one account per type is allowed.";
        }

        // Validate minimum deposit based on account type
        BigDecimal minDeposit = getMinimumDeposit(request.getAccountType());
        if (request.getInitialDeposit().compareTo(minDeposit) < 0) {
            return "Minimum deposit for " + request.getAccountType() + " is $" + minDeposit;
        }

        return null;
    }

    private BigDecimal getMinimumDeposit(String accountType) {
        switch (accountType.toLowerCase()) {
            case "savings account":
                return new BigDecimal("100");
            case "checking account":
                return new BigDecimal("0");
            case "current account":
                return new BigDecimal("200");
            case "fixed deposit":
                return new BigDecimal("1000");
            default:
                return new BigDecimal("0");
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String token : contentDisposition.split(";")) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return null;
    }

}
