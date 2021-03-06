require "cell/partial"
module UserSite::Cell
  class Show < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::ActionView::Helpers::JavaScriptHelper
    include ::Devise::Controllers::Helpers

    def user_avatar
      avatar_image =
        if user.avatar.present?
          user.avatar
        else
          'sign_in_image.jpg'
        end
      image_tag(avatar_image, class: 'myskate-user-image')
    end

    def users_site
      current_user == user
    end

    def primary_color
      model&.primary_color
    end

    def secondary_color
      model&.secondary_color
    end

    def tertiary_color
      model&.tertiary_color
    end

    def user
      @user ||= model&.user
    end

    def images
      model&.images.map do |image|
        content_tag(:div, class: 'col-lg-4') do
          link_to(modal_content_user_sites_path(image: image), remote: true, data: {toggle: "modal", target: "#imageModal"}) do
            out = ''
            out.concat image_tag(image, class: 'img-fluid')
            out.concat(content_tag(:div, class: 'image-hover-text') do
              content_tag(:ul) do
                inner = ''
                inner.concat content_tag(:li, Comment.where(active_storage_attachments_id: image.id).count.to_s)
                inner.concat content_tag(:li, content_tag(:i, 'message', class: 'material-icons'))
              end
            end)
          end
        end
      end.join
    end

    def music_player
      content_tag(:div, class: 'music_player') do
        model&.embedded_music_player_html
      end
    end

    def comments
      site_comments = Comment.where(user_site: model).order(created_at: :desc)
      out = ''
      out.concat(content_tag('div data-target="comment-list.commentList"') do
        cell(::Comment::Cell::Index, site_comments, user_site_id: model&.id).()
      end)
    end

    def social_media
      content_tag(:div, class: 'social_media') do
        content_tag(:div, class: 'row') do
          out = ''
          out.concat facebook || ''
          out.concat youtube || ''
          out.concat instagram || ''
        end
      end
    end

    def facebook
      if user.facebook.present?
        content_tag(:div, class: 'col-md') do
          link_to(facebook_url(user: user), target: :_blank) do
            image_tag('social_media/f_icon.png')
          end
        end
      end
    end

    def instagram
      if user.instagram.present?
        content_tag(:div, class: 'col-md') do
          link_to(instagram_url(user: user), target: :_blank) do
            image_tag('social_media/ig_icon.png')
          end
        end
      end
    end

    def youtube
      if user.youtube.present?
        content_tag(:div, class: 'col-md') do
          link_to(youtube_url(user: user), target: :_blank) do
            image_tag('social_media/yt_icon.png')
          end
        end
      end
    end

    def instagram_url(user: user)
      if user.instagram.include?('http')
        user.instagram
      else
        "https://www.instagram.com/#{user.instagram}/"
      end
    end

    def facebook_url(user: user)
      if user.facebook.include?('http')
        user.facebook
      else
        "https://www.facebook.com/#{user.facebook}"
      end
    end

    def youtube_url(user: user)
      if user.youtube.include?('http')
        user.youtube
      else
        "https://www.youtube.com/channel/#{user.youtube}"
      end
    end

  end
end