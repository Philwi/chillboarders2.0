module Spot::Cell
  class Index < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::ActionView::Helpers::JavaScriptHelper
    include ::Devise::Controllers::Helpers

    def spots
      if model.present?
        # TODO: wenn params angegeben sind, dann gebe die Spots auch von dort aus und nicht die von der Userlocation...
        # get users location and just the near spots for performance reasons
        less_spots =
          if model.count > 15 && (user_ip = request.remote_ip) && user_ip != '127.0.0.1' && params['query'].blank?
            results = Geocoder.search(user_ip)
            model.where('lat BETWEEN ? AND ? AND lng BETWEEN ? AND ?', results.first.coordinates.first - (0.009 * 10), results.first.coordinates.first + (0.009 * 10), results.first.coordinates.second - (0.009 * 10), results.first.coordinates.second + (0.009 * 10))
          end

        (less_spots || model.first(15)).map do |spot|
          spot_card(spot)
        end.join
      else
        content_tag(:div, class: 'no_spots_here') do
          out = ''
          out.concat content_tag(:i, 'sentiment_dissatisfied', class: 'material-icons')
          out.concat content_tag(:h5, I18n.t('.spots.empty'))
          out.concat link_to(I18n.t('.navigation.spot.new'), :new_spot)
        end
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
      content_tag(:div, class: 'card', id: "spot-#{spot.id}", style: 'width: 100%;') do
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
              list = ''
              list.concat content_tag(:li, spot_type(spot), class: 'list-group-item')
              list.concat content_tag(:li, spot_obstacles(spot), class: 'list-group-item')
              list.concat content_tag(:li, rating(spot.id), class: 'list-group-item')
              list.concat content_tag(:li, comments(spot.id), class: 'list-group-item')
            end)
            out.concat(content_tag(:div, class: 'card-body') do
              link_to I18n.t('.spots.to_spot'), edit_spot_path(spot), class: 'card-link'
            end)
          end)
        end
      end
    end

    def comments(spot_id)
      spot_comments = Comment.where(spot_id: spot_id).order(created_at: :desc)
      out = ''
      out.concat(content_tag('div data-target="comment-list.commentList"') do
        cell(::Comment::Cell::Index, spot_comments, spot_id: spot_id, spots: model).()
      end)
    end

    def rating(spot_id)
      if !current_user || rating = Rating.find_by(spot_id: spot_id, user_id: current_user&.id)
        cell(Rating::Cell::Show, nil, spot_id: spot_id).()
      else
        cell(Rating::Cell::Create, Rating.new, spot_id: spot_id, spots: model&.pluck(:id)).()
      end
    end

    def spot_type(spot)
      out = ''
      out.concat content_tag(:h5, I18n.t('.activerecord.attributes.spot.type'))
      out.concat content_tag(:p, spot.type.titleize)
    end

    def spot_obstacles(spot)
      out = ''
      out.concat content_tag(:h5, I18n.t('.activerecord.attributes.spot.obstacles'))
      out.concat content_tag(:p, spot.obstacles.to_sentence)
    end

    MARKER_IMAGES = [
      { type: 'street', icon: 'streetIcon' },
      { type: 'park', icon: 'parkIcon' },
      { type: 'indoor_park', icon: 'indoorParkIcon' },
    ]

    def create_markers
      model.map.with_index do |spot, index|
        icon = MARKER_IMAGES.find { |image| image[:type] == spot.type }&.dig(:icon) || 'parkIcon'
        "var marker#{index} = markers.addLayer(L.marker([#{spot.lat}, #{spot.lng}], {id: 'spot-#{spot.id}', icon: #{icon}}).on('click', scrollToId));"
      end.join
    end

    def leaflet_map
      javascript_tag <<-JAVASCRIPT
      navigator.geolocation.getCurrentPosition(getPosition);

      var lng = 0
      var lat = 0
      var markerChangeTimer;                //timer identifier
      var doneChangeInterval = 5000;  //time in ms (5 seconds)
      var markers = L.markerClusterGroup({
        removeOutsideVisibleBounds: true,
      });

      var skateIcon = L.Icon.extend({
        options: {
          iconSize:     [50, 50], // size of the icon
          iconAnchor:   [51, 49], // point of the icon which will correspond to marker's location
          popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
        }
      });

      var streetIcon = new skateIcon({iconUrl: '/images/markers/street.svg'}),
          parkIcon = new skateIcon({iconUrl: '/images/markers/park.svg'}),
          indoorParkIcon = new skateIcon({iconUrl: '/images/markers/indoor_park.svg'});

      function getPosition(position){
        if (#{after_search}){
          lat = #{@lat || 0}
          lng = #{@lng || 0}
        } else {
          lat = position.coords.latitude
          lng = position.coords.longitude
        };

        setMap()
      }

      function scrollToId(e){
        document.getElementById(e.target.options.id).scrollIntoView({behavior: 'smooth'});
      }

      function setMap(){
        var map = L.map('mapid').setView([lat, lng], 13);
        L.tileLayer('https://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

        eval("#{create_markers}");

        function setBoundsAndTriggerReflexAction(){
          const bounds = map.getBounds();
          const northEast = [bounds.getNorthEast().lat, bounds.getNorthEast().lng]
          const southWest = [bounds.getSouthWest().lat, bounds.getSouthWest().lng]
          const value = [northEast, southWest]

          var event = new Event('change', { 'bubbles': true, 'cancelable': true });
          var el = document.getElementById('bounds')
          el.value = JSON.stringify(value);
          el.dispatchEvent(event);
        }


        map.on('move', function() {
          clearTimeout(markerChangeTimer);
          markerChangeTimer = setTimeout(setBoundsAndTriggerReflexAction, 150);
        });
        map.addLayer(markers);
        map.fire('move');
      }
      JAVASCRIPT
    end
  end
end