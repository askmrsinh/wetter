package com.ashessin.projects.wetter.model;

import java.net.URL;
import java.util.Date;

/**
 * A news POJO that represents the item read from some data source.
 */
public class News {

    private String type;
    private String title;
    private String description;
    private URL link;
    private Date pubDate;

    public News(String type, String title, String description, URL link, Date pubDate) {
        this.type = type;
        this.title = title;
        this.description = description;
        this.link = link;
        this.pubDate = pubDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public URL getLink() {
        return link;
    }

    public void setLink(URL link) {
        this.link = link;
    }

    public Date getPubDate() {
        return pubDate;
    }

    public void setPubDate(Date pubDate) {
        this.pubDate = pubDate;
    }

    @Override
    public String toString() {
        return "News{" +
                "type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", link=" + link +
                ", pubDate=" + pubDate +
                '}';
    }
}
