package lk.jiat.bankauto.security;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import lk.jiat.bankauto.core.model.User;
import lk.jiat.bankauto.core.service.UserService;

import java.util.Set;

@ApplicationScoped
public class AppIdentityStore implements IdentityStore {

    @EJB
    private UserService userService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential) {
            UsernamePasswordCredential upc = (UsernamePasswordCredential) credential;

            try {
                User user = userService.findUserByUsernameOrEmail(upc.getCaller());

                if (user != null) {
                    // Use BCrypt to verify password
                    BCrypt.Result result = BCrypt.verifyer().verify(
                            upc.getPasswordAsString().toCharArray(),
                            user.getPassword()
                    );

                    if (result.verified) {
                        return new CredentialValidationResult(
                                user.getEmail(),
                                Set.of(user.getRole().name())
                        );
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return CredentialValidationResult.INVALID_RESULT;
    }
}