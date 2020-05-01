module Spot::Cell
  class Create < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::JavaScriptHelper

    def spot_images
      model.images.map do |image|
        image_tag(image, class: "img-fluid", alt: "Spot Image")
      end.join
    end

    def leaflet_script
      <<-SCRIPT
        <script src="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js"></script>
      SCRIPT
    end

    def leaflet_map
      javascript_tag <<-JAVASCRIPT

        var marker;
        var lat = 0.0;
        var lng = 0.0;

        navigator.geolocation.getCurrentPosition(getPosition);

        function getPosition(position){
          lat = position.coords.latitude;
          lng = position.coords.longitude;
          setMap();
        }

        function setMap(){
          var map = L.map('mapid').setView([lat, lng], 13);
          L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
              }).addTo(map);

          var onDrag = function(e) {
            var latlng = marker.getLatLng();
            document.getElementById('spot_lat').innerHTML = latlng.lat;
            document.getElementById('spot_lng').innerHTML = latlng.lng;
          };

          var onClick = function(e) {
            if(marker)
              map.removeLayer(marker)
            marker = L.marker(e.latlng, {draggable: true, interactive: true}).addTo(map);
            marker.dragging.enable();
            lat = e.latlng.lat;
            lng = e.latlng.lng;
            document.getElementById('spot_lat').value = e.latlng.lat;
            document.getElementById('spot_lng').value = e.latlng.lng;

            marker.on('drag', onDrag);
          };

          map.on('click', onClick);
        }
      JAVASCRIPT
    end
  end
end