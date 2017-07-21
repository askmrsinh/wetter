<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<jsp:include page="resources/includes/api.jsp" />

<html>

<jsp:include page="resources/includes/head.jsp" />
<body onload="getLocation()">
	<jsp:include page="resources/includes/nav.jsp" />
	<div id="map-canvas"></div>
	<jsp:include page="resources/includes/footer.jsp" />
	<script>
    var map;
    var myCoordinates = new google.maps.LatLng(19.0356826, 72.9112641);

    function initialize() {
      var map = new google.maps.Map(document.getElementById('map-canvas'), {
        zoom: 2,
        minZoom: 2,
        maxZoom: 15,
        center: myCoordinates,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        disableDefaultUI: true
      });

      // Use GeoLocation if available
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
          initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
          map.setCenter(initialLocation);
        });
      }

      var myMapType = new google.maps.ImageMapType({
        getTileUrl: function (coord, zoom) {
          var normalizedCoord = getNormalizedCoord(coord, zoom);
          if (!normalizedCoord) {
            return null;
          }
          //var bound = Math.pow(2, zoom);
          return "http://tile.openweathermap.org/map/<% out.print(request.getParameter("layer")); %>/" +
            zoom + "/" + 
            normalizedCoord.x + "/" + 
            normalizedCoord.y + 
            ".png?appid=<% out.print(session.getAttribute("api_key_OpenWeatherMap")); %>"
        },
        tileSize: new google.maps.Size(256, 256),
        maxZoom: 8,
        minZoom: 0,
        name: 'mymaptype'
      });

      // Normalizes the coords that tiles repeat across the x axis (horizontally)
      // like the standard Google map tiles.
      function getNormalizedCoord(coord, zoom) {
        var y = coord.y;
        var x = coord.x;

        // tile range in one direction range is dependent on zoom level
        // 0 = 1 tile, 1 = 2 tiles, 2 = 4 tiles, 3 = 8 tiles, etc
        var tileRange = 1 << zoom;

        // don't repeat across y-axis (vertically)
        if (y < 0 || y >= tileRange) {
          return null;
        }

        // repeat across x-axis
        if (x < 0 || x >= tileRange) {
          x = (x % tileRange + tileRange) % tileRange;
        }

        return {
          x: x,
          y: y
        };
      }

      map.overlayMapTypes.insertAt(0, myMapType);
    };

    google.maps.event.addDomListener(window, 'load', initialize);
  </script>
</body>

</html>