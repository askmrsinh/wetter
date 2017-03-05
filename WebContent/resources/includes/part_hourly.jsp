<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="com.github.dvdme.ForecastIOLib.FIOHourly"%>
<div class="row">
	<h4 class="ml-15">Next Few Hours</h4>

	<%
      FIOHourly hourlyCond = (FIOHourly) request.getAttribute("hourlyCond");
    
      int hi = 1;
    
      long hTime = 0;
      String hSummary, hIcon, hPrecipType = "";
      double hPrecipProb, hTemp, hClouds = -273;
      
      for (int hour=0; hour < hourlyCond.hours(); hour++){
        hTime = hourlyCond.getHour(hour).timestamp();
        hSummary = hourlyCond.getHour(hour).summary();
        hIcon = hourlyCond.getHour(hour).icon();
        hPrecipProb = Math.round((hourlyCond.getHour(hour).precipProbability())*100);
          if (hourlyCond.getHour(hour).precipType()!=null) {
            hPrecipType = hourlyCond.getHour(hour).precipType();
          } 
        hTemp = Math.round(hourlyCond.getHour(hour).temperature());
        hClouds = Math.round(hourlyCond.getHour(hour).cloudCover()*100);
        
        Date dateFormatUnix = new Date(hTime*1000L);
	    	SimpleDateFormat sdUnix = new SimpleDateFormat("ha");
	    	String hTimeString = sdUnix.format(dateFormatUnix);

        out.print("<div class=\"col-md-2 col-xs-6\">");
        	out.print("<div class=\"panel panel-default\">");
        		out.print("<div class=\"panel-heading\" style=\"font-size: 14px;\"><div class=\"text-primary inline fs20\">" + hTemp + "<i class=\"wi wi-degrees\"></i> &nbsp; <canvas class=" + hIcon + " width=\"25\" height=\"25\"></canvas></div>" + hTimeString + "</div>");
        	out.print("<div class=\"panel-body hourly-box\">");

                // echo '<canvas class="'.$hIcon.'" width="32" height="32"></canvas>';
                out.print(hSummary.substring(1, hSummary.length()-1));
                out.print("<br>");
                  if (hPrecipType != null) {
                	  out.print("<i class=\"wi wi-fw wi-umbrella\"></i> " + hPrecipProb + "% " + hPrecipType.substring(1, hPrecipType.length()-1));
                  } else {
                	  out.print("<i class=\"wi wi-fw wi-umbrella\"></i> " + hPrecipProb +"% ");
                  }
                  out.print("<br> <i class=\"wi wi-fw wi-cloudy\"></i> " + hClouds + "%");

            out.print("</div>");
          out.print("</div>");
        out.print("</div>");
      if (hi++ == 6) break; 
      }

    %>

</div>
<!-- /HOURLY -->