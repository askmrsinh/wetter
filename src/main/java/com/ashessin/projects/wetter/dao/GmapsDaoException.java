package com.ashessin.projects.wetter.dao;

public class GmapsDaoException extends Exception {

    public GmapsDaoException() {
        super();
    }

    public GmapsDaoException(String message) {
        super(message);
    }

    public GmapsDaoException(String message, Throwable cause) {
        super(message, cause);
    }

    public GmapsDaoException(Throwable cause) {
        super(cause);
    }

    protected GmapsDaoException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
