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
				String[] locDataArray = request.getAttribute("Data").toString().split(",");
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