package lk.jiat.bankauto.ejb.bean;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.bankauto.core.interceptor.LogMethod;
import lk.jiat.bankauto.core.interceptor.PerformanceMonitor;
import lk.jiat.bankauto.core.interceptor.SecurityCheck;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;
import lk.jiat.bankauto.core.exception.*;

import java.time.LocalDateTime;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class UserSessionBean implements UserService {

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager entityManager;

    @LogMethod
    @SecurityCheck
    @PerformanceMonitor
    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public User getUser(long id) throws UserNotFoundException , ValidationException {
        if (id <= 0) {
            throw new ValidationException("Invalid user ID");
        }

        User user = entityManager.find(User.class, id);
        if (user == null) {
            throw new UserNotFoundException("User not found with ID: " + id);
        }
        return user;
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public User getUserByUserName(String userName) throws UserNotFoundException , ValidationException {
        if (userName == null || userName.trim().isEmpty()) {
            throw new ValidationException("Username cannot be empty");
        }

        try {
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT u FROM User u WHERE u.userName = :userName", User.class);
            query.setParameter("userName", userName);
            return query.getSingleResult();
        } catch (NoResultException e) {
            throw new UserNotFoundException("User not found with username: " + userName);
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public User getUserByEmail(String email) throws UserNotFoundException , ValidationException {
        if (email == null || email.trim().isEmpty()) {
            throw new ValidationException("Email cannot be empty");
        }

        try {
            return entityManager.createNamedQuery("User.findByEmail", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            throw new UserNotFoundException("User not found with email: " + email);
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public User getUserByPhone(String phoneNumber) throws UserNotFoundException , ValidationException {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            throw new ValidationException("Phone number cannot be empty");
        }

        try {
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT u FROM User u WHERE u.phoneNumber = :phoneNumber", User.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.getSingleResult();
        } catch (NoResultException e) {
            throw new UserNotFoundException("User not found with phone: " + phoneNumber);
        }
    }

    @Override
    @LogMethod
    @SecurityCheck
    @PerformanceMonitor
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void saveUser(User user) throws UserAlreadyExistsException, ValidationException {
        // Validation
        if (user == null) {
            throw new ValidationException("User cannot be null");
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new ValidationException("Email is required");
        }
        if (user.getUserName() == null || user.getUserName().trim().isEmpty()) {
            throw new ValidationException("Username is required");
        }
        if (user.getPassword() == null || user.getPassword().length() < 6) {
            throw new ValidationException("Password must be at least 6 characters");
        }

        // Check if user already exists
        if (isUserExists(user.getEmail(), user.getUserName(), user.getNIC(), user.getPhoneNumber())) {
            throw new UserAlreadyExistsException("User with provided details already exists");
        }

        user.setCreatedAt(LocalDateTime.now());
        entityManager.persist(user);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public User updateUser(User user) throws UserNotFoundException, ValidationException {
        if (user == null || user.getId() <= 0) {
            throw new ValidationException("Invalid user data for update");
        }

        // Check if user exists
        User existingUser = getUser(user.getId());

        existingUser.setFname(user.getFname());
        existingUser.setLname(user.getLname());
        existingUser.setEmail(user.getEmail());
        existingUser.setUpdatedAt(LocalDateTime.now());

        return entityManager.merge(existingUser);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deleteUser(long id) throws UserNotFoundException , ValidationException {
        User user = getUser(id); // This will throw UserNotFoundException if not found
        entityManager.remove(user);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean isUserNameExists(String userName) {
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.userName = :userName", Long.class);
            query.setParameter("userName", userName);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean isEmailExists(String email) {
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class);
            query.setParameter("email", email);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean isPhoneNumberExists(String phoneNumber) {
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.phoneNumber = :phoneNumber", Long.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean isNICExists(String nic) {
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.NIC = :nic", Long.class);
            query.setParameter("nic", nic);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    @LogMethod
    @SecurityCheck
    @PerformanceMonitor
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean isUserExists(String email, String userName, String nic, String phoneNumber) {
        return isEmailExists(email) || isUserNameExists(userName) ||
                isNICExists(nic) || isPhoneNumberExists(phoneNumber);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public User findUserByUsernameOrEmail(String login) throws UserNotFoundException , ValidationException {
        if (login == null || login.trim().isEmpty()) {
            throw new ValidationException("Login cannot be empty");
        }

        try {
            TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsernameOrEmail", User.class);
            query.setParameter("login", login);
            return query.getSingleResult();
        } catch (NoResultException e) {
            throw new UserNotFoundException("User not found with login: " + login);
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean validateUser(String email, String password) throws ValidationException {
        if (email == null || email.trim().isEmpty()) {
            throw new ValidationException("Email cannot be empty");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new ValidationException("Password cannot be empty");
        }

        try {
            User user = getUserByEmail(email);
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            return result.verified;
        } catch (UserNotFoundException e) {
            return false;
        }
    }
}
