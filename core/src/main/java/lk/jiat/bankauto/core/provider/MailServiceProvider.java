package lk.jiat.bankauto.core.provider;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import lk.jiat.bankauto.core.mail.Mailable;

import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MailServiceProvider {
    private static MailServiceProvider instance;
    private ExecutorService executorService;
    private Properties properties;
    private Authenticator authenticator;

    private MailServiceProvider() {
        setupMailProperties();
    }

    public static synchronized MailServiceProvider getInstance() {
        if (instance == null) {
            instance = new MailServiceProvider();
        }
        return instance;
    }

    private void setupMailProperties() {
        properties = new Properties();

        // Gmail SMTP configuration (you can change this to your preferred email provider)
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // Create authenticator with your email credentials
        // TODO: Replace with your actual email and app password
        final String email = "your-email@gmail.com";
        final String password = "your-app-password"; // Use App Password for Gmail

        authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        };
    }

    public void start() {
        executorService = Executors.newFixedThreadPool(5);
        System.out.println("MailServiceProvider started with thread pool");
    }

    public void sendMail(Mailable mailable) {
        if (executorService != null && !executorService.isShutdown()) {
            executorService.submit(mailable);
        } else {
            throw new RuntimeException("MailServiceProvider is not started or has been shutdown");
        }
    }

    public void shutdown() {
        if (executorService != null) {
            executorService.shutdown();
            System.out.println("MailServiceProvider shutdown completed");
        }
    }

    public Properties getProperties() {
        return properties;
    }

    public Authenticator getAuthenticator() {
        return authenticator;
    }
}