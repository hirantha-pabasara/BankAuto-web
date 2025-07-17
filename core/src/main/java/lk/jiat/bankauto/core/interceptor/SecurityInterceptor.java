package lk.jiat.bankauto.core.interceptor;

import jakarta.annotation.Priority;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;

import java.util.logging.Logger;

@Interceptor
@SecurityCheck
@Priority(1000)
public class SecurityInterceptor {
    private static final Logger logger = Logger.getLogger(SecurityInterceptor.class.getName());

    @AroundInvoke
    public Object checkSecurity(InvocationContext context) throws Exception {
        logger.info("Security check for method: " + context.getMethod().getName());

        // Get method parameters
        Object[] parameters = context.getParameters();

        // Example: Check if user ID is valid for sensitive operations
        if (context.getMethod().getName().equals("deleteUser") && parameters.length > 0) {
            Long userId = (Long) parameters[0];
            if (userId == null || userId <= 0) {
                logger.warning("Invalid user ID for deletion: " + userId);
                throw new SecurityException("Invalid user ID for deletion operation");
            }
        }

        // Check for SQL injection patterns in string parameters
        for (Object param : parameters) {
            if (param instanceof String) {
                String strParam = (String) param;
                if (containsSQLInjection(strParam)) {
                    logger.severe("Potential SQL injection detected: " + strParam);
                    throw new SecurityException("Invalid input detected");
                }
            }
        }

        return context.proceed();
    }

    private boolean containsSQLInjection(String input) {
        if (input == null) return false;
        String lowerInput = input.toLowerCase();
        return lowerInput.contains("drop table") ||
                lowerInput.contains("delete from") ||
                lowerInput.contains("truncate") ||
                lowerInput.contains("'") && lowerInput.contains("or") && lowerInput.contains("=");
    }

}
