<%@page import="java.text.DecimalFormat"%>
<%@page import="java.net.URLEncoder"%>
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

	public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
		//System.setProperty("http.proxyHost", "proxy.tcs.com");
		//System.setProperty("http.proxyPort", "80");
		InputStream is = new URL(url).openStream();
		try {
			BufferedReader rd = new BufferedReader(
					new InputStreamReader(is, Charset.forName("UTF-8")));
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
	}
%>

<%
	String City = "";
	String State = "";
	String Country = "";

	System.out.println("\ngeo_lookup search form submitted\n");
	City = request.getParameter("locality");
	State = request.getParameter("administrative_area_level_1");
	Country = request.getParameter("country");

	String q = "";
	if (City != null && State != null && Country != null) {
		q = City + "+" + State + "+" + Country;
	} else if (City == null && State != null && Country != null) {
		q = State + "+" + Country;
	} else if (City == null && State == null && Country != null) {
		q = Country;
	}

	String url = "http://maps.googleapis.com/maps/api/geocode/json?address="
			+ URLEncoder.encode(q, "UTF-8");

	String geocode = getJSON(url);
	JsonObject output = Json.parse(geocode).asObject();
	String status = output.get("status").asString();

	DecimalFormat df8 = new DecimalFormat(".########");
	
	String locData = "";
	double latitude, longitude;
	latitude = longitude = 0;

	if (status.equalsIgnoreCase("OK")) {
		JsonArray results = output.get("results").asArray();
		locData = results.get(0).asObject()
				.getString("formatted_address", "formatted_address");
		latitude = results.get(0).asObject().get("geometry").asObject()
				.get("location").asObject().getDouble("lat", 0);
		longitude = results.get(0).asObject().get("geometry").asObject()
				.get("location").asObject().getDouble("lng", 0);
	}

	session.setAttribute("latitude", df8.format(latitude));
	session.setAttribute("longitude", df8.format(longitude));
%>

<jsp:include page="resources/includes/api.jsp" />

<!-- HEADER -->
<jsp:include page="resources/includes/head.jsp" />

<body onload="getLocation()">

	<!-- NAV BAR -->
	<jsp:include page="resources/includes/nav.jsp" />

	<div class="container">

		<div class="row">
			<%
				String[] locDataArray = locData.split(",");
				if (locDataArray.length == 3){
					out.print("<h3 class=\"ml-15 text-info\">" + locDataArray[0]);
					out.print("<small class=\"text-muted\">, "+ locDataArray[1] + ","+ locDataArray[2] +"</small>");
					out.print("</h3>");
				} else if (locDataArray.length == 2){
					out.print("<h3 class=\"ml-15 text-info\">" + locDataArray[0]);
					out.print("<small class=\"text-muted\">, "+ locDataArray[1]  +"</small>");
					out.print("</h3>");
				} else {
					out.print("<h3 class=\"ml-15 text-info\">" + locDataArray[0]);
					out.print("<small class=\"text-muted\"></small>");
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