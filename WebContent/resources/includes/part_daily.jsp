<!-- daily forecast -->
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="com.github.dvdme.ForecastIOLib.FIODaily"%>
<div class="row">
	<h3 class="ml-15">
		Week Forecast <small class="text-info hidden-xs"><%=  request.getAttribute("dailySummary") %></small>
	</h3>

	<%
      	FIODaily dailyCond = (FIODaily) request.getAttribute("dailyCond");
      
        int wi = 0;
        int count = 0;
        
        long wTime = -273;
        String wSummary, wIcon, wPrecipType, wSunRise, wSunSet = "";
        double wPrecipProb, wTempHigh, wTempLow, wClouds, wHumidity, wWindSpeed = -273;
        
        for (int day=0; day < dailyCond.days(); day++){
          if (count++ == 0) continue;
          
	          wTime = dailyCond.getDay(day).timestamp();
	          wSummary = dailyCond.getDay(day).summary();
	          wIcon = dailyCond.getDay(day).icon();
	          wPrecipProb = Math.round((dailyCond.getDay(day).precipProbability())*100);
	          if (dailyCond.getDay(day).precipType() != null) {
	            wPrecipType = dailyCond.getDay(day).precipType();
	          } 
	          wTempHigh = Math.round(dailyCond.getDay(day).temperatureMax());
	          wTempLow = Math.round(dailyCond.getDay(day).temperatureMin());
	          wClouds = Math.round((dailyCond.getDay(day).cloudCover())*100);
	          wHumidity = Math.round((dailyCond.getDay(day).humidity())*100);
	          wSunRise = dailyCond.getDay(day).sunriseTime();
	          wSunSet = dailyCond.getDay(day).sunsetTime();
	          wWindSpeed = Math.round(dailyCond.getDay(day).windSpeed());
	          
	          Date dateFormatUnix = new Date(wTime*1000L);
	      	  SimpleDateFormat sdUnix = new SimpleDateFormat("EEE, MMM dd");
	      	  String wTimeString = sdUnix.format(dateFormatUnix);
	          
	          SimpleDateFormat sdSunTime = new SimpleDateFormat("HH:mm:ss");
	          Date dateSunRise = sdSunTime.parse(wSunRise);
	          String wSunRiseString = new SimpleDateFormat("h:mm a").format(dateSunRise);
	          Date dateSunSet = sdSunTime.parse(wSunSet);
	          String wSunSetString = new SimpleDateFormat("h:mm a").format(dateSunSet);

			      out.print("<div class=\"col-lg-4 col-md-6 col-sm-6\">");
			      	out.print("<div class=\"panel panel-default\">");
			      		out.print("<div class=\"panel-heading\"><div class=\"text-warning\"><strong>" + wTimeString + "</strong></div></div>");
			      	out.print("<div class=\"panel-body truncate\">");
		
			      				out.print("<canvas class=" + wIcon + " width=\"40\" height=\"80\"></canvas>");
			      				out.print("<strong>" + wSummary.substring(1, wSummary.length()-1) + "</strong>");
			      			out.print("<br>");
			      			out.print("<div class=\"text-primary inline fs20\"><b>" + wTempHigh + "</b><i class=\"wi wi-degrees\"></i> </div> &nbsp; <div class=\"text-info inline fs20\"><b>" + wTempLow + "</b><i class=\"wi wi-degrees\"></i> </div>");
			      		out.print("&nbsp; <i class=\"wi wi-fw wi-umbrella\"></i> " + wPrecipProb + "% &nbsp;&nbsp; <i class=\"wi wi-fw wi-cloudy\"></i>" + wClouds + "%");
			      		out.print("<br>");
			      		out.print("<small><i class=\"wi wi-fw wi-sunrise\"></i> " + wSunRiseString + " &nbsp; <i class=\"wi wi-fw wi-sunset\"></i>" + wSunSetString + "</small>"); 
		
			      	out.print("</div>");
			      	out.print("</div>");
			      out.print("</div>");

          wi++;
          if (wi%3 == 0) out.print("</div><div class=\"row\">");
        }
      %>

</div>
<!-- /daily forecast -->
