module Spot::Cell
  class Index < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::ActionView::Helpers::JavaScriptHelper

    def spots
      if model.present?
        model.map do |spot|
          spot_card(spot)
        end.join
      else
        content_tag(:h3, I18n.t('.spots.empty'))
      end
    end

    def after_search
      query = options.dig(:params, 'query' ,'search')
      return false if query.blank?
      client = ::OpenStreetMap::Client.new
      result = client.search(q: query, format: 'json').first
      @lat = result['lat']
      @lng = result['lon']
    end

    def spot_card(spot)
      content_tag(:div, class: 'card', style: 'width: 100%;') do
        content_tag(:div, class: 'row') do
          output = ''
          output.concat(content_tag(:div, class: 'col-lg') do
            image_tag(spot&.images&.first || "sign_in_image.jpg", class: 'card-img-top', alt: 'Spotimage')
          end)
          output.concat(content_tag(:div, class: 'col-lg') do
            out = ''
            out.concat(content_tag(:div, class: 'card-body') do
              inner = ''
              inner.concat content_tag(:h5, spot.title, class: 'card-title')
              inner.concat content_tag(:p, spot.description, class: 'card-text')
            end)
            out.concat(content_tag(:ul, class: 'list-group list-group-flush') do
              content_tag(:li, spot.type, class: 'list-group-item')
            end)
            out.concat(content_tag(:div, class: 'card-body') do
              link_to I18n.t('.spots.to_spot'), edit_spot_path(spot.id), class: 'card-link'
            end)
            out.concat comments(spot.id)
            out.concat comment(spot.id)
          end)
        end
      end
    end

    def comment(spot_id)
      cell(::Comment::Cell::Create, ::Comment.new, spot_id: spot_id).()
    end

    def comments(spot_id)
      spots = Spot.find(spot_id).comments
      content_tag('div data-target="comment-list.commentList"') do
        cell(::Comment::Cell::Index, spots).()
      end
    end

    #def single_spot(spot)
    #  content_tag(:div, class: 'card', style: 'width: 18rem;') do
    #    output = ''
    #    output.concat image_tag(spot&.images&.first || "sign_in_image.jpg", class: 'card-img-top', alt: 'Spotimage')
    #    output.concat(content_tag(:div, class: 'card-body') do
    #      inner = ''
    #      inner.concat content_tag(:h5, spot.title, class: 'card-title')
    #      inner.concat content_tag(:p, spot.description, class: 'card-text')
    #    end)
    #    output.concat(content_tag(:ul, class: 'list-group list-group-flush') do
    #      content_tag(:li, spot.type, class: 'list-group-item')
    #    end)
    #    output.concat(content_tag(:div, class: 'card-body') do
    #      link_to I18n.t('.spots.to_spot'), edit_spot_path(spot.id), class: 'card-link'
    #    end)
    #  end
    #end

    def leaflet_script
      <<-SCRIPT
        <script src="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js"></script>
      SCRIPT
    end

    def create_markers
      model.map.with_index do |spot, index|
        "var marker#{index} = L.marker([#{spot.lat}, #{spot.lng}], slug = '#{spot.slug}').addTo(map); marker#{index}.on('click', 'onClick');"
      end.join
    end

    def leaflet_map
      javascript_tag <<-JAVASCRIPT
      navigator.geolocation.getCurrentPosition(getPosition);

      var lng = 0
      var lat = 0

      function getPosition(position){
        if (#{after_search}){
          lat = #{@lat || 0}
          lng = #{@lng || 0}
        } else {
          lat = position.coords.latitude
          lng = position.coords.longitude
        };

        setMap();
      }

      function setBoundsAndTriggerReflexAction(map){
        const bounds = map.getBounds();
        const northEast = [bounds.getNorthEast().lat, bounds.getNorthEast().lng]
        const southWest = [bounds.getSouthWest().lat, bounds.getSouthWest().lng]
        const value = [northEast, southWest]

        var event = new Event('change', { 'bubbles': true, 'cancelable': true });
        var el = document.getElementById('bounds')
        el.value = JSON.stringify(value);
        el.dispatchEvent(event);
      }

      function setMap(){
        var map = L.map('mapid').setView([lat, lng], 13);
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

        eval("#{create_markers}")

        map.on('zoomend', function() {
          setBoundsAndTriggerReflexAction(map)
        });
      }
      JAVASCRIPT
    end
  end
end