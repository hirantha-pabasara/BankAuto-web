package lk.jiat.bankauto.core.mail;

import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lk.jiat.bankauto.core.provider.MailServiceProvider;

public abstract class Mailable implements Runnable {
    private MailServiceProvider mailServiceProvider;

    public Mailable() {
        this.mailServiceProvider = MailServiceProvider.getInstance();
    }

    @Override
    public void run() {
        try {
            Session session = Session.getInstance(mailServiceProvider.getProperties(),
                    mailServiceProvider.getAuthenticator());
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("admin@bankauto.com"));
            build(message);
            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public abstract void build(Message message) throws Exception;
}