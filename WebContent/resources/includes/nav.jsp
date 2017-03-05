<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<% 
	 DateFormat dateFormat = new SimpleDateFormat("hh:mm a | E, MMMM d, YYYY");
	 Calendar cal = Calendar.getInstance();
	 System.out.println("\n" + dateFormat.format(cal.getTime()) + "\n");
	 
	 String uri = request.getRequestURI();
	 String pageName = uri.substring(uri.lastIndexOf("/") + 1);
	 if (pageName.equalsIgnoreCase("map.jsp"))
	 	pageName = uri.substring(uri.lastIndexOf("/") + 1) + "?layer=" + request.getParameter("layer");
	 System.out.println(pageName);
%>

<header>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp">
					<!-- <img alt="Brand" src="public/favicons/mstile-150x150.png" width="50" height="50"> -->Wetter
        		</a>
				<a class="navbar-brand " href=""></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li
						class="${pageContext.request.requestURI eq '/wetter/geo_loc.jsp' ? ' active' : ''}"><a
						href="geo_loc.jsp"
						onclick="document.getElementById('loc').submit(); return false;"><i
							class="fa fa-location-arrow"></i></a></li>
					<li
						class="${pageContext.request.requestURI eq '/wetter/stats.jsp' ? ' active' : ''}"><a
						href="stats.jsp">Stats<span class="sr-only">(current)</span></a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Maps <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li
								class="${pageContext.request.requestURI eq '/wetter/index.jsp' ? ' active' : ''}"><a
								href="index.jsp">Home</a></li>
							<li role="separator" class="divider"></li>
							<li class="dropdown-header">Layers</li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Clouds")) out.print("active");%>"><a
								href="map.jsp?layer=Clouds">Clouds</a></li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Precipitation")) out.print("active");%>"><a
								href="map.jsp?layer=Precipitation">Precipitation</a></li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Preassure")) out.print("active");%>"><a
								href="map.jsp?layer=Preassure">Preassure</a></li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Rain")) out.print("active");%>"><a
								href="map.jsp?layer=Rain">Rain</a></li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Snow")) out.print("active");%>"><a
								href="map.jsp?layer=Snow">Snow</a></li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Temprature")) out.print("active");%>"><a
								href="map.jsp?layer=Temprature">Temprature</a></li>
							<li
								class="<%if (pageName.equalsIgnoreCase("map.jsp?layer=Wind")) out.print("active");%>"><a
								href="map.jsp?layer=Wind">Wind</a></li>
						</ul></li>
				</ul>
				<form class="navbar-form navbar-left" method="post"
					action="geo_lookup.jsp"
					style="padding-top: 0px; padding-bottom: 0px;">
					<div class="form-group">
						<input class="form-control" id="geocomplete" type="text"
							placeholder="Search by city" style="height: 53px;border: 0px;" />
						<!-- City -->
						<input type="hidden" name="locality" type="text" value=""></input>
						<!-- State -->
						<input type="hidden" name="administrative_area_level_1"
							type="text" value=""></input>
						<!-- Country -->
						<input type="hidden" name="country" type="text" value=""></input>
						<!-- Latitude -->
						<input type="hidden" name="lat" type="text" value=""></input>
						<!-- Longitude -->
						<input type="hidden" name="lng" type="text" value=""></input>
					</div>
					<button class="btn btn-default" name="lookup" id="find"
						type="submit" value="find">GO</button>
				</form>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false"><i
							class="glyphicon glyphicon-file"></i> News Feeds<span
							class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li
								class="${pageContext.request.requestURI eq '/wetter/disaster.jsp' ? ' active' : ''}"><a
								href="disaster.jsp">Disaster Alerts</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/EnviromentalNewsDisplay.jsp' ? ' active' : ''}"><a
								href="EnviromentalNewsDisplay.jsp">Enviroment News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/EntertainmentNewsDisplay.jsp' ? ' active' : ''}"><a
								href="EntertainmentNewsDisplay.jsp">Entertainment News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/HealthNewsDisplay.jsp' ? ' active' : ''}"><a
								href="HealthNewsDisplay.jsp">Health News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/SolarEnergyNewsDisplay.jsp' ? ' active' : ''}"><a
								href="SolarEnergyNewsDisplay.jsp">Solar Energy News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/LifeNewsDisplay.jsp' ? ' active' : ''}"><a
								href="LifeNewsDisplay.jsp">Lifestyle News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/FuelCellNewsDisplay.jsp' ? ' active' : ''}"><a
								href="FuelCellNewsDisplay.jsp">Fuel News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/FossilFuelNewsDisplay.jsp' ? ' active' : ''}"><a
								href="FossilFuelNewsDisplay.jsp">Fossil Fuel News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/GeoThermalNewsDisplay.jsp' ? ' active' : ''}"><a
								href="GeoThermalNewsDisplay.jsp">Geo Thermal News</a></li>
							<li
								class="${pageContext.request.requestURI eq '/wetter/EmissionNewsDisplay.jsp' ? ' active' : ''}"><a
								href="EmissionNewsDisplay.jsp">Emission News</a></li>
						</ul></li>
					<li><a href="#"><i class="fa fa-clock-o"></i> <% out.print(dateFormat.format(cal.getTime())); %></a></li>
					<!-- forecast time -->
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
</header>