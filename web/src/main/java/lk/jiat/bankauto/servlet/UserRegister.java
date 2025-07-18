package lk.jiat.bankauto.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.dto.ResponseMessage;
import lk.jiat.bankauto.core.exception.UserAlreadyExistsException;
import lk.jiat.bankauto.core.exception.ValidationException;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/user/register")
public class UserRegister extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd") // For DOB field
                .create();

        try {
            BufferedReader reader = request.getReader();
            StringBuilder jsonString = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonString.append(line);
            }



            User user = gson.fromJson(jsonString.toString(), User.class);


            if (userService.isUserExists(user.getEmail(), user.getUserName(), user.getNIC(), user.getPhoneNumber())) {
                ResponseMessage message = new ResponseMessage(false, "User already exists");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(message));
                out.flush();
                return;
            }

            // Hash password before saving
            user.setPassword(BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray()));

            // Save user to database
            userService.saveUser(user);
            ResponseMessage message = new ResponseMessage(true, "User registered successfully");
            PrintWriter out = response.getWriter();
            out.write(gson.toJson(message));
            out.flush();

        } catch (UserAlreadyExistsException e) {
            ResponseMessage message = new ResponseMessage(false, e.getMessage());
            PrintWriter out = response.getWriter();
            out.write(gson.toJson(message));
            out.flush();

        } catch (ValidationException e) {
            ResponseMessage message = new ResponseMessage(false, "Validation Error: " + e.getMessage());
            PrintWriter out = response.getWriter();
            out.write(gson.toJson(message));
            out.flush();

        } catch (Exception e) {
            ResponseMessage message = new ResponseMessage(false, "System Error: " + e.getMessage());
            PrintWriter out = response.getWriter();
            out.write(gson.toJson(message));
            out.flush();
            e.printStackTrace();
        }
    }
}
