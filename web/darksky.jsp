<jsp:useBean id="forecast" scope="request" type="com.ashessin.projects.wetter.model.Darksky"/>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dark Sky</title>
</head>
<body>
<code>${forecast}</code>
</body>
</html>
