<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Wetter - Weather forecast aggregation.">
<meta name="author" content="Ashesh Kumar Singh (user501254@gmail.com)">

<!-- Favicons -->
<link rel="apple-touch-icon" sizes="180x180"
	href="../../public/favicons/apple-touch-icon.png?v=jw6MpKa3ry">
<link rel="icon" type="image/png"
	href="../../public/favicons/favicon-32x32.png?v=jw6MpKa3ry"
	sizes="32x32">
<link rel="icon" type="image/png"
	href="../../public/favicons/favicon-16x16.png?v=jw6MpKa3ry"
	sizes="16x16">
<link rel="shortcut icon"
	href="../../public/favicons/favicon.ico?v=jw6MpKa3ry"
	type="image/x-icon" />
<link rel="shortcut icon" href="favicon.ico?v=jw6MpKa3ry"
	type="image/x-icon" />

<%
	String uri = request.getRequestURI();
	String pageName = uri.substring(uri.lastIndexOf("/") + 1);

	if (pageName.equalsIgnoreCase("oops.jsp"))
		out.print("<meta http-equiv=\"refresh\" content=\"3;url=index.jsp\" />");
%>

<title>Wetter - <%=pageName%></title>

<!-- Modernizr and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- Bootstrap CSS -->
<!-- <link
	href="public/bower_components/flat-ui/dist/css/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css"> -->
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css"
    rel="stylesheet" type="text/css">

<!-- Flat-UI for Bootstrap CSS -->
<!-- <link href="public/bower_components/flat-ui/dist/css/flat-ui.min.css"
	rel="stylesheet" type="text/css"> -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/flat-ui/2.3.0/css/flat-ui.min.css"
    rel="stylesheet" type="text/css">

<!-- Font Awesome -->
<!-- <link
	href="public/bower_components/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css"> -->
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">

<!-- Weather Icons -->
<!-- <link
	href="public/bower_components/weather-icons/css/weather-icons.min.css"
	rel="stylesheet" type="text/css"> -->
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.9/css/weather-icons.min.css"
    rel="stylesheet" type="text/css">

<!-- Custom Fonts -->
<link href="https://fonts.googleapis.com/css?family=Bitter:700"
    rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,700"
    rel="stylesheet" type="text/css">
<link
    href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700"
    rel="stylesheet" type="text/css">

<!-- Custom CSS -->
<link href="public/css/main.css" rel="stylesheet" />
<link href="public/css/weather.css" rel="stylesheet" />

<script>
	var x = document.getElementById("body");
	var y = document.getElementById("geo-error-msg");

	function getLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(bindPosition, showError);
		} else {
			y.innerHTML = "Geolocation is not supported by this browser.";
		}
	}
	function bindPosition(position) {
		$("input[name='latitude_loc']").val(position.coords.latitude);
		$("input[name='longitude_loc']").val(position.coords.longitude);
		$("input[name='geo-error']").val("FALSE");
	}
	function showError(error) {
		$("input[name='geo-error']").val("TRUE");
		switch (error.code) {
		case error.PERMISSION_DENIED:
			y.innerHTML = "You have denied/ignored the request for Geolocation on this site.";
			break;
		case error.POSITION_UNAVAILABLE:
			y.innerHTML = "Location information is unavailable.";
			break;
		case error.TIMEOUT:
			y.innerHTML = "The request to get user location timed out.";
			break;
		case error.UNKNOWN_ERROR:
			y.innerHTML = "An unknown error occurred.";
			break;
		}
	}
</script>
</head>