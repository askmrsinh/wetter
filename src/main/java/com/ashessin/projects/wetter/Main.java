package com.ashessin.projects.wetter;

import com.ashessin.projects.wetter.dao.*;

public class Main {

    public static void main(String[] args) {
        NewsDaoRssImpl newsDaoRssImpl = new NewsDaoRssImpl();
        try {
            newsDaoRssImpl.read("top/environment", 10)
                .forEach(System.out::println);
        } catch (NewsDaoException e) {
            e.printStackTrace();
        }

        OweatherDaoImpl oweatherDaoImpl = new OweatherDaoImpl();
        try {
            oweatherDaoImpl.read(new double[]{12, 32, 15, 37,}, 10)
                .forEach(System.out::println);
        } catch (OweatherDaoException e) {
            e.printStackTrace();
        }

        DarkskyDaoImpl darkskyDaoImpl = new DarkskyDaoImpl();
        try {
            System.out.println(darkskyDaoImpl.read(37.8267, -122.4233));
        } catch (DarkskyDaoException e) {
            e.printStackTrace();
        }

        GmapsDaoImpl gmapsDaoImpl = new GmapsDaoImpl();
        try {
            System.out.println(gmapsDaoImpl.read(37.8267, -122.4233));
            System.out.println(gmapsDaoImpl.read("Alcatraz Main Cell House"));
        } catch (GmapsDaoException e) {
            e.printStackTrace();
        }
    }
}
