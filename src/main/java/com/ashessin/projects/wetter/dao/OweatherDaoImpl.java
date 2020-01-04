package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.Oweather;
import kong.unirest.HttpResponse;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;
import kong.unirest.UnirestException;
import kong.unirest.json.JSONArray;
import kong.unirest.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class OweatherDaoImpl implements OweatherDao {

    private static final String KEY = System.getenv("API_KEY_OWEATHER");
    private static final String URI_PREFIX = "https://api.openweathermap.org/data/2.5/box/city";

    /**
     * @return
     *
     * @throws OweatherDaoException
     */
    @Override
    public List<Oweather> read(double[] rectangle, int zoom) throws OweatherDaoException {
        List<Oweather> forecasts = new ArrayList<>(10);
        HttpResponse<JsonNode> response;
        try {
            response = Unirest.get(URI_PREFIX)
                .queryString("bbox", Arrays.toString(rectangle)
                    .replace("[", "")
                    .replace("]", "")
                    .replace(" ", "") + "," + zoom)
                .queryString("units", "metric")
                .queryString("cluster", "yes")
                .queryString("APPID", KEY)
                .header("Accept-Encoding", "application/gzip")
                .asJson();
            System.out.println(response.getHeaders());
        } catch (UnirestException e) {
            throw new OweatherDaoException("Could not get forecast from OpenWeather API", e);
        }

        if (response.isSuccess()) {
            JSONArray list = response.getBody().getObject().getJSONArray("list");
            for (int i = 0; i < list.length(); i++) {
                JSONObject l = list.getJSONObject(i);
                double lat = l.getJSONObject("coord").getDouble("Lat");
                double lng = l.getJSONObject("coord").getDouble("Lon");
                String name = l.getString("name");
                JSONObject main = l.getJSONObject("main");

                Oweather forecast = new Oweather(rectangle, zoom, lat, lng, name, main);
                forecasts.add(forecast);
            }
        }

        return forecasts;
    }

    /**
     * @param latitude
     * @param longitude
     *
     * @return
     *
     * @throws OweatherDaoException
     */
    @Override
    public Oweather read(double latitude, double longitude) throws OweatherDaoException {
        return null;
    }

    /**
     * @param city
     *
     * @return
     *
     * @throws OweatherDaoException
     */
    @Override
    public Oweather read(String city) throws OweatherDaoException {
        return null;
    }

    /**
     * @param oweather
     *
     * @throws OweatherDaoException
     */
    @Override
    public void create(Oweather oweather) throws OweatherDaoException {

    }

    /**
     * @param latitude
     * @param longitude
     *
     * @throws OweatherDaoException
     */
    @Override
    public void update(double latitude, double longitude) throws OweatherDaoException {

    }

    /**
     * @param latitude
     * @param longitude
     *
     * @throws OweatherDaoException
     */
    @Override
    public void delete(double latitude, double longitude) throws OweatherDaoException {

    }
}
