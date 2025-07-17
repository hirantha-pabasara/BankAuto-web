package lk.jiat.bankauto.core.interceptor;

import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import jakarta.annotation.Priority;
import java.util.logging.Logger;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;

@Interceptor
@PerformanceMonitor
@Priority(3000)
public class PerformanceInterceptor {

    private static final Logger logger = Logger.getLogger(PerformanceInterceptor.class.getName());
    private static final Map<String, Long> methodExecutionTimes = new ConcurrentHashMap<>();
    private static final Map<String, Integer> methodCallCounts = new ConcurrentHashMap<>();

    @AroundInvoke
    public Object monitorPerformance(InvocationContext context) throws Exception {
        String methodKey = context.getTarget().getClass().getSimpleName() + "." + context.getMethod().getName();

        logger.info("Performance monitoring started for: " + methodKey);

        long startTime = System.nanoTime();

        try {
            Object result = context.proceed();

            long executionTime = System.nanoTime() - startTime;
            updateStatistics(methodKey, executionTime);

            logger.info(String.format("Performance monitoring completed for: %s in %d ms",methodKey, executionTime / 1_000_000));

                    // Log if method takes longer than 1 second
            if (executionTime > 1_000_000_000L) {
                logger.warning(String.format("Slow method detected: %s took %d ms",
                        methodKey, executionTime / 1_000_000));
            }

            return result;

        } catch (Exception e) {
            long executionTime = System.nanoTime() - startTime;
            updateStatistics(methodKey, executionTime);
            logger.severe("Performance monitoring failed for: " + methodKey + " - " + e.getMessage());
            throw e;
        }
    }

    private void updateStatistics(String methodKey, long executionTime) {
        methodExecutionTimes.put(methodKey, executionTime);
        methodCallCounts.merge(methodKey, 1, Integer::sum);
    }

    public static Map<String, Long> getMethodExecutionTimes() {
        return new ConcurrentHashMap<>(methodExecutionTimes);
    }

    public static Map<String, Integer> getMethodCallCounts() {
        return new ConcurrentHashMap<>(methodCallCounts);
    }
}
