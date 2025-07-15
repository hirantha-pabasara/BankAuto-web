package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.service.AdminAuthService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

@WebServlet("/admin/verify")
public class VerifyEmail extends HttpServlet {

    private static final Logger logger = Logger.getLogger(VerifyEmail.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private AdminAuthService adminAuthService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            String email = request.getParameter("email");
            String verificationCode = request.getParameter("verificationCode");

            if (email == null || verificationCode == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Email and verification code are required");
                out.write(gson.toJson(jsonResponse));
                return;
            }
            boolean isVerified = adminAuthService.verifyUser(email, verificationCode);

            if (isVerified) {
                response.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Email verified successfully! You can now login.");
                logger.info("Email verified successfully: " + email);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid or expired verification code!");
            }

            out.write(gson.toJson(jsonResponse));

        } catch (Exception e) {
            logger.severe("Error in email verification: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Server error occurred. Please try again.");
            out.write(gson.toJson(jsonResponse));
        } finally {
            out.close();
        }
    }
}
