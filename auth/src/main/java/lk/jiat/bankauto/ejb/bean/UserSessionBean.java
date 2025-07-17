package lk.jiat.bankauto.ejb.bean;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import lk.jiat.bankauto.core.interceptor.LogMethod;
import lk.jiat.bankauto.core.interceptor.PerformanceMonitor;
import lk.jiat.bankauto.core.interceptor.SecurityCheck;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;

import java.time.LocalDateTime;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager entityManager;

    @LogMethod
    @SecurityCheck
    @PerformanceMonitor
    @Override
    public User getUser(long id) {
        try {
            return entityManager.find(User.class, id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public User getUserByUserName(String userName) {
        try {
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT u FROM User u WHERE u.userName = :userName", User.class);
            query.setParameter("userName", userName);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public User getUserByEmail(String email) {
        try{
            return entityManager.createNamedQuery("User.findByEmail", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        }catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public User getUserByPhone(String phoneNumber) {
        try {
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT u FROM User u WHERE u.phoneNumber = :phoneNumber", User.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @LogMethod
    @SecurityCheck
    @PerformanceMonitor
    public void  saveUser(User user) {
        user.setCreatedAt(LocalDateTime.now());
        entityManager.persist(user);
    }


    @Override
    public User updateUser(User user) {
        user.setUpdatedAt(LocalDateTime.now());
        return entityManager.merge(user);
    }

    @Override
    public void deleteUser(long id) {
        User user = entityManager.find(User.class, id);
        if (user != null) {
            entityManager.remove(user);
        }
    }

    @Override
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
    public boolean isUserExists(String email, String userName, String nic, String phoneNumber) {
        return isEmailExists(email) || isUserNameExists(userName) ||
                isNICExists(nic) || isPhoneNumberExists(phoneNumber);
    }

    @Override
    public User findUserByUsernameOrEmail(String login) {
        try {
            TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsernameOrEmail", User.class);
            query.setParameter("login", login);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            System.out.println("Error finding user by username or email: " + e.getMessage());
            return null;
        }
    }

    @Override
    public boolean validateUser(String email, String password) {
        try {
            User user = getUserByEmail(email);
            if (user != null) {
                BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
                return result.verified;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

}