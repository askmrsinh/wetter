package com.ashessin.projects.wetter.dao;

public class OweatherDaoException extends Exception {

    public OweatherDaoException() {
        super();
    }

    public OweatherDaoException(String message) {
        super(message);
    }

    public OweatherDaoException(String message, Throwable cause) {
        super(message, cause);
    }

    public OweatherDaoException(Throwable cause) {
        super(cause);
    }

    protected OweatherDaoException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
