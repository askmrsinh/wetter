package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.Oweather;

import java.util.List;

public interface OweatherDao {

    /**
     * @param rectangle
     * @param zoom
     *
     * @return
     *
     * @throws OweatherDaoException
     */
    List<Oweather> read(double[] rectangle, int zoom) throws OweatherDaoException;

    /**
     * @param city
     *
     * @return
     *
     * @throws OweatherDaoException
     */
    Oweather read(String city) throws OweatherDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @return
     *
     * @throws OweatherDaoException
     */
    Oweather read(double latitude, double longitude) throws OweatherDaoException;

    /**
     * @param oweather
     *
     * @throws OweatherDaoException
     */
    void create(Oweather oweather) throws OweatherDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @throws OweatherDaoException
     */
    void update(double latitude, double longitude) throws OweatherDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @throws OweatherDaoException
     */
    void delete(double latitude, double longitude) throws OweatherDaoException;
}
