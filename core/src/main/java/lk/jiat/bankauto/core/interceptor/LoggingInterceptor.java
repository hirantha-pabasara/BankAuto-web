package lk.jiat.bankauto.core.interceptor;

import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import jakarta.annotation.Priority;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.Arrays;

@Interceptor
@LogMethod
@Priority(2000)
public class LoggingInterceptor {

    private static final Logger logger = Logger.getLogger(LoggingInterceptor.class.getName());

    @AroundInvoke
    public Object logMethodCall(InvocationContext context) throws Exception {
        String methodName = context.getMethod().getName();
        String className = context.getTarget().getClass().getSimpleName();

        long startTime = System.currentTimeMillis();

        logger.info(String.format("Starting method: %s.%s with parameters: %s",
                className, methodName, Arrays.toString(context.getParameters())));

        try {
            Object result = context.proceed();

            long executionTime = System.currentTimeMillis() - startTime;
            logger.info(String.format("Method %s.%s completed successfully in %d ms",
                    className, methodName, executionTime));

            return result;

        } catch (Exception e) {
            long executionTime = System.currentTimeMillis() - startTime;
            logger.severe(String.format("Method %s.%s failed after %d ms with exception: %s",
                    className, methodName, executionTime, e.getMessage()));
            throw e;
        }
    }
}
