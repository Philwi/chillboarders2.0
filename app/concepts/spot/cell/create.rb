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

    def form
      attributes = [
        { attribute: :title, icon: 'subject', options: { required: true, autofocus: true, label: false, placeholder: I18n.t('.activerecord.attributes.spot.title')} },
        { attribute: :description, icon: 'view_headline', options: { as: :text, required: true, label: false, placeholder: I18n.t('.activerecord.attributes.spot.description') } },
        { attribute: :type, icon: 'fitness_center', type: :select, options: { collection: ::Spot::Util::Helper::SPOT_TYPES, include_blank: false, include_hidden: false, label_method: :titleize, label: false}},
        { attribute: :obstacles, icon: 'menu_book', type: :select, options: { collection: ::Spot::Util::Helper::SPOT_OBSTACLES, include_blank: false, include_hidden: false, label_method: :titleize, label: false, input_html: { multiple: true }}},
        { attribute: :images, icon: 'photo', type: :attachment, options: { multiple: true, class: 'form-control', accept: "image/png,image/gif,image/jpeg" } },
        { attribute: :lat, icon: '', options: { as: :hidden }, hidden: true },
        { attribute: :lng, icon: '', options: { as: :hidden }, hidden: true },
      ]
      ::Chillboarders::Cell::Form.(model, attributes: attributes, path: :spots, container_id: 'login_container', card_class: 'user_card sign_up', submit_text: I18n.t('.misc.save'), context: context)
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