package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

@WebServlet("/admin/login")
public class AdminLogin extends HttpServlet {

    private static final Logger logger = Logger.getLogger(AdminLogin.class.getName());
    private final Gson gson = new Gson();

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || password == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Email and password are required");
                out.write(gson.toJson(jsonResponse));
                return;
            }

            AuthenticationParameters parameters = AuthenticationParameters.withParams()
                    .credential(new UsernamePasswordCredential(email, password));
            AuthenticationStatus status = securityContext.authenticate(request, response, parameters);

            logger.info("Admin Authentication Status: " + status);

            if (status == AuthenticationStatus.SUCCESS) {
                response.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Login successful!");
                jsonResponse.addProperty("redirectUrl", "dashboard.jsp");
                logger.info("Admin login successful: " + email);
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid credentials or account not verified!");
            }

            out.write(gson.toJson(jsonResponse));

        } catch (Exception e) {
            logger.severe("Error in admin login: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Server error occurred. Please try again.");
            out.write(gson.toJson(jsonResponse));
        } finally {
            out.close();
        }

    }
}
