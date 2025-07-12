package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.bankauto.core.model.BankAccount;
import lk.jiat.bankauto.core.service.AccountService;
import lk.jiat.bankauto.core.util.LocalDateTimeAdapter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/user/account-details")
public class UserAccountServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UserAccountServlet.class.getName());

    @EJB
    private AccountService accountService;

    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");

        try {
            // Check session and get user ID
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\":\"Unauthorized\"}");
                return;
            }

            Long userId = (Long) session.getAttribute("userId");
            logger.info("Fetching accounts for user ID: " + userId);

            // Get accounts from EJB service
            List<BankAccount> accounts = accountService.getUserAccounts(userId);

            // Convert to JSON using Gson
            String json = gson.toJson(accounts);
            response.getWriter().write(json);

            logger.info("Successfully returned " + accounts.size() + " accounts for user " + userId);

        } catch (Exception e) {
            logger.severe("Error fetching user accounts: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Internal server error\"}");
        }

    }
}
