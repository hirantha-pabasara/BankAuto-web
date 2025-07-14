package lk.jiat.bankauto.ejb.bean;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager entityManager;

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
        return null;
    }

    @Override
    public User getUserByEmail(String email) {
        return entityManager.createNamedQuery("User.findByEmail", User.class)
                .setParameter("email", email)
                .getSingleResult();
    }

    @Override
    public User getUserByPhone(String phoneNumber) {
        return null;
    }

    @Override
    public void  saveUser(User user) {
        entityManager.persist(user);
    }


    @Override
    public User updateUser(User user) {
        return null;
    }

    @Override
    public void deleteUser(long id) {

    }

    @Override
    public boolean isUserNameExists(String userName) {
        return false;
    }

    @Override
    public boolean isEmailExists(String email) {
        return false;
    }

    @Override
    public boolean isPhoneNumberExists(String phoneNumber) {
        return false;
    }

    @Override
    public boolean isNICExists(String nic) {
        return false;
    }

    @Override
    public boolean isUserExists(String email, String userName, String nic, String phoneNumber) {
        return false;
    }

    @Override
    public User findUserByUsernameOrEmail(String login) {
        try{
            return entityManager.createNamedQuery("User.findByUsernameOrEmail", User.class)
                    .setParameter("login", login)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
    }

    @Override
    public boolean validateUser(String email, String password) {
//        User user =entityManager.createNamedQuery("User.findByEmail", User.class)
//                .setParameter("email", email).getSingleResult();
//
//        return user != null && user.getPassword().equals(password);
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