package lk.jiat.bankauto.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class UserAlreadyExistsException extends Exception{
    public UserAlreadyExistsException(String message) {
        super(message);
    }
}
