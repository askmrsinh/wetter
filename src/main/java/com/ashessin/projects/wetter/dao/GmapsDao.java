package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.Gmaps;

public interface GmapsDao {

    /**
     * @param latitude
     * @param longitude
     *
     * @return
     *
     * @throws GmapsDaoException
     */
    Gmaps read(double latitude, double longitude) throws GmapsDaoException;

    /**
     * @param formattedAddress
     *
     * @return
     *
     * @throws GmapsDaoException
     */
    Gmaps read(String formattedAddress) throws GmapsDaoException;

    /**
     * @param geocode
     *
     * @throws GmapsDaoException
     */
    void create(Gmaps geocode) throws GmapsDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @throws GmapsDaoException
     */
    void update(double latitude, double longitude) throws GmapsDaoException;

    /**
     * @param latitude
     * @param longitude
     *
     * @throws GmapsDaoException
     */
    void delete(double latitude, double longitude) throws GmapsDaoException;
}
