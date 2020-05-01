module Spot::Cell
  class Edit < Trailblazer::Cell
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

        var lat = #{model.lat};
        var lng = #{model.lng};
        var map = L.map('mapid').setView([lat, lng], 13);
        marker = L.marker([lat, lng]).addTo(map);

        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
      JAVASCRIPT
    end
  end
end