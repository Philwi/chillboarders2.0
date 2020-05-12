module User::Cell
  class Edit < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormOptionsHelper

    SKILL_LEVEL = %w[rookie beginner intermediate advanced pro].freeze
    # if new social media appears - adjust it in user model store accessor and in contract
    SOCIAL_MEDIA = %w[facebook instagram youtube].freeze

    def social_media_input
      SOCIAL_MEDIA.map do |media|
        { attribute: media, icon: 'people', options: { label: media.titleize } }
      end
    end

    def avatar?
      model.avatar.present?
    end

    def avatar_image
      avatar = model.avatar || "sign_in_image.jpg"
      image_tag(avatar, class: "img-fluid", alt: "Useravatar Image")
    end

    def form
      attributes = [
        { attribute: :email, icon: 'email', options: { required: true, autofocus: true, input_html: { autocomplete: "email" }, disabled: true }},
        { attribute: :username, icon: 'face', options: { required: true, disabled: true }},
        { attribute: :avatar, icon: 'image', options: { accept: "image/png,image/gif,image/jpeg" }},
        { attribute: :experience_level, icon: 'school', options: {collection: SKILL_LEVEL, include_blank: false, include_hidden: false, label_method: :camelcase }},
        { attribute: :city, icon: 'place', options: { }},
        { attribute: :description, icon: 'subject', options: { as: :text }},
        { attribute: :favourite_trick, icon: 'sports_esports', options: { }},
        { attribute: :social_media, icon: 'subject', options: { as: :hidden }, hidden: true}
      ] + social_media_input

      ::Chillboarders::Cell::Form.(
        model, attributes: attributes, path: :user_registration, container_id:
        'big_container', card_class: 'big_form_card', submit_text:
        I18n.t('.misc.save'), context: context, background_image: (model.avatar || "sign_in_image.jpg"), method: :patch)
    end
  end
end