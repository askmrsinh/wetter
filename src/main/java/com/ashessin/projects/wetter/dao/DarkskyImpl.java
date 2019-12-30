package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.Darksky;
import kong.unirest.HttpResponse;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;
import kong.unirest.UnirestException;
import kong.unirest.json.JSONObject;

import java.util.TimeZone;

public class DarkskyImpl implements DarkskyDao {

    private static final String KEY = System.getenv("API_KEY_DARKSKY");
    private static final String URI_PREFIX = "https://api.darksky.net/forecast/";

    /**
     * @param latitude
     * @param longitude
     *
     * @return
     *
     * @throws DarkskyDaoException
     */
    @Override
    public Darksky read(double latitude, double longitude) throws DarkskyDaoException {
        Darksky forecast = null;
        HttpResponse<JsonNode> response;
        try {
            response = Unirest.get(URI_PREFIX + "{key}/{latitude},{longitude}")
                .routeParam("key", KEY)
                .routeParam("latitude", String.valueOf(latitude))
                .routeParam("longitude", String.valueOf(longitude))
                .header("Accept-Encoding", "application/gzip")
                .asJson();
        } catch (UnirestException e) {
            throw new DarkskyDaoException("Could not get forecast from Darksky API", e);
        }

        if (response.isSuccess()) {
            JSONObject jsonObject = response.getBody().getObject();
            double lat = jsonObject.getDouble("latitude");
            double lng = jsonObject.getDouble("longitude");
            TimeZone timezone = TimeZone.getTimeZone(jsonObject.getString("timezone"));
            JSONObject currently = jsonObject.getJSONObject("currently");
            JSONObject hourly = jsonObject.getJSONObject("hourly");
            JSONObject daily = jsonObject.getJSONObject("daily");
            JSONObject flags = jsonObject.getJSONObject("flags");

            forecast = new Darksky(lat, lng, timezone, currently, hourly, daily, flags);
        }

        return forecast;
    }

    /**
     * @param forecast
     *
     * @throws DarkskyDaoException
     */
    @Override
    public void create(Darksky forecast) throws DarkskyDaoException {
        // Not required at the moment
    }

    /**
     * @param latitude
     * @param longitude
     *
     * @throws DarkskyDaoException
     */
    @Override
    public void update(double latitude, double longitude) throws DarkskyDaoException {
        // Not required at the moment
    }

    /**
     * @param latitude
     * @param longitude
     *
     * @throws DarkskyDaoException
     */
    @Override
    public void delete(double latitude, double longitude) throws DarkskyDaoException {
        // Not required at the moment
    }
}
