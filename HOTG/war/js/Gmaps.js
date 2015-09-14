var map;
var marker;


function initialize() {
        var mapOptions = {
          center: new google.maps.LatLng(18.9750,72.8258),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map-canvas"),
            mapOptions);
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(18.9750,72.8258),
            map: map,
            animation: google.maps.Animation.DROP,
            title: 'Mumbai'
        });
        
        google.maps.event.addListener(marker, 'click', toggleBounce);
        
      }
      google.maps.event.addDomListenerOnce(window, 'load', initialize);
      
      
      
      function ChangeLatLong(Latitude,Longitude,Street)
      {
      	var panPoint = new google.maps.LatLng(Latitude,Longitude);
          map.panTo(panPoint)
      	 map.setZoom(13);
         // map.setHeading(10);
        marker = new google.maps.Marker({
              position: panPoint,
              map: map,
              animation: google.maps.Animation.DROP,
              title: Street
          });
        
        google.maps.event.addListener(marker, 'click', toggleBounce);
      }
      
      function toggleBounce() {

    	  if (marker.getAnimation() != null) {
    	    marker.setAnimation(null);
    	  } else {
    	    marker.setAnimation(google.maps.Animation.BOUNCE);
    	  }
    	}