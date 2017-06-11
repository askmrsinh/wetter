<%@page import="org.w3c.dom.Element"%>
<%@page import="org.xml.sax.SAXException"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.xml.parsers.ParserConfigurationException"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<jsp:include page="resources/includes/api.jsp" />

<html>

<jsp:include page="resources/includes/head.jsp" />
<body onload="getLocation()">
	<jsp:include page="resources/includes/nav.jsp" />
	<%!private static NodeList getNews(String url) {
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(url);

			NodeList listItem = doc.getElementsByTagName("item");

			return listItem;
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}%>

	<%
		String newsType = request.getParameter("type");
	%>

	<div class="container news">
		<div class="row">
			<%
				String rssURI = "http://www.gdacs.org/xml/rss.xml";

				if (newsType.equalsIgnoreCase("Disaster_Alerts")) {
					rssURI = "http://www.gdacs.org/xml/rss.xml";
					out.print("<h3 class=\"ml-15 text-info\">Disaster Alerts Feeds</h3>");
				}
				if (newsType.equalsIgnoreCase("Environment")) {
					rssURI = "https://www.sciencedaily.com/rss/top/environment.xml";
					out.print("<h3 class=\"ml-15 text-info\">Environment New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Pollution")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/pollution.xml";
					out.print("<h3 class=\"ml-15 text-info\">Pollution New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Oil_Spills")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/oil_spills.xml";
					out.print("<h3 class=\"ml-15 text-info\">Oil Spills New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Renewable_Energy")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/renewable_energy.xml";
					out.print("<h3 class=\"ml-15 text-info\">Renewable Energy New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Recycling_And_Waste")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/recycling_and_waste.xml";
					out.print("<h3 class=\"ml-15 text-info\">Recycling and Waste New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Global_Warming")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/global_warming.xml";
					out.print("<h3 class=\"ml-15 text-info\">Global Warming New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Ozone_Holes")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/ozone_holes.xml";
					out.print("<h3 class=\"ml-15 text-info\">Ozone Holes New Feed</h3>");
				}
				if (newsType.equalsIgnoreCase("Air_Quality")) {
					rssURI = "https://www.sciencedaily.com/rss/earth_climate/air_quality.xml";
					out.print("<h3 class=\"ml-15 text-info\">Air Quality New Feed</h3>");
				}

				out.print("<div class=\"col-md-12\">");
				out.print("<p class=\"text-muted\"><i>Source: " + rssURI + "</i></p>");

				NodeList listItem = getNews(rssURI);
				
				if (listItem != null) {

					System.out.println("There are " + listItem.getLength() + " items");
	
					for (int i = 0; i < listItem.getLength(); i++) {
						Element item = (Element) listItem.item(i);
	
						String newsTitle = item.getElementsByTagName("title").item(0).getFirstChild().getNodeValue();
						String newsDescription = item.getElementsByTagName("description").item(0).getFirstChild()
								.getNodeValue();
						String newsLink = item.getElementsByTagName("link").item(0).getFirstChild().getNodeValue();
						String pubDate = item.getElementsByTagName("pubDate").item(0).getFirstChild().getNodeValue();
			%>
			<div class="list-group">
				<a href="<%=newsLink%>" target="_blank" class="list-group-item">
					<h6 class="list-group-item-heading truncate-heading"><%=newsTitle%></h6>
					<p class="small"><%=pubDate%></p>
					<p class="list-group-item-text text-justify truncate-text"><%=newsDescription%></p>
				</a>
			</div>
			<%
					if (i >= 10)
							break;
					}
				} else {
			%>
			<div class="list-group">
				<a href=# class="list-group-item">
					<h6 class="list-group-item-heading truncate-heading">No News Updates</h6>
				</a>
			</div>
			<%
				}
				out.print("</div>");
			%>
		</div>
	</div>
	<jsp:include page="resources/includes/footer.jsp" />
</body>

</html>