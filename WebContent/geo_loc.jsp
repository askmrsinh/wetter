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
				System.out.print("geo-error" + request.getParameter("geo-error"));
				if (request.getParameter("geo-error") == null) {
					out.print("<h4 class=\"bg-warning\">Something went wrong, please try agin.</h4>");
				} else if (request.getParameter("geo-error").length() == 0
						|| request.getParameter("geo-error").equalsIgnoreCase("TRUE")) {
					out.print(
							"<h4 class=\"bg-danger\" id=\"geo-error-msg\">Kindly provide location access for this page in your browser.</h4>");
				} else {
					out.print("<h3 class=\"ml-15 text-info\">" + request.getAttribute("City") + ", "
							+ request.getAttribute("State"));
					out.print("<small class=\"text-muted\"> " + request.getAttribute("Data") + "</small>");
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