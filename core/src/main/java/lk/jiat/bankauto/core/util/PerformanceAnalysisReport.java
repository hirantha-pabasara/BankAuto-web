package lk.jiat.bankauto.core.util;

import lk.jiat.bankauto.core.interceptor.PerformanceInterceptor;

import java.util.Map;

public class PerformanceAnalysisReport {
    public static void generateReport() {
        Map<String, Long> executionTimes = PerformanceInterceptor.getMethodExecutionTimes();
        Map<String, Integer> callCounts = PerformanceInterceptor.getMethodCallCounts();

        System.out.println("=== Performance Analysis Report ===");
        System.out.println("Method Execution Times (in milliseconds):");

        executionTimes.entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .forEach(entry -> {
                    String method = entry.getKey();
                    long timeMs = entry.getValue() / 1_000_000;
                    int calls = callCounts.getOrDefault(method, 0);
                    System.out.printf("%s: %d ms (called %d times)%n", method, timeMs, calls);
                });

        System.out.println("\nTop 5 Most Called Methods:");
        callCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(5)
                .forEach(entry -> System.out.printf("%s: %d calls%n", entry.getKey(), entry.getValue()));
    }
}
