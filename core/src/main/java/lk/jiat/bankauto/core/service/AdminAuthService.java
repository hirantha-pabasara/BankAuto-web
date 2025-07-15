package lk.jiat.bankauto.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bankauto.core.model.User;

import java.time.LocalDateTime;

@Remote
public interface AdminAuthService {
    User getUserById(Long id);
    User getUserByEmail(String email);
    User getUserByVerificationCode(String verificationCode);
    void addUser(User user);
    void updateUser(User user);
    void deleteUser(User user);
    boolean validate(String email, String password);
    boolean verifyUser(String email, String verificationCode);
    void updateVerificationCode(String email, String verificationCode, LocalDateTime expiry);
    // Add this method to your UserService interface
    User findUserByUsernameOrEmail(String login);
}
