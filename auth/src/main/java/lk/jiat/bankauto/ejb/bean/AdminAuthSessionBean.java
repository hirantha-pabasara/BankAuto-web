package lk.jiat.bankauto.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.AdminAuthService;
import lk.jiat.bankauto.core.util.PasswordUtil;

import java.time.LocalDateTime;
import java.util.logging.Logger;

@Stateless
public class AdminAuthSessionBean implements AdminAuthService {

    private static final Logger logger = Logger.getLogger(AdminAuthSessionBean.class.getName());

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager em;

    @Override
    public User getUserById(Long id) {
        try {
            return em.find(User.class, id);
        } catch (Exception e) {
            logger.severe("Error finding user by ID: " + e.getMessage());
            return null;
        }
    }

    @Override
    public User getUserByEmail(String email) {
        try {
            TypedQuery<User> query = em.createNamedQuery("User.findByEmail", User.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            logger.severe("Error finding user by email: " + e.getMessage());
            return null;
        }
    }

    @Override
    public User getUserByVerificationCode(String verificationCode) {
        try {
            TypedQuery<User> query = em.createNamedQuery("User.findByVerificationCode", User.class);
            query.setParameter("code", verificationCode);
            query.setParameter("now", LocalDateTime.now());
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            logger.severe("Error finding user by verification code: " + e.getMessage());
            return null;
        }
    }

    @Override
    public void addUser(User user) {
        try{
         em.persist(user);
         em.flush();
            logger.info("User added successfully: " + user.getEmail());
        }catch(Exception e){
            logger.severe("Error adding user: " + e.getMessage());
            throw new RuntimeException("Failed to add user: " + e.getMessage(), e);
        }
    }

    @Override
    public void updateUser(User user) {
        try {
            em.merge(user);
            em.flush();
            logger.info("User updated successfully: " + user.getEmail());
        } catch (Exception e) {
            logger.severe("Error updating user: " + e.getMessage());
            throw new RuntimeException("Failed to update user", e);
        }
    }

    @Override
    public void deleteUser(User user) {
        try {
            User managedUser = em.merge(user);
            em.remove(managedUser);
            em.flush();
            logger.info("User deleted successfully: " + user.getEmail());
        } catch (Exception e) {
            logger.severe("Error deleting user: " + e.getMessage());
            throw new RuntimeException("Failed to delete user", e);
        }
    }

    @Override
    public boolean validate(String email, String password) {
        try {
            User user = getUserByEmail(email);
            if (user != null && user.isVerified()) {
                return PasswordUtil.verifyPassword(password, user.getPassword());
            }
            return false;
        } catch (Exception e) {
            logger.severe("Error validating user: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean verifyUser(String email, String verificationCode) {
        try {
            User user = getUserByEmail(email);
            if (user != null &&
                    verificationCode.equals(user.getVerificationCode()) &&
                    user.getVerificationExpiry() != null &&
                    user.getVerificationExpiry().isAfter(LocalDateTime.now())) {

                user.setVerified(true);
                user.setVerificationCode(null);
                user.setVerificationExpiry(null);
                updateUser(user);
                return true;
            }
            return false;
        } catch (Exception e) {
            logger.severe("Error verifying user: " + e.getMessage());
            return false;
        }
    }

    @Override
    public void updateVerificationCode(String email, String verificationCode, LocalDateTime expiry) {
        try {
            User user = getUserByEmail(email);
            if (user != null) {
                user.setVerificationCode(verificationCode);
                user.setVerificationExpiry(expiry);
                updateUser(user);
            }
        } catch (Exception e) {
            logger.severe("Error updating verification code: " + e.getMessage());
            throw new RuntimeException("Failed to update verification code", e);
        }
    }

    @Override
    public User findUserByUsernameOrEmail(String login) {
        try {
            TypedQuery<User> query = em.createNamedQuery("User.findByUsernameOrEmail", User.class);
            query.setParameter("login", login);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            logger.severe("Error finding user by username or email: " + e.getMessage());
            return null;
        }
    }
}
