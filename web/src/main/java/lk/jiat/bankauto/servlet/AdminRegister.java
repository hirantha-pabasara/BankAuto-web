package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.enums.UserRole;
import lk.jiat.bankauto.core.mail.VerificationMail;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.provider.MailServiceProvider;
import lk.jiat.bankauto.core.service.AdminAuthService;
import lk.jiat.bankauto.core.util.PasswordUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.UUID;
import java.util.logging.Logger;

@WebServlet("/admin/register")
public class AdminRegister extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminRegister.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private AdminAuthService adminAuthService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try{
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String dob = request.getParameter("dob");
            String nic = request.getParameter("nic");

            // Log received parameters for debugging
            logger.info("Registration request received for email: " + email);
            logger.info("Parameters - fname: " + fname + ", lname: " + lname + ", userName: " + userName);
            logger.info("Parameters - phoneNumber: " + phoneNumber + ", address: " + address);
            logger.info("Content-Type: " + request.getContentType());

            // Validate required fields
            if (fname == null || fname.trim().isEmpty() ||
                lname == null || lname.trim().isEmpty() ||
                userName == null || userName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                phoneNumber == null || phoneNumber.trim().isEmpty()) {
                
                logger.warning("Validation failed - missing required fields");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "All required fields must be filled");
                out.write(gson.toJson(jsonResponse));
                return;
            }

            // Check if user already exists
            if (adminAuthService == null) {
                logger.severe("AdminAuthService EJB is null - injection failed");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Service temporarily unavailable. Please try again.");
                out.write(gson.toJson(jsonResponse));
                return;
            }

            User existingUser = adminAuthService.getUserByEmail(email);
            if (existingUser != null) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Email already exists!");
                out.write(gson.toJson(jsonResponse));
                return;
            }

            // Create new admin user
            User admin = new User();
            admin.setFname(fname);
            admin.setLname(lname);
            admin.setUserName(userName);
            admin.setEmail(email);
            admin.setPassword(PasswordUtil.hashPassword(password));
            admin.setPhoneNumber(phoneNumber);
            admin.setAddress(address);
            admin.setDOB(dob);
            admin.setNIC(nic);
            admin.setRole(UserRole.ADMIN);
            admin.setVerified(false);

            // Generate verification code
            String verificationCode = UUID.randomUUID().toString();
            admin.setVerificationCode(verificationCode);
            admin.setVerificationExpiry(LocalDateTime.now().plusHours(24));

            adminAuthService.addUser(admin);

            // Send verification email
            VerificationMail mail = new VerificationMail(email, verificationCode);
            MailServiceProvider.getInstance().sendMail(mail);

            // Success response
            response.setStatus(HttpServletResponse.SC_OK);
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Admin registered successfully! Please check your email for verification code.");
            jsonResponse.addProperty("email", email);

            out.write(gson.toJson(jsonResponse));
            logger.info("Admin registered successfully: " + email);

        } catch (Exception e) {
            logger.severe("Error in admin registration: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Server error occurred. Please try again.");
            out.write(gson.toJson(jsonResponse));
        }finally {
            out.close();
        }

    }
}
