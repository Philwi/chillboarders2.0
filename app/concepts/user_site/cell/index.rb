module UserSite::Cell
  class Index < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper

    def image(user_site)
      avatar_image =
        if user_site.user.avatar.present?
          user_site.user.avatar.variant(resize_to_limit: [350, 350])
        else
          'sign_in_image.jpg'
        end
      image_tag(avatar_image, class: "img-fluid", alt: "Useravatar Image")
    end

    def params
      options.dig(:params).to_json
    end

    def user_sites_left
      if params
        UserSite.search_skater(JSON.parse params).count > model.count
      else
        UserSite.count > model.count
      end
    end
  end
end