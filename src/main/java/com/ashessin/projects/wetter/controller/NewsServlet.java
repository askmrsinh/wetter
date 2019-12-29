package com.ashessin.projects.wetter.controller;

import com.ashessin.projects.wetter.dao.NewsDaoException;
import com.ashessin.projects.wetter.dao.NewsDaoRssImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "NewsServlet", urlPatterns = "/news")
public class NewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        String type = "";

        if (req.getParameterMap().containsKey("type"))
            type = req.getParameter("type");

        try {
            NewsDaoRssImpl newsDaoRssImpl = new NewsDaoRssImpl();
            req.setAttribute("news", newsDaoRssImpl.read(type, 10));
            req.getRequestDispatcher("/news.jsp").forward(req, resp);
        } catch (NewsDaoException | ServletException | IOException e) {
            e.printStackTrace();
        }
    }
}
