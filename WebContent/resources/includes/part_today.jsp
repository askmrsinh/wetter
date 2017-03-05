<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="com.github.dvdme.ForecastIOLib.FIODaily"%>
<div class="col-md-6 col-sm-6">
	<%
  	FIODaily todayCond = (FIODaily) request.getAttribute("dailyCond");
  	
  	int ti = 1;
  	
  	long tTime = -273;
  	String tSummary, tIcon, tPrecipType, tSunRise, tSunSet;
  	double tPrecipProb, tTempHigh, tTempLow, tClouds, tHumidity, tWindSpeed;
  	
  	tSummary = tIcon = tPrecipType = tSunRise = tSunSet = "";
  	tPrecipProb = tTempHigh = tTempLow = tClouds = tHumidity = tWindSpeed = -273;
  	
  	for (int i=0; i < todayCond.days(); i++){
  		tTime = todayCond.getDay(i).timestamp();
        tSummary = todayCond.getDay(i).summary();
        tIcon = todayCond.getDay(i).icon();
        tPrecipProb = Math.round((todayCond.getDay(i).precipProbability())*100);
          if (todayCond.getDay(i).precipType() != null) {
            tPrecipType = todayCond.getDay(i).precipType();
          } 
        tTempHigh = Math.round(todayCond.getDay(i).temperatureMax());
        tTempLow = Math.round(todayCond.getDay(i).temperatureMin());
        tClouds = Math.round((todayCond.getDay(i).cloudCover())*100);
        tHumidity = Math.round((todayCond.getDay(i).humidity())*100);
        tSunRise = todayCond.getDay(i).sunriseTime();
        tSunSet = todayCond.getDay(i).sunsetTime();
        tWindSpeed = Math.round(todayCond.getDay(i).windSpeed());
      if (ti++ == 1) break;  
      }

  	  Date dateFormatUnix = new Date(tTime*1000L);
  	  SimpleDateFormat sdUnix = new SimpleDateFormat("EEE, MMM dd");
  	  String tTimeString = sdUnix.format(dateFormatUnix);
  	  
  	  SimpleDateFormat sdSunTime = new SimpleDateFormat("HH:mm:ss");
      Date dateSunRise = sdSunTime.parse(tSunRise);
      String tSunRiseString = new SimpleDateFormat("h:mm a").format(dateSunRise);
      Date dateSunSet = sdSunTime.parse(tSunSet);
      String tSunSetString = new SimpleDateFormat("h:mm a").format(dateSunSet);
  	%>

	<div class="panel panel-default" style="
    min-height: 280px;
	">
		<div class="panel-heading">
			<h3 class="no-margin">
				<strong>Today's Forecast</strong> <small
					class="text-warning hidden-sm hidden-xs"><%= tTimeString %></small>
			</h3>
		</div>
		<div class="panel-body">

			<div class="col-md-2 no-padding">
				<canvas class=<%= tIcon %> width="82" height="156"></canvas>
			</div>
			<div class="text-primary inline fs20">
				<b><%= tTempHigh %></b><i class="wi wi-degrees"></i>&nbsp;&nbsp;
			</div>
			<div class="text-info inline fs20">
				<b><%= tTempLow %></b><i class="wi wi-degrees"></i>
			</div>
			<p>
				<strong><%= tSummary.substring(1, tSummary.length()-1) %></strong> <br>
				<% 
                 if (tPrecipType == null) {
                	out.print("<i class=\"wi wi-fw wi-umbrella\"></i> " + tPrecipProb + "% "+tPrecipType);
                 } else {
               	 	out.print("<i class=\"wi wi-fw wi-umbrella\"></i> " + tPrecipProb + "% ");
                 }
               %>
				&nbsp;&nbsp; <i class="wi wi-fw wi-cloudy"></i>
				<%= tClouds %>% &nbsp; <i class="wi wi-fw wi-humidity"></i>
				<%= tHumidity %>% <br> <i class="wi wi-fw wi-strong-wind"></i>
				<%= tWindSpeed %>
				mph
				<%
                            if ((Double)request.getAttribute("curWindBearing")>338 && (Double)request.getAttribute("curWindBearing")<23)
                              out.print("<i class=\"wi wi-fw wi-direction-down\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>23 && (Double)request.getAttribute("curWindBearing")<68)
                              out.print("<i class=\"wi wi-fw wi-direction-down-right\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>68 && (Double)request.getAttribute("curWindBearing")<113)
                              out.print("<i class=\"wi wi-fw wi-direction-left\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>113 && (Double)request.getAttribute("curWindBearing")<158)
                              out.print("<i class=\"wi wi-fw wi-direction-up-left\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>158 && (Double)request.getAttribute("curWindBearing")<203)
                              out.print("<i class=\"wi wi-fw wi-direction-up\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>203 && (Double)request.getAttribute("curWindBearing")<248)
                              out.print("<i class=\"wi wi-fw wi-direction-up-right\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>248 && (Double)request.getAttribute("curWindBearing")<293)
                              out.print("<i class=\"wi wi-fw wi-direction-right\"></i>");
                            if ((Double)request.getAttribute("curWindBearing")>293 && (Double)request.getAttribute("curWindBearing")<338)
                              out.print("<i class=\"wi wi-fw wi-direction-down-right\"></i>");
                         %>
				&nbsp;&nbsp; <i class="wi wi-fw wi-sunrise"></i>
				<%= tSunRiseString %>
				&nbsp; <i class="wi wi-fw wi-sunset"></i>
				<%= tSunSetString %>

			</p>
		</div>
	</div>

</div>
<!-- /col-md -->