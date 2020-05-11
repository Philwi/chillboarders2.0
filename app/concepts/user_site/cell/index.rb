module UserSite::Cell
  class Index < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper

    def image(user_site)
      avatar_image =
        if user_site.user.avatar.present?
          user_site.user.avatar
        else
          'sign_in_image.jpg'
        end
      image_tag(avatar_image, class: "img-fluid", alt: "Useravatar Image")
    end
  end
end