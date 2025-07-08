package lk.jiat.bankauto.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext(unitName = "BankAutoPU")
    private EntityManager entityManager;

    @Override
    public User getUser(long id) {
        return null;
    }

    @Override
    public User getUserByUserName(String userName) {
        return null;
    }

    @Override
    public User getUserByEmail(String email) {
        return null;
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


}
