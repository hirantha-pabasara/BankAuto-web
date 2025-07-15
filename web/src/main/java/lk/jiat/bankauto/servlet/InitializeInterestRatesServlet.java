package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.service.InterestService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.logging.Logger;

@WebServlet("/admin/initialize-rates")
public class InitializeInterestRatesServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(InitializeInterestRatesServlet.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private InterestService interestService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Initialize default interest rates
            interestService.setInterestRate("Savings Account", new BigDecimal("2.5"));
            interestService.setInterestRate("Checking Account", new BigDecimal("0.5"));
            interestService.setInterestRate("Current Account", new BigDecimal("1.0"));
            interestService.setInterestRate("Fixed Deposit", new BigDecimal("5.0"));
            
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Default interest rates initialized successfully!");
            
            logger.info("Default interest rates initialized in database");
            
        } catch (Exception e) {
            logger.severe("Error initializing interest rates: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Failed to initialize interest rates: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(jsonResponse));
    }
}
