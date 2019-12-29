package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.News;

import java.net.URL;
import java.util.List;

public interface NewsDao {

    /**
     * @param type
     * @param count
     * @return
     * @throws NewsDaoException
     */
    List<News> read(String type, int count) throws NewsDaoException;

    /**
     * @param news
     */
    void create(News news) throws NewsDaoException;

    /**
     * @param link
     */
    void update(URL link) throws NewsDaoException;

    /**
     * @param link
     */
    void delete(URL link) throws NewsDaoException;
}
