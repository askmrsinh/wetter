package com.ashessin.projects.wetter.model;

import kong.unirest.json.JSONObject;

import java.util.Arrays;
import java.util.StringJoiner;

/**
 * A OpenWeather POJO that represents the item read from some data source.
 */
public class Oweather {

    private String bbox;
    private String name;
    private double latitude;
    private double longitude;
    private JSONObject main;

    public Oweather(double[] rectangle, int zoom, double latitude, double longitude, String name, JSONObject main) {
        this.bbox = Arrays.toString(rectangle)
            .replace("[", "")
            .replace("]", "")
            .replace(" ", "") + "," + zoom;
        this.latitude = latitude;
        this.longitude = longitude;
        this.name = name;
        this.main = main;
    }

    public Oweather(String bbox, double latitude, double longitude, String name, JSONObject main) {
        this.bbox = bbox;
        this.latitude = latitude;
        this.longitude = longitude;
        this.name = name;
        this.main = main;
    }

    public String getBbox() {
        return bbox;
    }

    public void setBbox(String bbox) {
        this.bbox = bbox;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public JSONObject getMain() {
        return main;
    }

    public void setMain(JSONObject main) {
        this.main = main;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", Oweather.class.getSimpleName() + "[", "]")
            .add("bbox='" + bbox + "'")
            .add("name='" + name + "'")
            .add("latitude=" + latitude)
            .add("longitude=" + longitude)
            .add("main=" + main)
            .toString();
    }
}

// TODO:
//  Replace JSONObject type fields
//  Stronger type checking
