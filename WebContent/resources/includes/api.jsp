<%@page import="com.github.dvdme.ForecastIOLib.*"%>

<%
	String api_key_GoogleMapsJavaScript = "INSERT_YOUR_KEY";
	String api_key_OpenWeatherMap       = "INSERT_YOUR_KEY";
	String api_key_DarkSky              = "INSERT_YOUR_KEY";

	session.setAttribute("api_key_GoogleMapsJavaScript",
			api_key_GoogleMapsJavaScript);
	session.setAttribute("api_key_OpenWeatherMap",
			api_key_OpenWeatherMap);
	session.setAttribute("api_key_DarkSky", api_key_DarkSky);

	//String units = "auto";

	if (session.getAttribute("latitude") == null
			&& session.getAttribute("longitude") == null) {
		session.setAttribute("latitude", "19.0356826");
		session.setAttribute("longitude", "72.9112641");
	}

	String latitude = session.getAttribute("latitude").toString();
	String longitude = session.getAttribute("longitude").toString();

	String uri = request.getRequestURI();
	String pageName = uri.substring(uri.lastIndexOf("/") + 1);

	if (pageName.equalsIgnoreCase("geo_loc.jsp")
			|| pageName.equalsIgnoreCase("geo_lookup.jsp")) {
		ForecastIO fio = new ForecastIO(api_key_DarkSky);
		fio.setUnits(ForecastIO.UNITS_AUTO);
		//fio.setHTTPProxy("proxy.tcs.com", 80);

		System.out.println("\n\n" + fio.getUrl(latitude, longitude));

		String curTime, curSummary, curIcon, curPrecipType, curSunRise, curSunSet = "";
		double curPrecipProb, curTemp, curFeelsLike, curDewPoint, curWindBearing, curTempHigh, curTempLow, curCloudCover, curPressure, curClouds, curHumidity, curWindSpeed, curVis = -273;

		try {
			if (fio.getForecast(latitude, longitude)) {
				String timezone = fio.getTimezone();
				String offset = fio.offset();
				String units = fio.getFlags().getString("units",
						"units");

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

				curPrecipProb = Math.round(currently.get()
						.precipProbability() * 100);
				request.setAttribute("curPrecipProb", curPrecipProb);
				System.out.println("curPrecipProb :" + curPrecipProb);

				if (currently.get().precipType() != null) {
					curPrecipType = currently.get().precipType();
					request.setAttribute("curPrecipType", curPrecipType);
					System.out.println("curPrecipType :"
							+ curPrecipType);
				}

				curTemp = Math.round(currently.get().temperature());
				request.setAttribute("curTemp", curTemp);
				System.out.println("curTemp :" + curTemp);

				curFeelsLike = Math.round(currently.get()
						.apparentTemperature());
				request.setAttribute("curFeelsLike", curFeelsLike);
				System.out.println("curFeelsLike :" + curFeelsLike);

				curHumidity = Math
						.round(currently.get().humidity() * 100);
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

				curCloudCover = Math
						.round(currently.get().cloudCover() * 100);
				request.setAttribute("curCloudCover", curCloudCover);
				System.out.println("curCloudCover :" + curCloudCover);

				curPressure = Math
						.round(currently.get().pressure() * 0.0295301);
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
					System.out.println("hourlySummary: "
							+ hourlySummary);

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
			System.err
					.println("one or more values are missing for this location");
		}
	}
%>