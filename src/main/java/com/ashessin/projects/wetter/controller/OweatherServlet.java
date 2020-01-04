package com.ashessin.projects.wetter.controller;

import com.ashessin.projects.wetter.dao.OweatherDaoException;
import com.ashessin.projects.wetter.dao.OweatherDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.stream.Stream;

@WebServlet(name = "OweatherServlet", urlPatterns = "/oweather")
public class OweatherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        double[] rectangle = {72.70d, 23.13d, 72.45d, 22.90d};
        int zoom = 10;

        if (req.getParameterMap().containsKey("rectangle") &&
            req.getParameterMap().containsKey("zoom")) {
            try {
                rectangle = Stream.of(req.getParameter("rectangle").split(","))
                    .mapToDouble(Double::parseDouble)
                    .toArray();
                zoom = Integer.parseInt(req.getParameter("zoom"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        try {
            OweatherDaoImpl oweatherDaoImpl = new OweatherDaoImpl();
            req.setAttribute("forecasts", oweatherDaoImpl.read(rectangle, zoom));
            req.getRequestDispatcher("/oweather.jsp").forward(req, resp);
        } catch (OweatherDaoException | ServletException | IOException e) {
            e.printStackTrace();
        }

    }
}
