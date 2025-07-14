package lk.jiat.bankauto.core.model;

import jakarta.persistence.*;
import lk.jiat.bankauto.core.enums.UserRole;

import java.io.Serializable;

@Entity
@NamedQueries({
        @NamedQuery(name = "User.findByEmail", query = "select u from User u where u.email=:email"),
        @NamedQuery(name = "User.findAll", query = "select u from User u"),
        @NamedQuery(name = "User.findByUsernameOrEmail", query = "select u from User u where u.userName=:login OR u.email=:login"),
        @NamedQuery(name = "User.findByEmailAndPassword", query = "select u from User u where u.email=:email and u.password=:password"),
})
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "fname", length = 50,nullable = false)
    private String fname;

    @Column(name = "lname", length = 50, nullable = false)
    private String lname;

    @Column(name = "user_name", length = 50, nullable = false, unique = true)
    private String userName;

    @Column(name = "email", length = 100, nullable = false, unique = true)
    private String email;

    @Column(name = "password", length = 100, nullable = false)
    private String password;

    @Column(name = "phone_number", length = 15, nullable = false)
    private String phoneNumber;

    @Column(name = "address", length = 255, nullable = true)
    private String address;

    @Column(name = "dob", nullable = true)
    private String DOB;

    @Column(name = "nic", length = 12, nullable = true, unique = true)
    private String NIC;

   @Enumerated(EnumType.STRING)
    private UserRole role = UserRole.USER;

    public User() {
    }

    public User(long id, String fname, String lname, String userName, String email, String password, String phoneNumber, String address, String DOB, String NIC) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.DOB = DOB;
        this.NIC = NIC;
    }


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getNIC() {
        return NIC;
    }

    public void setNIC(String NIC) {
        this.NIC = NIC;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }
}
