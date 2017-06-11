<%@page
	import="java.io.InputStreamReader, java.io.BufferedReader, java.io.InputStream, java.io.IOException, java.io.Reader, java.text.DecimalFormat, java.net.URL, java.net.URLEncoder, java.nio.charset.Charset, com.eclipsesource.json.*, org.json.*,com.github.dvdme.ForecastIOLib.*"%>

<%
	String api_key_GoogleMapsJavaScript = "INSERT_YOUR_KEY";
	String api_key_OpenWeatherMap       = "INSERT_YOUR_KEY";
	String api_key_DarkSky              = "INSERT_YOUR_KEY";

	session.setAttribute("api_key_GoogleMapsJavaScript",
			api_key_GoogleMapsJavaScript);
	session.setAttribute("api_key_OpenWeatherMap",
			api_key_OpenWeatherMap);
	session.setAttribute("api_key_DarkSky",
			api_key_DarkSky);
%>

<%!private static String readAll(Reader rd) throws IOException {
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
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = readAll(rd);
			JSONObject json = new JSONObject(jsonText);
			return json;
		} finally {
			is.close();
		}
	}

	public static String getJSON(String url) throws IOException, JSONException {
		System.out.println("\nThe encoded url is: " + url);
		JSONObject json = readJsonFromUrl(url);
		return json.toString();
	}%>


<%
	Double latitude = 19.0356826d;
	Double longitude = 72.9112641d;

	String uri = request.getRequestURI();
	String pageName = uri.substring(uri.lastIndexOf("/") + 1);

	if (pageName.equalsIgnoreCase("geo_loc.jsp") || pageName.equalsIgnoreCase("geo_lookup.jsp")) {

		String geocode = null;

		String Data, City, State, Country;

		switch (pageName) {
		case "geo_loc.jsp":
			System.out.println("\ngeo_loc form submitted\n");
			DecimalFormat df8 = new DecimalFormat(".############");
			if (request.getParameter("latitude_loc") != null
					&& request.getParameter("latitude_loc").length() > 0
					&& request.getParameter("longitude_loc") != null
					&& request.getParameter("longitude_loc").length() > 0) {
				latitude = Double.parseDouble(request.getParameter("latitude_loc"));
				longitude = Double.parseDouble(request.getParameter("longitude_loc"));
			} else {
				latitude = 0.0d;
				longitude = 0.0d;
			}
			geocode = getJSON("https://maps.googleapis.com/maps/api/geocode/json?latlng=" + df8.format(latitude)
					+ "," + df8.format(longitude) + "&sensor=false");
			break;
		case "geo_lookup.jsp":
			System.out.println("\ngeo_lookup form submitted\n");
			String q = "";
			// https://www.mjt.me.uk/posts/falsehoods-programmers-believe-about-addresses/
			// https://developers.google.com/places/supported_types#table2
			City = request.getParameter("locality");
			State = request.getParameter("administrative_area_level_1");
			Country = request.getParameter("country");
			if (City != null && State != null && Country != null) {
				q = City + "+" + State + "+" + Country;
			} else if (City == null && State != null && Country != null) {
				q = State + "+" + Country;
			} else if (City == null && State == null && Country != null) {
				q = Country;
			}
			geocode = getJSON("https://maps.googleapis.com/maps/api/geocode/json?address="
					+ URLEncoder.encode(q, "UTF-8"));
			break;
		}

		JsonObject output = Json.parse(geocode).asObject();
		String status = output.get("status").asString();

		if (status.equalsIgnoreCase("OK")) {
			JsonArray results = output.get("results").asArray();
			Data = results.get(0).asObject().getString("formatted_address", "formatted_address_default");
			System.out.println(Data);
			request.setAttribute("Data", Data);
			if (pageName.equalsIgnoreCase("geo_loc.jsp")) {
				State = results.get(0).asObject().get("address_components").asArray().get(5).asObject()
						.getString("short_name", "short_name_default");
				request.setAttribute("State", State);
				City = results.get(0).asObject().get("address_components").asArray().get(3).asObject()
						.getString("long_name", "long_name_default");
				request.setAttribute("City", City);
			}
			latitude = results.get(0).asObject().get("geometry").asObject().get("location").asObject()
					.getDouble("lat", latitude);
			longitude = results.get(0).asObject().get("geometry").asObject().get("location").asObject()
					.getDouble("lng", longitude);
		}

		String request_units = "auto";

		ForecastIO fio = new ForecastIO(api_key_DarkSky);
		fio.setUnits(request_units);
		//fio.setHTTPProxy("proxy.tcs.com", 80);

		System.out.println("\n\n" + fio.getUrl(latitude.toString(), longitude.toString()));

		String curTime, curSummary, curIcon, curPrecipType, curSunRise, curSunSet = "";
		double curPrecipProb, curTemp, curFeelsLike, curDewPoint, curWindBearing, curTempHigh, curTempLow,
				curCloudCover, curPressure, curClouds, curHumidity, curWindSpeed, curVis = -273;

		try {
			if (fio.getForecast(latitude.toString(), longitude.toString())) {
				String timezone = fio.getTimezone();
				String offset = fio.offset();
				String units = fio.getFlags().getString("units", "units");

				System.out.println("latitude: " + fio.getLatitude());
				System.out.println("longitude: " + fio.getLongitude());
				System.out.println("timezone: " + timezone);
				System.out.println("offset: " + offset);
				System.out.println("units: " + units);

				session.setAttribute("units", units);

				// Current Conditions
				FIOCurrently currently = new FIOCurrently(fio);

				curTime = currently.get().time();
				request.setAttribute("curTime", curTime);
				System.out.println("curTime :" + curTime);

				curSummary = currently.get().summary();
				request.setAttribute("curSummary", curSummary);
				System.out.println("curSummary :" + curSummary);

				curIcon = currently.get().icon();
				request.setAttribute("curIcon", curIcon);
				System.out.println("curIcon :" + curIcon);

				curPrecipProb = Math.round(currently.get().precipProbability() * 100);
				request.setAttribute("curPrecipProb", curPrecipProb);
				System.out.println("curPrecipProb :" + curPrecipProb);

				if (currently.get().precipType() != null) {
					curPrecipType = currently.get().precipType();
					request.setAttribute("curPrecipType", curPrecipType);
					System.out.println("curPrecipType :" + curPrecipType);
				}

				curTemp = Math.round(currently.get().temperature());
				request.setAttribute("curTemp", curTemp);
				System.out.println("curTemp :" + curTemp);

				curFeelsLike = Math.round(currently.get().apparentTemperature());
				request.setAttribute("curFeelsLike", curFeelsLike);
				System.out.println("curFeelsLike :" + curFeelsLike);

				curHumidity = Math.round(currently.get().humidity() * 100);
				request.setAttribute("curHumidity", curHumidity);
				System.out.println("curHumidity :" + curHumidity);

				curDewPoint = currently.get().dewPoint();
				request.setAttribute("curDewPoint", curDewPoint);
				System.out.println("curDewPoint :" + curDewPoint);

				curWindSpeed = currently.get().windSpeed();
				request.setAttribute("curWindSpeed", curWindSpeed);
				System.out.println("curWindSpeed :" + curWindSpeed);

				curWindBearing = currently.get().windBearing();
				request.setAttribute("curWindBearing", curWindBearing);
				System.out.println("curWindBearing :" + curWindBearing);

				curCloudCover = Math.round(currently.get().cloudCover() * 100);
				request.setAttribute("curCloudCover", curCloudCover);
				System.out.println("curCloudCover :" + curCloudCover);

				curPressure = Math.round(currently.get().pressure() * 0.0295301);
				request.setAttribute("curPressure", curPressure);
				System.out.println("curPressure :" + curPressure);

				if (currently.get().visibility() != null) {
					curVis = Math.round(currently.get().visibility());
				}
				request.setAttribute("curVis", curVis);
				System.out.println("curVis :" + curVis);

				// Minutely Conditions
				FIOMinutely minutely = new FIOMinutely(fio);
				request.setAttribute("minutelyCond", minutely);

				if (minutely.minutes() < 0) {
					System.out.println("\n\nNo minutely data.\n");
				} else {
					System.out.println("\n\nMinutely\n");

					// 			for (int i = 0; i < minutely.minutes(); i++) {
					// 				String[] m = minutely.getMinute(i).getFieldsArray();
					// 				System.out.println("Minute #" + (i + 1));
					// 				for (int j = 0; j < m.length; j++)
					// 					System.out.println(
					// 							m[j] + ": " + minutely.getMinute(i).getByKey(m[j]));
					// 			}
					String nowSummary = minutely.getSummary();
					request.setAttribute("nowSummary", nowSummary);
					System.out.println("nowSummary: " + nowSummary);

					String nowIcon = minutely.getIcon();
					request.setAttribute("nowIcon", nowIcon);
					System.out.println("nowIcon: " + nowIcon);
				}

				// Hourly Forecast
				FIOHourly hourly = new FIOHourly(fio);
				request.setAttribute("hourlyCond", hourly);

				if (hourly.hours() < 0) {
					System.out.println("\n\nNo hourly data.\n");
				} else {
					System.out.println("\n\nHourly\n");

					// 			for (int i = 0; i < hourly.hours(); i++) {
					// 				String[] h = hourly.getHour(i).getFieldsArray();
					// 				System.out.println("Hour #" + (i + 1));
					// 				for (int j = 0; j < h.length; j++)
					// 					System.out.println(
					// 							h[j] + ": " + hourly.getHour(i).getByKey(h[j]));
					// 				System.out.println("\n");
					// 			}
					String hourlySummary = hourly.getSummary();
					request.setAttribute("hourlySummary", hourlySummary);
					System.out.println("hourlySummary: " + hourlySummary);

					String hourlyIcon = hourly.getIcon();
					request.setAttribute("hourlyIcon", hourlyIcon);
					System.out.println("hourlyIcon: " + hourlyIcon);

					//$hourlyCond[]
				}

				// Daily Forecast
				FIODaily daily = new FIODaily(fio);
				request.setAttribute("dailyCond", daily);

				if (daily.days() < 0) {
					System.out.println("\n\nNo daily data.\n");
				} else {
					System.out.println("\n\nDaily\n");

					// 			for (int i = 0; i < daily.days(); i++) {
					// 				String[] h = daily.getDay(i).getFieldsArray();
					// 				System.out.println("Day #" + (i + 1));
					// 				for (int j = 0; j < h.length; j++)
					// 					System.out.println(
					// 							h[j] + ": " + daily.getDay(i).getByKey(h[j]));
					// 				System.out.println("\n");
					// 			}
					String dailySummary = daily.getSummary();
					request.setAttribute("dailySummary", dailySummary);
					System.out.println("dailySummary: " + dailySummary);

					String dailyIcon = daily.getIcon();
					request.setAttribute("dailyIcon", dailyIcon);
					System.out.println("dailyIcon: " + dailyIcon);

					//$dailyCond[]
				}
			}
		} catch (Exception e) {
			System.err.println("one or more values are missing for this location");
		}
	}
%>