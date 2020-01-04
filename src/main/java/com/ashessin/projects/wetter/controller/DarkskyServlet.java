package com.ashessin.projects.wetter.controller;

import com.ashessin.projects.wetter.dao.DarkskyDaoException;
import com.ashessin.projects.wetter.dao.DarkskyDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DarkskyServlet", urlPatterns = "/darksky")
public class DarkskyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        double latitude = 23.03d;
        double longitude = 72.57d;

        if (req.getParameterMap().containsKey("latitude") &&
            req.getParameterMap().containsKey("longitude")) {
            try {
                latitude = Double.parseDouble(req.getParameter("latitude"));
                longitude = Double.parseDouble(req.getParameter("longitude"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        try {
            DarkskyDaoImpl darkskyDaoImpl = new DarkskyDaoImpl();
            req.setAttribute("forecast", darkskyDaoImpl.read(latitude, longitude));
            req.getRequestDispatcher("/darksky.jsp").forward(req, resp);
        } catch (DarkskyDaoException | ServletException | IOException e) {
            e.printStackTrace();
        }
    }
}
