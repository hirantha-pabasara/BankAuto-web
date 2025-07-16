package lk.jiat.bankauto.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/logout")
public class UserLogout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Check if this is an admin logout
        String isAdmin = request.getParameter("admin");
        String redirectPath;
        
        if ("true".equals(isAdmin)) {
            System.out.println("Admin logged out successfully.");
            redirectPath = request.getContextPath() + "/admin/login.jsp";
        } else {
            System.out.println("User logged out successfully.");
            redirectPath = request.getContextPath() + "/user/login.jsp";
        }
        
        response.sendRedirect(redirectPath);
    }
}
