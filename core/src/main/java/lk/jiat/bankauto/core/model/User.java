package lk.jiat.bankauto.core.model;

import jakarta.persistence.*;
import lk.jiat.bankauto.core.enums.UserRole;

import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@NamedQueries({
        @NamedQuery(name = "User.findByEmail", query = "select u from User u where u.email=:email"),
        @NamedQuery(name = "User.findAll", query = "select u from User u"),
        @NamedQuery(name = "User.findByUsernameOrEmail", query = "select u from User u where u.userName=:login OR u.email=:login"),
        @NamedQuery(name = "User.findByEmailAndPassword", query = "select u from User u where u.email=:email and u.password=:password"),
        @NamedQuery(name = "User.findByVerificationCode", query = "SELECT u FROM User u WHERE u.verificationCode = :code AND u.verificationExpiry > :now")
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
    @Column(name = "role")
    private UserRole role = UserRole.USER;

    // Verification fields (Version 2 edition)

    @Column(name = "verification_code", length = 255)
    private String verificationCode;

    @Column(name = "is_verified", nullable = false)
    private boolean isVerified = false;

    @Column(name = "verification_expiry")
    private LocalDateTime verificationExpiry;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public User() {
        // Version 2 edition constructor
        this.createdAt = LocalDateTime.now();
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

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public LocalDateTime getVerificationExpiry() {
        return verificationExpiry;
    }

    public void setVerificationExpiry(LocalDateTime verificationExpiry) {
        this.verificationExpiry = verificationExpiry;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Version 2 edition: Automatically set createdAt and updatedAt timestamps

    @PrePersist
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

}
