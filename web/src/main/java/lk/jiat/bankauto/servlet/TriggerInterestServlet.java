package lk.jiat.bankauto.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.bankauto.core.service.ScheduledInterestService;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Servlet to manually trigger interest calculation for testing purposes
 */
@WebServlet("/admin/trigger-interest")
public class TriggerInterestServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(TriggerInterestServlet.class.getName());
    private final Gson gson = new Gson();

    @EJB
    private ScheduledInterestService scheduledInterestService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        JsonObject jsonResponse = new JsonObject();
        
        try {
            logger.info("Manual interest calculation triggered by admin");
            
            int accountsProcessed = scheduledInterestService.triggerInterestCalculation();
            
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Interest calculation completed successfully!");
            jsonResponse.addProperty("accountsProcessed", accountsProcessed);
            
            logger.info("Manual interest calculation completed. Processed " + accountsProcessed + " accounts.");
            
        } catch (Exception e) {
            logger.severe("Error during manual interest calculation: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Failed to calculate interest: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("message", "Use POST method to trigger interest calculation");
        jsonResponse.addProperty("endpoint", "/admin/trigger-interest");
        jsonResponse.addProperty("method", "POST");
        
        response.getWriter().write(gson.toJson(jsonResponse));
    }
}
