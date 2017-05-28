<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>

<jsp:include page="../includes/api.jsp" />

<!-- HEADER -->
<jsp:include page="../includes/head.jsp" />
<body>
	<jsp:include page="../includes/nav.jsp" />
	<div class="container error">
		<div class="row">
			<div class="col-4-md error-message">
				<a href="index.jsp"> <img class="error-logo" alt="Wetter"
					src="public/favicons/android-chrome-192x192.png">
				</a>
				<h1>Error: ${pageContext.errorData.statusCode}</h1>
				<h6 class="hidden">
					<dfn title="${pageContext.errorData.servletName}">${pageContext.errorData.requestURI}</dfn>
				</h6>
				<h6 class="hidden">${pageContext.errorData.throwable}</h6>
				<%
					if (pageContext.getErrorData().getStatusCode() == 500)
						out.print("<h6>There are probably a million ways to break this.<br>You just found one.</h6>");
					if (pageContext.getErrorData().getStatusCode() == 404)
						out.print("<h6>Ooops!<br>We could not find the page you were looking for.</h6>");
				%>
				<h6 class="error-redirect">You are being redirected to the home page.</h6>
			</div>
		</div>
	</div>
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>