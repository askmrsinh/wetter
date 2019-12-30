package com.ashessin.projects.wetter.dao;

public class DarkskyDaoException extends Exception {

    public DarkskyDaoException() {
        super();
    }

    public DarkskyDaoException(String message) {
        super(message);
    }

    public DarkskyDaoException(String message, Throwable cause) {
        super(message, cause);
    }

    public DarkskyDaoException(Throwable cause) {
        super(cause);
    }

    protected DarkskyDaoException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
