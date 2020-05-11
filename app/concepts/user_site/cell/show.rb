module UserSite::Cell
  class Show < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::ActionView::Helpers::JavaScriptHelper

    def user_avatar
      avatar_image =
        if user.avatar.present?
          user.avatar
        else
          'sign_in_image.jpg'
        end
      image_tag(avatar_image, class: 'myskate-user-image')
    end

    def primary_color
      model.primary_color
    end

    def secondary_color
      model.secondary_color
    end

    def tertiary_color
      model.tertiary_color
    end

    def user
      @user ||= model.user
    end

    def images
      model.images.map do |image|
        content_tag(:div, class: 'col-lg-4') do
          image_tag(image, class: 'img-fluid')
        end
      end.join
    end

    def music_player
      content_tag(:div, class: 'music_player') do
        model.embedded_music_player_html
      end
    end

    def comments
      site_comments = Comment.where(user_site: model).order(created_at: :desc)
      out = ''
      out.concat(content_tag('div data-target="comment-list.commentList"') do
        cell(::Comment::Cell::Index, site_comments, user_site_id: model.id).()
      end)
    end

  end
end