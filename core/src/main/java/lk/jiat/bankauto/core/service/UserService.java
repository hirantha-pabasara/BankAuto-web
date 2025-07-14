package lk.jiat.bankauto.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bankauto.core.model.User;

@Remote
public interface UserService {
    User getUser(long id);
    User getUserByUserName(String userName);
    User getUserByEmail(String email);
    User getUserByPhone(String phoneNumber);
    void saveUser(User user);
    User updateUser(User user);
    void deleteUser(long id);
    boolean isUserNameExists(String userName);
    boolean isEmailExists(String email);
    boolean isPhoneNumberExists(String phoneNumber);
    boolean isNICExists(String nic);
    boolean isUserExists(String email, String userName, String nic, String phoneNumber);
    User findUserByUsernameOrEmail(String login);
    boolean validateUser(String email, String password);
}