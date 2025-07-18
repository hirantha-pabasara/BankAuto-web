package lk.jiat.bankauto.core.service;

import jakarta.ejb.Remote;
import lk.jiat.bankauto.core.exception.UserAlreadyExistsException;
import lk.jiat.bankauto.core.exception.UserNotFoundException;
import lk.jiat.bankauto.core.exception.ValidationException;
import lk.jiat.bankauto.core.model.User;

@Remote
public interface UserService {
    User getUser(long id) throws UserNotFoundException , ValidationException;
    User getUserByUserName(String userName) throws UserNotFoundException,ValidationException;
    User getUserByEmail(String email) throws UserNotFoundException,ValidationException;
    User getUserByPhone(String phoneNumber) throws UserNotFoundException,ValidationException;
    void saveUser(User user) throws UserAlreadyExistsException, ValidationException;
    User updateUser(User user) throws UserNotFoundException, ValidationException;
    void deleteUser(long id) throws UserNotFoundException,ValidationException;
    boolean isUserNameExists(String userName);
    boolean isEmailExists(String email);
    boolean isPhoneNumberExists(String phoneNumber);
    boolean isNICExists(String nic);
    boolean isUserExists(String email, String userName, String nic, String phoneNumber);
    User findUserByUsernameOrEmail(String login) throws  UserNotFoundException,ValidationException;
    boolean validateUser(String email, String password) throws ValidationException;
}