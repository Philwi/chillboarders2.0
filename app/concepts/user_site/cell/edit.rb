module UserSite::Cell
  class Edit < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include SimpleForm::ActionViewExtensions::FormHelper

    # hier noch die scheiße mit den Tricks als Constante
    def form
      attributes = [
        { attribute: :headline, icon: 'view_headline', options: { }},
        { attribute: :text, icon: 'subject', options: { as: :text }},
        { attribute: :primary_color, icon: 'colorize', options: { as: :color }},
        { attribute: :secondary_color, icon: 'colorize', options: { as: :color }},
        { attribute: :tertiary_color, icon: 'colorize', options: { as: :color }},
        { attribute: :embedded_music_player_html, icon: 'audiotrack', options: { as: :text }},
        { attribute: :images, icon: 'photo', type: :attachment, options: { multiple: true, class: 'form-control', accept: "image/png,image/gif,image/jpeg" } },
        { attribute: :videos, icon: 'ondemand_video', type: :attachment, options: { multiple: true, class: 'form-control', accept: "video/mp4,video/x-m4v,video/*" } },
        #{ attribute: :tricks, icon: 'menu_book', type: :select, options: { collection: ::Chillboarders::Util::Constants::SKATEBOARD_TRICKS, include_blank: false, include_hidden: false, label_method: :titleize, as: :check_boxes, label: false, input_html: { multiple: true }}},
      ]

      ::Chillboarders::Cell::Form.(
        model, attributes: attributes, path: :user_sites, container_id:
        'big_container', card_class: 'big_form_card', submit_text:
        I18n.t('.misc.save'), context: context, background_image: (model&.images&.first || "sign_in_image.jpg"), method: :patch)
    end
  end
end