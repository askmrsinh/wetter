<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="resources/includes/api.jsp"%>

<!-- HEADER -->
<jsp:include page="resources/includes/head.jsp" />

<body onload="getLocation()">

	<!-- NAV BAR -->
	<jsp:include page="resources/includes/nav.jsp" />

	<div class="container">

		<div class="row">
			<%
				String City =request.getAttribute("City").toString();
				String State =request.getAttribute("State").toString();
				String Data =request.getAttribute("Data").toString();
				
				if (City.length() + State.toString().length() + Data.length()==0){
					out.print("<h4 class=\"bg-danger\">Unable to get Geolocation, please verify that you have browser support.</h4>");
				} else {
					out.print("<h3 class=\"ml-15 text-info\">" + City + ", " + State);
					out.print("<small class=\"text-muted\"> " + Data + "</small>");
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