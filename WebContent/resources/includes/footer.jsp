<footer class="section foot">
	<div class="scroll-help">
		<a href="#top">Back to Top <i class="fa fa-arrow-up fa-fw"></i></a>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-9">
				<p class="social">
					<a href="https://www.facebook.com/xxxxxxx"><i
						class="fa fa-facebook fa-fw fa-2x text-muted"></i></a> <a
						href="https://plus.google.com/u/0/xxxxxxxxxxxx/posts"><i
						class="fa fa-google-plus fa-fw fa-2x text-muted"></i></a> <a
						href="https://twitter.com/xxxxxxx_TCSb"><i
						class="fa fa-twitter fa-fw fa-2x text-muted"></i></a> <a
						href="https://www.youtube.com/channel/UCuOpEnoojQxm1h1iaCv8ojg"><i
						class="fa fa-youtube fa-fw fa-2x text-muted"></i></a>
				</p>
				<p class="vision-footer text-justify">
					TCS APPhonics Dev envisages the <strong>'DigiPhonics:
						Digital Me Challenge 15 (Environment App)'</strong> platform to harness the
					intellectual talent of young India to create environment based API
					applications on the occasion of Mahatma Gandhi's birth anniversary
					on 2 October when India will ratify the Conference of Parties (CoP)
					protocol on combating climate change. <a
						href="https://knome.ultimatix.net/communities/7412-apphonics-dev"
						target="_blank">Read More <i class="fa fa-fw fa-external-link"></i>
					</a>
				</p>
				<div class="links-footer">
					<a href="contact-us">CONTACT US</a> &#8226; <a href="team">TEAM</a>
					&#8226; <a href="faq">FAQ</a> &#8226; <a href="press">PRESS</a>
				</div>
				<div class="powered-by">
				<p>
					Powered by APIs and Data from: 
					<a href="https://openweathermap.org/" target="_blank">OpenWeatherMap</a> &bull; 
					<a href="https://darksky.net/poweredby/" target="_blank">Dark Sky</a> &bull;
					<a href="https://developers.google.com/maps/" target="_blank">Google</a>
				</p>
				</div>
			</div>
			<div class="col-sm-3 col-md-3">
				<div class="logo-footer">
					<img src="public/favicons/favicon-32x32.png" alt="Wetter Logo">
				</div>
				<div class="address-footer">
					<address>
						<strong>FL - 8, 'A' Wing, </strong>Kensington Building,<br>TCS
						Bombay, Powai,<br> Mumbai - 400076, Maharashtra.
					</address>
					<address>
						Email us at <a href="mailto:user501254@gmail.com">helpdesk@wetter.org</a>
					</address>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="footer-copyright text-center">Copyright &copy;
					2016 Wetter. All rights reserved.</div>
				<div class="footer-thirdparty text-center">
					<a href="#">Sitemap</a> | <a href="#">Credits</a>
				</div>
			</div>
		</div>
	</div>
	<div class="site-version">
		<i><a href="https://knome.ultimatix.net/blogposts/320852-digital-me-challenge-15-wetter-weather-forecast-aggregation">develop</a></i>
	</div>
</footer>

<!-- LOCATION FORM -->
<form id="loc" name="loc" method="post" action="geo_loc.jsp">
	<input type='hidden' value='' name='latitude_loc' id='latitude' /> <input
		type='hidden' value='' name='longitude_loc' id='longitude' /> <input
		type='hidden' value='' name='geo-error' id='geo-error' />
</form>

<!-- jQuery -->
<!-- <script type="text/javascript"
	src="public/bower_components/flat-ui/dist/js/vendor/jquery.min.js"></script> -->
<script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Flat-UI for Bootstrap JS -->
<!-- <script type="text/javascript"
	src="public/bower_components/flat-ui/dist/js/flat-ui.min.js"></script> -->
<script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/flat-ui/2.3.0/js/flat-ui.min.js"></script>

<!-- Skycons JS -->
<!-- <script type="text/javascript"
	src="public/bower_components/skycons-html5/skycons.js"></script> -->
<script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/skycons/1396634940/skycons.min.js"></script>

<!-- Google Maps JS API -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=<% out.print(session.getAttribute("api_key_GoogleMapsJavaScript")); %>&libraries=places"></script>

<!-- Geocomplete JS -->
<!-- <script type="text/javascript"
	src="public/bower_components/geocomplete/jquery.geocomplete.min.js"></script> -->
<script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/geocomplete/1.7.0/jquery.geocomplete.min.js"></script>

<script>
  var skycons = new Skycons({"color": "#34495e"}),
      list  = [
        "clear-day", "clear-night", "partly-cloudy-day",
        "partly-cloudy-night", "cloudy", "rain", "sleet", "snow", "wind",
        "fog"
      ],
      i;
  
    for(i = list.length; i--; ) {
        var weatherType = list[i],
            elements = document.getElementsByClassName( weatherType );
        for (e = elements.length; e--;){
            skycons.set( elements[e], weatherType );
        }
    }
  
  skycons.play();
  
  //GeoCode
  $(function(){
    $("#geocomplete").geocomplete({
      details: "form",
      types: ['geocode'],
      //map: "#map-canvas",
    });
  });
  
  //Tracking
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-97229150-1', 'auto');
  ga('send', 'pageview');
  
</script>