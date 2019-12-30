package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.Darksky;

public interface DarkskyDao {

    /**
     * @param latitude
     * @param longitude
     *
     * @return
     *
     * @throws DarkskyDaoException
     */
    Darksky read(double latitude, double longitude) throws DarkskyDaoException;

    /**
     * @param forecast
     *
     * @throws DarkskyDaoException
     */
    void create(Darksky forecast) throws DarkskyDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @throws DarkskyDaoException
     */
    void update(double latitude, double longitude) throws DarkskyDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @throws DarkskyDaoException
     */
    void delete(double latitude, double longitude) throws DarkskyDaoException;
}
