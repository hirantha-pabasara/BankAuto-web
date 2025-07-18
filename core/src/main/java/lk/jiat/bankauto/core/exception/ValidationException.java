package lk.jiat.bankauto.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class ValidationException extends Exception{
    public ValidationException(String message) {
        super(message);
    }
}
