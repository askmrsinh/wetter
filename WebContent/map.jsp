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
    
  <%
    String mapLayer= request.getParameter("layer");
	%>

  <% if (mapLayer.equalsIgnoreCase("Clouds")) { %>
		var layerID = "57f47efe946d8a0100852daa";
	<% } %>
	<% if (mapLayer.equalsIgnoreCase("Precipitation")) { %>
		var layerID = "57f53e96946d8a0100852db7";
	<% } %>
	<% if (mapLayer.equalsIgnoreCase("Preassure")) { %>
		var layerID = "57f53fd9946d8a0100852db8";
	<% } %>
	<% if (mapLayer.equalsIgnoreCase("Rain")) { %>
		var layerID = "57f5404d946d8a0100852db9";
	<% } %>
	<% if (mapLayer.equalsIgnoreCase("Snow")) { %>
		var layerID = "57f54192946d8a0100852dbb";
	<% } %>
	<% if (mapLayer.equalsIgnoreCase("Temprature")) { %>
		var layerID = "57f42591946d8a0100852da7";
	<% } %>
	<% if (mapLayer.equalsIgnoreCase("Wind")) { %>
		var layerID = "57f540c5946d8a0100852dba";
	<% } %>
    	
    
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
          var bound = Math.pow(2, zoom);
          return "http://maps.owm.io:8099/"+ layerID +"/" +
            zoom + "/" + normalizedCoord.x + "/" + (bound - normalizedCoord.y - 1) + "?hash=5";
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