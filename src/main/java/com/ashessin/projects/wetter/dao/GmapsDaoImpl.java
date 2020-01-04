package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.Gmaps;
import kong.unirest.HttpResponse;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;
import kong.unirest.UnirestException;
import kong.unirest.json.JSONObject;

public class GmapsDaoImpl implements GmapsDao {

    private static final String KEY = System.getenv("API_KEY_GMAPS");
    private static final String URI_PREFIX = "https://maps.googleapis.com/maps/api/geocode/json";

    /**
     * @param latitude
     * @param longitude
     *
     * @return
     *
     * @throws GmapsDaoException
     */
    @Override
    public Gmaps read(double latitude, double longitude) throws GmapsDaoException {
        return retriveGeocode(latitude, longitude, null, Required.LOCATION);
    }

    /**
     * @param address
     *
     * @return
     *
     * @throws GmapsDaoException
     */
    @Override
    public Gmaps read(String address) throws GmapsDaoException {
        return retriveGeocode(null, null, address, Required.ADDRESS);
    }

    /**
     * @param latitude
     * @param longitude
     * @param address
     * @param required
     *
     * @return
     *
     * @throws GmapsDaoException
     */
    private Gmaps retriveGeocode(Double latitude, Double longitude, String address,
                                 Required required) throws GmapsDaoException {
        Gmaps geocode = null;
        HttpResponse<JsonNode> response;
        String field;
        String fieldValue;

        if (required == Required.ADDRESS) {
            field = "address";
            fieldValue = address;
        } else {
            field = "latlng";
            fieldValue = latitude + "," + longitude;
        }

        try {
            response = Unirest.get(URI_PREFIX)
                .queryString("key", KEY)
                .queryString(field, fieldValue)
                .header("Accept-Encoding", "application/gzip")
                .asJson();
        } catch (UnirestException e) {
            throw new GmapsDaoException("Could not get geocode from Google Maps API", e);
        }

        if (response.isSuccess()) {
            JSONObject firstResultsObject = response.getBody().getObject()
                .getJSONArray("results")
                .getJSONObject(0);
            JSONObject location = firstResultsObject.getJSONObject("geometry")
                .getJSONObject("location");
            String formattedAddress = firstResultsObject.getString("formatted_address");

            geocode = new Gmaps(location.getDouble("lat"), location.getDouble("lng"), formattedAddress);
        }

        return geocode;
    }

    /**
     * @param geocode
     *
     * @throws GmapsDaoException
     */
    @Override
    public void create(Gmaps geocode) throws GmapsDaoException {
        // Not required at the moment
    }

    /**
     * @param latitude
     * @param longitude
     *
     * @throws GmapsDaoException
     */
    @Override
    public void update(double latitude, double longitude) throws GmapsDaoException {
        // Not required at the moment
    }

    /**
     * @param latitude
     * @param longitude
     *
     * @throws GmapsDaoException
     */
    @Override
    public void delete(double latitude, double longitude) throws GmapsDaoException {
        // Not required at the moment
    }

    private enum Required {
        LOCATION,
        ADDRESS
    }
}
