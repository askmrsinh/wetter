package com.ashessin.projects.wetter.controller;

import com.ashessin.projects.wetter.dao.GmapsDaoException;
import com.ashessin.projects.wetter.dao.GmapsDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "GmapsServlet", urlPatterns = "/gmaps")
public class GmapsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        double latitude = 23.03d;
        double longitude = 72.57d;
        String address = "Ahmedabad, Gujarat";

        if (req.getParameterMap().containsKey("latitude") &&
            req.getParameterMap().containsKey("longitude")) {
            try {
                latitude = Double.parseDouble(req.getParameter("latitude"));
                longitude = Double.parseDouble(req.getParameter("longitude"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else if (req.getParameterMap().containsKey("address")) {
            address = req.getParameter("address");
        }

        // TODO: Add condition
        try {
            GmapsDaoImpl gmapsDaoImpl = new GmapsDaoImpl();
            req.setAttribute("geocode_location", gmapsDaoImpl.read(latitude, longitude));
            req.setAttribute("geocode_address", gmapsDaoImpl.read(address));
            req.getRequestDispatcher("/gmaps.jsp").forward(req, resp);
        } catch (GmapsDaoException | ServletException | IOException e) {
            e.printStackTrace();
        }
    }
}
