package com.ashessin.projects.wetter;

import com.ashessin.projects.wetter.dao.DarkskyDaoException;
import com.ashessin.projects.wetter.dao.DarkskyImpl;
import com.ashessin.projects.wetter.dao.NewsDaoException;
import com.ashessin.projects.wetter.dao.NewsDaoRssImpl;

public class Main {

    public static void main(String[] args) {
        NewsDaoRssImpl newsDaoRssImpl = new NewsDaoRssImpl();
        try {
            newsDaoRssImpl.read("top/environment", 10)
                .forEach(s -> System.out.println(s));
        } catch (NewsDaoException e) {
            e.printStackTrace();
        }

        DarkskyImpl darkskyImpl = new DarkskyImpl();
        try {
            System.out.println(darkskyImpl.read(37.8267, -122.4233));
        } catch (DarkskyDaoException e) {
            e.printStackTrace();
        }
    }
}
