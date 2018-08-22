# Wetter - Weather forecast aggregation.

When we move to a new city whether for a short or long duration, one major concern on our mind is the weather condition of that place compared to our home city. Immediately available weather conditions on various websites and apps are not sufficient enough to have a good comparison between cities with respect to their climate.

We intend to develop a web application which will provide information regarding the various environmental attributes of a particular city. We try to show this information in a graphical manner with which the user can interact.

## Project Setup and Run
1. Importing the project into Eclipse
   - Open Eclipse *-> Click* File *-> Click* Import *-> Click* General *-> Click* Existing Projects into Workspace. Follow on screen instructions.
   - Make sure all JARs and class folders on the build path are present for the project.
2. Set API Keys
   - Sign up for 
      - Google Maps JavaScript API key [here](https://accounts.google.com/ServiceLogin?passive=true&continue=https%3A%2F%2Fdevelopers.google.com%2Fmaps%2Fdocumentation%2Fjavascript%2F&service=ahsid#identifier)
      - Weather API- OpenWeatherMap key [here](https://home.openweathermap.org/users/sign_up)
      - Dark Sky API key [here](https://darksky.net/dev/register)
   - Set the above keys in `wetter\WebContent\resources\includes\api.jsp` file; lines 4,5,6.
     
     ```Java
     String api_key_GoogleMapsJavaScript   = "INSERT_YOUR_KEY";
     String api_key_OpenWeatherMap         = "INSERT_YOUR_KEY";
     String api_key_DarkSky                = "INSERT_YOUR_KEY";
     ```
3. Optionally set Proxy ie. `http.proxyHost` && `http.proxyPort` in files:
   - `wetter\WebContent\resources\includes\api.jsp`; line 24

4. Run the project on Apache Tomcat server.

## Screens

### Home page
![index.png](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/index.png)  
  

### Home page, showing available map layers in dropdown
![assets/index_autocomplete.png](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/index_maps.png)  
  

### Map page, showing various weather layer overlays (temprature, cloud, wind)
![assets/map.png](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/map.png)  
  

### Home page, showing places smart autocomplete feature for search
![assets/index_autocomplete_merge.png](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/index_autocomplete_merge.png)  
  

### Stats Page _(for representation only)_
![assets/Wetter___stats.jsp.png](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/Wetter___stats.jsp.png)  
  

### Geo Location page, shows detailed Weather Forecast based on user's geolocation (needs supported browser) with automatic Units (Celsius/Fahrenheit etc)
![assets/Wetter___geo_loc.jsp.png](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/Wetter___geo_loc.jsp.png)  
  

### Lookup page, shows detailed Weather Forecast for search term with automatic Units (Celsius/Fahrenheit etc)
![assets/Wetter___geo_lookup_miami.jsp.png ](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/Wetter___geo_lookup_miami.jsp.png)  
![assets/Wetter___geo_lookup_mumbai.jsp.png ](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/Wetter___geo_lookup_mumbai.jsp.png)  
![assets/Wetter___geo_lookup_bombay.jsp.png ](https://gitlab.com/user501254/Wetter/raw/b80b165a57036319d80d3e59919c3fa1a4719eb7/assets/Wetter___geo_lookup_bombay.jsp.png)  


## Third party resources used
### APIs 
1. [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/)
2. [Weather API- OpenWeatherMap](https://openweathermap.org/api)
3. [Dark Sky API](https://darksky.net/dev/)

**Java Libraries:**

- [JSON in Java [package org.json]](https://github.com/stleary/JSON-java)  
A Java library for Parsing JSON. Used at multiple places within the project.
- [ForecastIO-Lib-Java](https://github.com/dvdme/forecastio-lib-java)  
A Java library for the darksky.net API (previously forecast.io). Uses *[minimal-json](https://github.com/ralfstx/minimal-json)* for parsing the Json API response.

**Other:**
- [Flat-UI](https://github.com/designmodo/Flat-UI/)  
Design Framework (html/css3/less/js). Flat UI is based on Bootstrap, a comfortable, responsive, and functional framework that simplifies the development of websites.

- [Font Awesome](https://github.com/FortAwesome/Font-Awesome)  
The iconic font and CSS framework.
Font Awesome is a full suite of 634 pictographic icons for easy scalable vector graphics on websites, created and maintained by Dave Gandy. Stay up to date with the latest release and announcements on Twitter: @fontawesome.

- [Weather Icons](https://github.com/erikflowers/weather-icons)  
222 Weather Themed Icons and CSS.
Weather Icons is the only icon font and CSS with 222 weather themed icons, ready to be dropped right into Bootstrap, or any project that needs high quality weather, maritime, and meteorological based icons!

- [Skycons](https://github.com/torryharris/Skycons)  
Skycons is a set of ten animated weather glyphs, procedurally generated by JavaScript using the HTML5 canvas tag. They're easy to use, and pretty lightweight, so they shouldn't rain on your parade.

- [jQuery](https://github.com/jquery/jquery)  
A cross-platform JavaScript library designed to simplify the client-side scripting of HTML.

- [jQuery Geocoding and Places Autocomplete Plugin](https://github.com/ubilabs/geocomplete)  
An advanced jQuery plugin that wraps the Google Maps API's Geocoding and Places Autocomplete services. You simply provide an input that lets you search for locations with a nice autocomplete dropdown. Optionally add a container to show an interactive map and a form that will be populated with the address details.

- [Highcharts](https://github.com/highcharts/highcharts)  
Highcharts JS is a JavaScript charting library based on SVG, with fallbacks to VML and canvas for old browsers.

- Brand logo _gnome-weather.png_ from "[Paper Icons](http://snwh.org/paper/icons)" by [Sam Hewitt](http://samuelhewitt.com/) is licensed under [CC-SA-4.0](http://creativecommons.org/licenses/by-sa/4.0/)  

### TO-DO
- [x] Improve News Feeds UI
- [ ] Add comparisons across different Weather forecast APIs (eg. OpenWeatherMap vs. Dark Sky)
- [ ] Add Sign-Up page for easy setting of API keys
- [x] Add detailed Error pages
- [ ] Get rid of the [blatant use of scriptlets](https://stackoverflow.com/a/3180202/2534513)
- [ ] Migrate away from Cloud9 to always-on platforms

___

**_NOTE:_**  
1. **_The page `map.jsp` makes GET requests to API services on port 8099. Make sure it's not blocked, else you won't be seeing any results._**  
2. **_Some elements may not work due to missing database._**
