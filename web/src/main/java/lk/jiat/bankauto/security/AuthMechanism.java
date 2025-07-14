package lk.jiat.bankauto.security;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationException;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.authentication.mechanism.http.AutoApplySession;
import jakarta.security.enterprise.authentication.mechanism.http.HttpAuthenticationMechanism;
import jakarta.security.enterprise.authentication.mechanism.http.HttpMessageContext;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@AutoApplySession
@ApplicationScoped
public class AuthMechanism implements HttpAuthenticationMechanism {

    @Inject
    private IdentityStore identityStore;

    // Define public paths that don't require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/",
            "/index.jsp",
            "/index.html",
            "/user/login.jsp",
            "/user/register.jsp",
            "/user/create-account.jsp",
            "/user/signup.jsp",
            "/user/login",
            "/user/register",
            "/user/signup",
            "/user/create-account"
    );

    @Override
    public AuthenticationStatus validateRequest(HttpServletRequest request, HttpServletResponse response, HttpMessageContext context) throws AuthenticationException {

        // Handle explicit authentication requests (login attempts)
        AuthenticationParameters authParameters = context.getAuthParameters();
        if (authParameters.getCredential() != null) {
            CredentialValidationResult result = identityStore.validate(authParameters.getCredential());
            if (result.getStatus() == CredentialValidationResult.Status.VALID) {
                return context.notifyContainerAboutLogin(result);
            } else {
                return AuthenticationStatus.SEND_FAILURE;
            }
        }

        // Get the request path
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Allow access to static resources
        if (path.startsWith("/css/") ||
                path.startsWith("/js/") ||
                path.startsWith("/images/") ||
                path.startsWith("/assets/") ||
                path.startsWith("/static/") ||
                path.startsWith("/error/")) {
            return AuthenticationStatus.NOT_DONE;
        }

        // Allow access to public pages
        if (PUBLIC_PATHS.contains(path)) {
            return AuthenticationStatus.NOT_DONE;
        }

        // Check if user is already authenticated for protected resources
        if (context.getCallerPrincipal() != null) {
            return AuthenticationStatus.SUCCESS;
        }

        // Handle protected resources - redirect unauthenticated users to login
        if (context.isProtected()) {
            try {
                // For AJAX requests, return 401
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With")) ||
                        "application/json".equals(request.getContentType())) {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    return AuthenticationStatus.SEND_FAILURE;
                }

                // For regular requests, redirect to login
                response.sendRedirect(contextPath + "/user/login.jsp");
                return AuthenticationStatus.SEND_CONTINUE;
            } catch (IOException e) {
                throw new AuthenticationException("Failed to redirect to login page", e);
            }
        }

        return AuthenticationStatus.NOT_DONE;
    }
}