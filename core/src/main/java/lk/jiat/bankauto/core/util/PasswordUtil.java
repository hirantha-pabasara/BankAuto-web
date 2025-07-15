package lk.jiat.bankauto.core.util;

import at.favre.lib.crypto.bcrypt.BCrypt;

public class PasswordUtil {
    private static final int COST = 12; // Cost factor for BCrypt

    //Hash a plain password using BCrypt

    public static final String hashPassword(String plainPassword) {
        return BCrypt.withDefaults().hashToString(COST, plainPassword.toCharArray());
    }

    //Verify a plain password against a hashed password

    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        BCrypt.Result result = BCrypt.verifyer().verify(plainPassword.toCharArray(), hashedPassword);
        return result.verified;
    }


}
