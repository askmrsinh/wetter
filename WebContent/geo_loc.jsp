<%@page import="java.nio.charset.Charset"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.Reader"%>
<%@page import="com.eclipsesource.json.*"%>
<%@page import="org.json.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<%!
	private static String readAll(Reader rd) throws IOException {
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = rd.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}

	public static JSONObject readJsonFromUrl(String url) 
			throws IOException, JSONException {
		//System.setProperty("http.proxyHost", "proxy.tcs.com");
		//System.setProperty("http.proxyPort", "80");
		InputStream is = new URL(url).openStream();
		try {
			BufferedReader rd = new BufferedReader(new InputStreamReader(is,
					Charset.forName("UTF-8")));
			String jsonText = readAll(rd);
			JSONObject json = new JSONObject(jsonText);
			return json;
		} finally {
			is.close();
		}
	}

	public static String getJSON(String url) throws IOException, JSONException {
		System.out.println("\nThe encode url is: " + url);
		JSONObject json = readJsonFromUrl(url);
		return json.toString();
	}%>

<%
	double latitude, longitude;
	latitude = longitude = 0;

	System.out.println("\ngeo_loc search form submitted\n");
	
	if (request.getParameter("latitude_loc").length()>0 && request.getParameter("longitude_loc").length()>0){
		latitude = Double.parseDouble(request.getParameter("latitude_loc"));
		longitude = Double.parseDouble(request.getParameter("longitude_loc"));
	}
	
	session.setAttribute("latitude", latitude);
	session.setAttribute("longitude", longitude);
%>

<jsp:include page="resources/includes/api.jsp" />

<%
	String geocode = getJSON("http://maps.googleapis.com/maps/api/geocode/json?latlng="
			+ session.getAttribute("latitude")
			+ ","
			+ session.getAttribute("longitude") + "&sensor=false");
	JsonObject output = Json.parse(geocode).asObject();
	String status = output.get("status").asString();

	String locData, locCity, locState;
	locData = locCity = locState = "";

	if (status.equalsIgnoreCase("OK")) {
		JsonArray results = output.get("results").asArray();
		locData = results.get(0).asObject()
				.getString("formatted_address", "formatted_address");
		locCity = results.get(0).asObject().get("address_components")
				.asArray().get(3).asObject()
				.getString("long_name", "long_name");
		locState = results.get(0).asObject().get("address_components")
				.asArray().get(5).asObject()
				.getString("short_name", "short_name");
	}
	
	System.out.println("\ngeolocation detected: " + locCity + ", " + locState + ", " + locData);
%>

<!-- HEADER -->
<jsp:include page="resources/includes/head.jsp" />

<body onload="getLocation()">

	<!-- NAV BAR -->
	<jsp:include page="resources/includes/nav.jsp" />

	<div class="container">

		<div class="row">
			<%
				if (locCity.length() + locState.length() + locData.length()==0){
					out.print("<h4 class=\"bg-danger\">Unable to get Geolocation, please verify that you have browser support.</h4>");
				} else {
					out.print("<h3 class=\"ml-15 text-info\">" + locCity + ", " + locState);
					out.print("<small class=\"text-muted\"> " + locData + "</small>");
					out.print("</h3>");
				}
			%>
			<!-- CURRENT CONDITIONS -->
			<jsp:include page="resources/includes/part_current.jsp" />

			<!-- TODAY FORECAST -->
			<jsp:include page="resources/includes/part_today.jsp" />

		</div>
		<!-- /row -->

		<!-- HOURLY -->
		<jsp:include page="resources/includes/part_hourly.jsp" />

		<!-- WEEK FORECAST -->
		<jsp:include page="resources/includes/part_daily.jsp" />

	</div>
	<!-- /container -->


	<jsp:include page="resources/includes/footer.jsp" />


</body>
</html>