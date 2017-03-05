<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<% 
	 DateFormat timeFormat = new SimpleDateFormat("hh:mm a");
	 Calendar cal = Calendar.getInstance();
%>
<!-- current -->
<div class="col-md-6 col-sm-6">

	<div class="panel panel-default" style="
    min-height: 280px;
	">
		<div class="panel-heading">
			<h3 class="no-margin">
				<strong>Current Conditions</strong> <small
					class="text-warning hidden-xs"> <% out.print(timeFormat.format(cal.getTime())); %>
				</small>
			</h3>
		</div>
		<div class="panel-body">
			<div class="col-md-2 no-padding inline">
				<canvas class=<% out.print(request.getAttribute("curIcon")); %>
					width="82" height="156"></canvas>
			</div>

			<div class="col-md-10">
				<div class="temp">
					<% 
						out.print(request.getAttribute("curTemp"));
						if (session.getAttribute("units").equals("si"))
							out.print("<i class=\"wi wi-celsius\"></i>");
						else if (session.getAttribute("units").equals("us"))
							out.print("<i class=\"wi wi-fahrenheit\"></i>");
						else
							out.print("<i class=\"wi wi-degree\"></i>");
					%>
				</div>
				<%
					String curSummary = request.getAttribute("curSummary").toString();
					curSummary = curSummary.substring(1, curSummary.length() - 1);
				%>
				<strong><%= curSummary %></strong> <br>
				<%
					if (request.getAttribute("nowSummary")==null)
						out.print("<i class=\"wi wi-fw wi-na\"></i>");
					else
						out.print(request.getAttribute("nowSummary"));
				%>
				<br> <i class="wi wi-fw wi-humidity"></i>
				<% out.print(request.getAttribute("curHumidity")); %>% &nbsp;&nbsp;
				<br> <i class="wi wi-fw wi-cloudy"></i>
				<% out.print(request.getAttribute("curCloudCover")); %>% &nbsp;&nbsp;
				<i class="wi wi-fw wi-barometer"></i>
				<% out.print(request.getAttribute("curPressure")); %><br> <i
					class="wi wi-fw wi-strong-wind"></i>
				<% out.print(request.getAttribute("curWindSpeed")); %>
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
				&nbsp;&nbsp;&nbsp; <i class="fa fa-eye"></i>
				<%
					if ((Double)request.getAttribute("curVis")==-273)
						out.print("<i class=\"wi wi-fw wi-na\"></i>");
					else
						out.print(request.getAttribute("curVis") + " mi");
				%> 
				<br>

			</div>
		</div>
	</div>
	<!-- /panel -->


</div>
<!-- /current -->