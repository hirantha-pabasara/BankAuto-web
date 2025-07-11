package lk.jiat.bankauto.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet("/user/account-creation")
public class AccountCreation extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Print all form fields
        System.out.println("accountType: " + request.getParameter("accountType"));
        System.out.println("accountName: " + request.getParameter("accountName"));
        System.out.println("initialDeposit: " + request.getParameter("initialDeposit"));
        System.out.println("currency: " + request.getParameter("currency"));
        System.out.println("purpose: " + request.getParameter("purpose"));
        System.out.println("paperlessStatements: " + request.getParameter("paperlessStatements"));
        System.out.println("mobileAlerts: " + request.getParameter("mobileAlerts"));
        System.out.println("agreeTerms: " + request.getParameter("agreeTerms"));

        // Print uploaded file names
        for (Part part : request.getParts()) {
            if ("documentUpload".equals(part.getName()) && part.getSize() > 0) {
                System.out.println("Uploaded file: " + part.getSubmittedFileName());
            }
        }

        // Respond with simple JSON for testing
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":true,\"message\":\"Data received\"}");
    }
}
