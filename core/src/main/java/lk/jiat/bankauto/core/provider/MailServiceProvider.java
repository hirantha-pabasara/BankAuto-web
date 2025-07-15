package lk.jiat.bankauto.core.provider;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import lk.jiat.bankauto.core.mail.Mailable;

import java.util.Properties;
import java.util.concurrent.*;

//Annotation from V2 edition
@Singleton
public class MailServiceProvider {

    private Properties properties = new Properties();
    private Authenticator authenticator;
    private static MailServiceProvider instance;
    private ThreadPoolExecutor executor;
    private BlockingQueue<Runnable> blockingQueue = new LinkedBlockingQueue<>();

    public MailServiceProvider() {
        instance = this;
        initializeProperties();
    }

    private void initializeProperties() {
        // SMTP configuration for Gmail (you can change this to your preferred email provider)
//        properties.put("mail.smtp.host", "sandbox.smtp.mailtrap.io");
//        properties.put("mail.smtp.port", "2525");
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true");
//        properties.put("mail.smtp.ssl.trust", "no");
        properties.put("mail.smtp.host", "sandbox.smtp.mailtrap.io");
        properties.put("mail.smtp.port", "2525");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "false");
        properties.put("mail.smtp.connectiontimeout", "30000");
        properties.put("mail.smtp.timeout", "30000");
    }

    public static MailServiceProvider getInstance() {
        return instance;
    }

    @PostConstruct
    public void start(){
        authenticator = new Authenticator() {
            @Override
            protected  PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ffc668708a1ba0", "04200b079d7614");
            }
        };

        executor = new ThreadPoolExecutor(5, 10 , 5,TimeUnit.SECONDS,
                blockingQueue,
                new ThreadPoolExecutor.AbortPolicy());
                executor.prestartAllCoreThreads();
                System.out.println("MailServiceProvider started with thread pool");

    }

    public void sendMail(Mailable mailable) {
        if (executor != null && !executor.isShutdown()) {
            executor.submit(mailable);
        } else {
            throw new RuntimeException("MailServiceProvider is not started or has been shutdown");
        }
    }

    public Properties getProperties() {
        return properties;
    }

    public Authenticator getAuthenticator() {
        return authenticator;
    }

    @PreDestroy
    public void shutdown() {
        if (executor != null) {
            executor.shutdown();
            try {
                if (!executor.awaitTermination(10, TimeUnit.SECONDS)) {
                    executor.shutdownNow();
                }
            } catch (InterruptedException e) {
                executor.shutdownNow();
                Thread.currentThread().interrupt();
            }
            System.out.println("MailServiceProvider shutdown completed");
        }
    }




























    //V1 edition commented out
//    private static MailServiceProvider instance;
//    private ExecutorService executorService;
//    private Properties properties;
//    private Authenticator authenticator;
//
//    private MailServiceProvider() {
//        setupMailProperties();
//    }
//
//    public static synchronized MailServiceProvider getInstance() {
//        if (instance == null) {
//            instance = new MailServiceProvider();
//        }
//        return instance;
//    }
//
//    private void setupMailProperties() {
//        properties = new Properties();
//
//        // Gmail SMTP configuration (you can change this to your preferred email provider)
//        properties.put("mail.smtp.host", "smtp.gmail.com");
//        properties.put("mail.smtp.port", "587");
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true");
//        properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
//
//        // Create authenticator with your email credentials
//        // TODO: Replace with your actual email and app password
//        final String email = "your-email@gmail.com";
//        final String password = "your-app-password"; // Use App Password for Gmail
//
//        authenticator = new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(email, password);
//            }
//        };
//    }
//
//    public void start() {
//        executorService = Executors.newFixedThreadPool(5);
//        System.out.println("MailServiceProvider started with thread pool");
//    }
//
//    public void sendMail(Mailable mailable) {
//        if (executorService != null && !executorService.isShutdown()) {
//            executorService.submit(mailable);
//        } else {
//            throw new RuntimeException("MailServiceProvider is not started or has been shutdown");
//        }
//    }
//
//    public void shutdown() {
//        if (executorService != null) {
//            executorService.shutdown();
//            System.out.println("MailServiceProvider shutdown completed");
//        }
//    }
//
//    public Properties getProperties() {
//        return properties;
//    }
//
//    public Authenticator getAuthenticator() {
//        return authenticator;
//    }
}