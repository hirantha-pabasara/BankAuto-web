package lk.jiat.bankauto.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.ejb.EJB;
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

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            BufferedReader reader = request.getReader();
            StringBuilder jsonString = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonString.append(line);
            }

            Gson gson = new GsonBuilder().create();
            LoginRequest loginRequest = gson.fromJson(jsonString.toString(), LoginRequest.class);

            User user = userService.findUserByUsernameOrEmail(loginRequest.getLogin());

            if (user == null) {
                ResponseMessage message = new ResponseMessage(false, "Invalid username/email or password");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(message));
                out.flush();
                return;
            }

            BCrypt.Result result = BCrypt.verifyer().verify(loginRequest.getPassword().toCharArray(), user.getPassword());

            if (!result.verified) {
                ResponseMessage message = new ResponseMessage(false, "Invalid username/email or password");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(message));
                out.flush();
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUserName());
            session.setAttribute("userFullName", user.getFname() + " " + user.getLname());

            ResponseMessage message = new ResponseMessage(true, "Login successful");
            PrintWriter out = response.getWriter();
            out.write(gson.toJson(message));
            out.flush();

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
