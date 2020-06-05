module Spot::Cell
  class Edit < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::JavaScriptHelper
    include ::Devise::Controllers::Helpers

    # contract shit workaround
    def spot
      model.class == Spot ? model : model.model
    end

    def spot_images
      spot.images.map.with_index do |image, index|
        css_class = (index == 0 ? 'carousel-item active' : 'carousel-item')
        content_tag(:div, image_tag(image, class: "img-fluid d-block.w-100", alt: "Spot Image"), class: css_class)
      end.join
    end

    def address
      client = ::OpenStreetMap::Client.new
      client.reverse(format: 'json', lat: spot.lat, lon: spot.lng)['display_name']
    end

    def spot_wego_here
      "https://share.here.com/l/#{model.lat},#{model.lng}?z=13&p=yes"
    end

    def form
      attributes = [
        { attribute: :title, icon: 'subject', options: { required: true, autofocus: true, label: false, placeholder: I18n.t('.activerecord.attributes.spot.title'), disabled: true} },
        { attribute: :description, icon: 'view_headline', options: { as: :text, required: true, label: false, placeholder: I18n.t('.activerecord.attributes.spot.description'), disabled: true } },
        { attribute: :type, icon: 'fitness_center', type: :select, options: { collection: ::Spot::Util::Helper::SPOT_TYPES, include_blank: false, include_hidden: false, label_method: :titleize, label: false}},
        { attribute: :obstacles, icon: 'menu_book', type: :select, options: { collection: ::Spot::Util::Helper::SPOT_OBSTACLES, include_blank: false, include_hidden: false, as: :check_boxes, label_method: :titleize, label: false, input_html: { multiple: true }}},
        { attribute: :images, icon: 'photo', type: :attachment, options: { multiple: true, class: 'form-control', accept: "image/png,image/gif,image/jpeg" } },
        { attribute: :lat, icon: '', options: { as: :hidden }, hidden: true },
        { attribute: :lng, icon: '', options: { as: :hidden }, hidden: true },
      ]
      ::Chillboarders::Cell::Form.(
        model, attributes: attributes, path: :spot, container_id:
        'spot_edit_container', card_class: 'user_card sign_up', submit_text:
        I18n.t('.misc.save'), context: context, background_image:
        spot.images.first, method: :patch)
    end

    def comments
      spot_comments = spot.comments.order(created_at: :desc)
      content_tag('div data-target="comment-list.commentList"') do
        cell(::Comment::Cell::Index, spot_comments, spot_id: spot.id).()
      end
    end

    def rating
      if !current_user || rating = Rating.find_by(spot_id: spot.id, user_id: current_user.id)
        cell(Rating::Cell::Show, nil, spot_id: spot.id).()
      else
        cell(Rating::Cell::Create, Rating.new, spot_id: spot.id).()
      end
    end

    def obstacles
      spot.obstacles.to_sentence
    end

    def leaflet_map
      javascript_tag <<-JAVASCRIPT

        var lat = #{spot.lat};
        var lng = #{spot.lng};
        var map = L.map('mapid').setView([lat, lng], 13);
        marker = L.marker([lat, lng]).addTo(map);

        L.tileLayer('https://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
      JAVASCRIPT
    end
  end
end