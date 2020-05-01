module User::Cell
  class Edit < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include SimpleForm::ActionViewExtensions::FormHelper

    SKILL_LEVEL = %w[rookie beginner intermediate advanced pro].freeze
    # if new social media appears - adjust it in user model store accessor and in contract
    SOCIAL_MEDIA = %w[facebook instagram youtube].freeze

    def social_media_input(f)
      SOCIAL_MEDIA.map do |media|
        f.input media, label: media.titleize
      end.join
    end

    def avatar?
      model.avatar.present?
    end

    def avatar_image
      avatar = model.avatar || "sign_in_image.jpg"
      image_tag(avatar, class: "img-fluid", alt: "Useravatar Image")
    end
  end
end