package com.ashessin.projects.wetter.dao;

import com.ashessin.projects.wetter.model.News;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.net.URI;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class NewsDaoRssImpl implements NewsDao {

    private static final String ITEM = "item";
    private static final String TITLE = "title";
    private static final String DESCRIPTION = "description";
    private static final String LINK = "link";
    private static final String PUB_DATE = "pubDate";

    private static final String[] SCIENCE_DAILY = {
        "top/environment",
        "earth_climate/pollution",
        "earth_climate/oil_spills",
        "earth_climate/renewable_energy",
        "earth_climate/recycling_and_waste",
        "earth_climate/global_warming",
        "earth_climate/ozone_holes",
        "earth_climate/air_quality"
    };

    private SimpleDateFormat rfc822DateFormat = new SimpleDateFormat(
        "E, d MMM yyyy HH:mm:ss Z", Locale.US);


    /**
     * @param type
     * @param count
     *
     * @return
     *
     * @throws NewsDaoException
     */
    @Override
    public List<News> read(String type, int count) throws NewsDaoException {
        List<News> newsList = new ArrayList<>(count);
        String uriPrefix;
        URI uri;
        if (Arrays.asList(SCIENCE_DAILY).contains(type.toLowerCase())) {
            uriPrefix = "https://www.sciencedaily.com/rss/";
            uri = URI.create(uriPrefix + type + ".xml");
        } else {
            uriPrefix = "https://www.gdacs.org/xml/";
            uri = URI.create(uriPrefix + "rss" + ".xml");
            type = "gdacs";
        }

        try {
            DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
            documentBuilderFactory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
            DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
            Document document = documentBuilder.parse(uri.toString());
            NodeList nodeList = document.getElementsByTagName(ITEM);

            if (nodeList != null) {
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Element element = (Element) nodeList.item(i);

                    String title = getText(element, TITLE);
                    String description = getText(element, DESCRIPTION);
                    URL link = new URL(getText(element, LINK));
                    Date pubDate = rfc822DateFormat.parse(getText(element, PUB_DATE));

                    News news = new News(type, title, description, link, pubDate);
                    newsList.add(news);

                    if (i >= count) break;
                }
            }
        } catch (IOException | ParserConfigurationException | SAXException | ParseException e) {
            throw new NewsDaoException("Could not get news from RSS feed", e);
        }

        return newsList;
    }

    /**
     * @param element
     * @param name
     *
     * @return
     */
    private String getText(Element element, String name) {
        return element.getElementsByTagName(name).item(0).getFirstChild()
            .getNodeValue();
    }

    /**
     * @param news
     */
    @Override
    public void create(News news) throws NewsDaoException {
        // Not required at the moment
    }

    /**
     * @param link
     */
    @Override
    public void update(URL link) throws NewsDaoException {
        // Not required at the moment
    }

    /**
     * @param link
     */
    @Override
    public void delete(URL link) throws NewsDaoException {
        // Not required at the moment
    }
}
