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

	<script type="text/javascript">
    var map;
    var geoJSON;
    var request;
    var gettingData = false;
    var openWeatherMapKey = "<% out.print(session.getAttribute("api_key_OpenWeatherMap")); %>";

    function initialize() {
      var mapOptions = {
        zoom: 4,
        minZoom: 4,
        maxZoom: 15,
        center: {lat: 19.0356826, lng: 72.9112641},
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        disableDefaultUI: true
      };
      
      map = new google.maps.Map(document.getElementById('map-canvas'),
    	        mapOptions);
    	      
	  // Use GeoLocation if available
	  if (navigator.geolocation) {
	  	navigator.geolocation.getCurrentPosition(function (position) {
	  		initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
	        map.setCenter(initialLocation);
	    });
	}
   	  
      // Add interaction listeners to make weather requests
      google.maps.event.addListener(map, 'idle', checkIfDataRequested);

      // Sets up and populates the info window with details
      map.data.addListener('click', function (event) {
        infowindow.setContent(
          "<img src=" + event.feature.getProperty("icon") + ">" + "<br /><strong>" + event.feature.getProperty("city") + "</strong>" + "<br />" + event.feature.getProperty("temperature") + "&deg;C" + "<br />" + event.feature.getProperty("pressure") + " hPa" + ", " + event.feature.getProperty("windSpeed") + "m/s" + " " + event.feature.getProperty("windDegrees") + "&deg;" + ", " + event.feature.getProperty("humidity") + "%" + "<br /> Weather Status - " + event.feature.getProperty("weather")
        );
        infowindow.setOptions({
          position: {
            lat: event.latLng.lat(),
            lng: event.latLng.lng()
          },
          pixelOffset: {
            width: 0,
            height: -15
          }
        });
        infowindow.open(map);
      });
    }

    var checkIfDataRequested = function () {
      // Stop extra requests being sent
      while (gettingData === true) {
        request.abort();
        gettingData = false;
      }
      getCoords();
    };

    // Get the coordinates from the Map bounds
    var getCoords = function () {
      var bounds = map.getBounds();
      var NE = bounds.getNorthEast();
      var SW = bounds.getSouthWest();
      getWeather(NE.lat(), NE.lng(), SW.lat(), SW.lng());
    };

    // Make the weather request
    var getWeather = function (northLat, eastLng, southLat, westLng) {
      gettingData = true;
      var requestString = "https://api.openweathermap.org/data/2.5/box/city?bbox=" + westLng + "," + northLat + "," //left top
        + eastLng + "," + southLat + "," //right bottom
        + map.getZoom() + "&cluster=yes&format=json" + "&units=metric&APPID=" + openWeatherMapKey;
      request = new XMLHttpRequest();
      request.onload = proccessResults;
      request.open("get", requestString, true);
      request.send();
    };

    // Take the JSON results and proccess them
    var proccessResults = function () {
      console.log(this);
      var results = JSON.parse(this.responseText);
      if (results.list.length > 0) {
        resetData();
        for (var i = 0; i < results.list.length; i++) {
          geoJSON.features.push(jsonToGeoJson(results.list[i]));
        }
        drawIcons(geoJSON);
      }
    };

    var infowindow = new google.maps.InfoWindow();

    // For each result that comes back, convert the data to geoJSON
    var jsonToGeoJson = function (weatherItem) {
      var feature = {
        type: "Feature",
        properties: {
          city: weatherItem.name,
          weather: weatherItem.weather[0].main,
          temperature: weatherItem.main.temp,
          min: weatherItem.main.temp_min,
          max: weatherItem.main.temp_max,
          humidity: weatherItem.main.humidity,
          pressure: weatherItem.main.pressure,
          windSpeed: weatherItem.wind.speed,
          windDegrees: weatherItem.wind.deg,
          windGust: weatherItem.wind.gust,
          cod: weatherItem.cod,
          icon: "https://openweathermap.org/img/w/" + weatherItem.weather[0].icon + ".png",
          coordinates: [weatherItem.coord.Lon, weatherItem.coord.Lat]
        },
        geometry: {
          type: "Point",
          coordinates: [weatherItem.coord.Lon, weatherItem.coord.Lat]
        }
      };
      // Set the custom marker icon
      map.data.setStyle(function (feature) {
        return {
          icon: {
            url: feature.getProperty('icon'),
            anchor: new google.maps.Point(25, 25)
          }
        };
      });

      //console.log(weatherItem);
      //console.log(feature);

      // returns object
      return feature;
    };

    // Add the markers to the map
    var drawIcons = function (weather) {
      map.data.addGeoJson(geoJSON);
      // Set the flag to finished
      gettingData = false;
    };

    // Clear data layer and geoJSON
    var resetData = function () {
      geoJSON = {
        type: "FeatureCollection",
        features: []
      };
      map.data.forEach(function (feature) {
        map.data.remove(feature);
      });
    };
    
    google.maps.event.addDomListener(window, 'load', initialize);
  </script>
</body>

</html>
