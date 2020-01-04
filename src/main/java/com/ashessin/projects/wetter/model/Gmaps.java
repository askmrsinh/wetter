package com.ashessin.projects.wetter.model;

import java.util.StringJoiner;

public class Gmaps {

    private double latitude;
    private double longitude;
    private String formattedAddress;

    public Gmaps(double latitude, double longitude, String formattedAddress) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.formattedAddress = formattedAddress;
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

    public String getFormattedAddress() {
        return formattedAddress;
    }

    public void setFormattedAddress(String formattedAddress) {
        this.formattedAddress = formattedAddress;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", Gmaps.class.getSimpleName() + "[", "]")
            .add("latitude=" + latitude)
            .add("longitude=" + longitude)
            .add("formattedAddress='" + formattedAddress + "'")
            .toString();
    }
}
