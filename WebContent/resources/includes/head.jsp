<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- Favicons -->
<link rel="apple-touch-icon" sizes="180x180"
	href="../../public/favicons/apple-touch-icon.png?v=jw6MpKa3ry">
<link rel="icon" type="image/png"
	href="../../public/favicons/favicon-32x32.png?v=jw6MpKa3ry" sizes="32x32">
<link rel="icon" type="image/png"
	href="../../public/favicons/favicon-16x16.png?v=jw6MpKa3ry" sizes="16x16">
<link rel="shortcut icon" href="../../public/favicons/favicon.ico?v=jw6MpKa3ry" type="image/x-icon" />
<link rel="shortcut icon" href="favicon.ico?v=jw6MpKa3ry" type="image/x-icon" />

<%
    String uri = request.getRequestURI();
    String pageName = uri.substring(uri.lastIndexOf("/") + 1);
  %>

<title>Wetter - <%= pageName%></title>

<!-- Modernizr and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

<style>
html, body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}
#map-canvas {
	width: 100%;
	height: 100%;
}

.gm-style-iw {
	text-align: center;
}
</style>

<!-- Bootstrap CSS -->
<link
	href="public/bower_components/flat-ui/dist/css/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">


<!-- Custom Fonts -->
<link href="https://fonts.googleapis.com/css?family=Bitter:700"
	rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,700"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700"
	rel="stylesheet" type="text/css">

<!-- Flat-UI for Bootstrap CSS -->
<link href="public/bower_components/flat-ui/dist/css/flat-ui.min.css"
	rel="stylesheet" type="text/css">

<!-- Font Awesome -->
<link
	href="public/bower_components/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- Weather Icons -->
<link
	href="public/bower_components/weather-icons/css/weather-icons.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom CSS -->
<link href="public/css/main.css" rel="stylesheet" />
<link href="public/css/weather.css" rel="stylesheet" />

  <script>
    var x = document.getElementById("body");
    function getLocation()
    {
      if (navigator.geolocation)
      {
        navigator.geolocation.getCurrentPosition(bindPosition);
      }
      else {
        x.innerHTML = "Geolocation is not supported by this browser.";
      }
    }
    function bindPosition(position) {
      $("input[name='latitude_loc']").val(position.coords.latitude);
      $("input[name='longitude_loc']").val(position.coords.longitude);
    }
  </script>

</head>