package com.ashessin.projects.wetter.model;

import kong.unirest.json.JSONObject;

import java.util.StringJoiner;
import java.util.TimeZone;

/**
 * A DarkSky POJO that represents the item read from some data source.
 */
public class Darksky {

    private double latitude;
    private double longitude;
    private TimeZone timezone;
    private JSONObject currently;
    private JSONObject hourly;
    private JSONObject daily;
    private JSONObject flags;

    public Darksky(double latitude, double longitude, TimeZone timezone, JSONObject currently, JSONObject hourly, JSONObject daily, JSONObject flags) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.timezone = timezone;
        this.currently = currently;
        this.hourly = hourly;
        this.daily = daily;
        this.flags = flags;
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

    public TimeZone getTimezone() {
        return timezone;
    }

    public void setTimezone(TimeZone timezone) {
        this.timezone = timezone;
    }

    public JSONObject getCurrently() {
        return currently;
    }

    public void setCurrently(JSONObject currently) {
        this.currently = currently;
    }

    public JSONObject getHourly() {
        return hourly;
    }

    public void setHourly(JSONObject hourly) {
        this.hourly = hourly;
    }

    public JSONObject getDaily() {
        return daily;
    }

    public void setDaily(JSONObject daily) {
        this.daily = daily;
    }

    public JSONObject getFlags() {
        return flags;
    }

    public void setFlags(JSONObject flags) {
        this.flags = flags;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", Darksky.class.getSimpleName() + "[", "]")
            .add("latitude=" + latitude)
            .add("longitude=" + longitude)
            .add("timezone=" + timezone)
            .add("currently=" + currently)
            .add("hourly=" + hourly)
            .add("daily=" + daily)
            .add("flags=" + flags)
            .toString();
    }
}
