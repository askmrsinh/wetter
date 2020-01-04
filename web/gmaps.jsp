<jsp:useBean id="geocode_location" scope="request" type="com.ashessin.projects.wetter.model.Gmaps"/>
<jsp:useBean id="geocode_address" scope="request" type="com.ashessin.projects.wetter.model.Gmaps"/>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Google Maps</title>
</head>
<body>
<code>${geocode_location}</code>
<code>${geocode_address}</code>
</body>
</html>
