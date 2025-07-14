package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bankauto.core.dto.ResponseMessage;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/user/login")
public class UserLogin extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Read JSON request
            BufferedReader reader = request.getReader();
            StringBuilder jsonString = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonString.append(line);
            }

            Gson gson = new GsonBuilder().create();
            LoginRequest loginRequest = gson.fromJson(jsonString.toString(), LoginRequest.class);

            if (loginRequest.getLogin() == null || loginRequest.getPassword() == null) {
                ResponseMessage message = new ResponseMessage(false, "Username and password are required");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(message));
                out.flush();
                return;
            }

            // Use Jakarta Security for authentication
            AuthenticationParameters parameters = AuthenticationParameters.withParams()
                    .credential(new UsernamePasswordCredential(
                            loginRequest.getLogin(),
                            loginRequest.getPassword()
                    ));

            AuthenticationStatus status = securityContext.authenticate(request, response, parameters);

            if (status == AuthenticationStatus.SUCCESS) {
                // Authentication successful - create session objects
                User user = userService.findUserByUsernameOrEmail(loginRequest.getLogin());

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUserName());
                session.setAttribute("userFullName", user.getFname() + " " + user.getLname());
                session.setAttribute("userRole", user.getRole().name());

                ResponseMessage message = new ResponseMessage(true, "Login successful");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(message));
                out.flush();
            } else {
                ResponseMessage message = new ResponseMessage(false, "Invalid username/email or password");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(message));
                out.flush();
            }

        } catch (Exception e) {
            e.printStackTrace();
            ResponseMessage message = new ResponseMessage(false, "Login failed. Please try again.");
            PrintWriter out = response.getWriter();
            out.write(new Gson().toJson(message));
            out.flush();
        }
    }

    private static class LoginRequest {
        private String login;
        private String password;

        public String getLogin() {
            return login;
        }

        public String getPassword() {
            return password;
        }
    }
}