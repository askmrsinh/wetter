package com.ashessin.projects.wetter.dao;

public class NewsDaoException extends Exception {

    public NewsDaoException() {
        super();
    }

    public NewsDaoException(String message) {
        super(message);
    }

    public NewsDaoException(String message, Throwable cause) {
        super(message, cause);
    }

    public NewsDaoException(Throwable cause) {
        super(cause);
    }

    protected NewsDaoException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
