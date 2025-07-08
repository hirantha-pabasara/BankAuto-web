package lk.jiat.bankauto.core.mail;

import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

public class VerificationMail extends Mailable {
    private String recipientEmail;
    private String verificationCode;

    public VerificationMail(String recipientEmail, String verificationCode) {
        this.recipientEmail = recipientEmail;
        this.verificationCode = verificationCode;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
        message.setSubject("Email Verification Required");

        String htmlContent = buildHtmlContent();
        message.setContent(htmlContent, "text/html; charset=utf-8");
    }

    private String buildHtmlContent() {
        return "<html>" +
                "<body style=\"font-family: Arial, sans-serif; line-height: 1.6; color: #333;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;\">" +
                "<h2 style=\"color: #007bff; text-align: center;\">Email Verification</h2>" +
                "<p>Hello,</p>" +
                "<p>Thank you for registering with our application. To complete your email verification, please use the verification code below:</p>" +
                "<div style=\"text-align: center; margin: 30px 0;\">" +
                "<span style=\"background-color: #f8f9fa; padding: 15px 30px; border: 2px dashed #007bff; font-size: 24px; font-weight: bold; letter-spacing: 3px; color: #007bff;\">" +
                verificationCode +
                "</span>" +
                "</div>" +
                "<p>This verification code will expire in 15 minutes for security reasons.</p>" +
                "<p>If you didn't request this verification, please ignore this email.</p>" +
                "<hr style=\"margin: 30px 0; border: none; height: 1px; background-color: #eee;\">" +
                "<p style=\"font-size: 12px; color: #666; text-align: center;\">" +
                "This is an automated message. Please do not reply to this email." +
                "</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}