module Chillboarders
  module Cell
    class Navigation < Trailblazer::Cell
      include ::Cell::Slim
      include ::ActionView::Helpers::UrlHelper
      include ::ActionView::Helpers::TagHelper
      include ::ActionView::Helpers::TranslationHelper
      include ::Cell::Translation
      include ::ActionView::Helpers::AssetTagHelper
      include ::ActionView::Helpers::FormOptionsHelper
      include ::SimpleForm::ActionViewExtensions::FormHelper
      include ::Devise::Controllers::Helpers

      COMMON_PATHS = [
        { text: '.navigation.spots', path: :spots, class: 'nav-link', svg: 'svgs/spot.svg' },
        { text: '.navigation.user_site.index', path: :user_sites, svg: 'svgs/skaters.svg' },
        { text: '.navigation.news', path: :rss_feeds, svg: 'svgs/news.svg' }
      ].freeze

      SIGNED_IN_PATHS = [
        { text: '.navigation.spot.new', path: :new_spot, svg: 'svgs/spots.svg' },
        { text: '.navigation.settings', path: :settings, svg: 'svgs/settings.svg' },
        { text: '.navigation.messages', path: :user_messages, svg: 'svgs/message.svg' },
      ].freeze

      SIGNED_OUT_PATHS = [
        { text: '.navigation.sign_up', path: :new_user_registration, svg: 'svgs/signup.svg' },
        { text: '.navigation.sign_in', path: :new_user_session, svg: 'svgs/login.svg' },
      ].freeze

      LANGUAGES = [
        { language: 'Deutsch', locale: 'de', flag: 'flags/germany.svg' },
        { language: 'English', locale: 'en', flag: 'flags/england.svg' },
      ].freeze

      def signed_in?
        options[:current_user].present?
      end

      def common_paths
        COMMON_PATHS.map do |path|
          build_navigtion_link(path)
        end.join
      end

      def signed_in_paths
        SIGNED_IN_PATHS.map do |path|
          build_navigtion_link(path)
        end.join
      end

      def my_board_site
        path = { text: '.navigation.user_site.show', path: user_site_path(current_user.user_site), svg: 'svgs/myboard.svg' }
        build_navigtion_link(path)
      end

      def notifications
        path = { text: '.navigation.notifications', path: :destroy_user_session, svg: 'svgs/notifications.svg' }
        # data-reflex-root muss ersetzt werden, sonst wird zu viel gerendet
        content_tag(:div, class: 'notification') do
          out = ''
          out.concat(
            content_tag(:li, class: 'nav-item') do
              inner = ''
              inner.concat(content_tag(:a, class: 'nav-link', title: I18n.t(path[:text]), data: { toggle: 'dropdown' }) do
                inner_nav = ''
                inner_nav.concat(
                content_tag(:div, class: 'svg d-inline') do
                  image_tag(path[:svg])
                end)
                inner_nav.concat content_tag(:h5, I18n.t(path[:text]), class: 'd-xl-none d-inline notification-badge')
              end)
              inner.concat(content_tag(:ul, class: 'dropdown-menu notification-list') do
                if user_notifications.blank?
                  content_tag(:li, I18n.t('.notifications.empty'),class: 'list-group-item list-group-item-action')
                else
                  user_notifications.map do |notification|
                    user = User.find_by(id: notification.from_user_id)
                    spot = notification.spot
                    content_tag(:li, class: 'list-group-item list-group-item-action') do
                      notification_out = ''
                      notification_out.concat image_tag(Chillboarders::Util::Navigation::NOTIFICATION_IMAGE[notification.type], class: 'notification_image d-inline')
                      notification_out.concat content_tag(:small, I18n.t(".notifications.#{notification.type}", user: user.username, spot: spot&.title), class: 'd-inline')
                      notification_out.concat check_box_tag("mark_as_read_#{notification.id}", false, false, value: '', class: 'mark_as_read d-inline', data: { reflex: 'change->Notification::Reflex::Update#mark_as_seen', notification_id: notification.id})
                    end
                  end.join
                end
              end)
            end)
          out.concat content_tag(:span, user_notifications.count, class: 'badge badge-dark notification-alert')
        end
      end

      def user_notifications
        Notification.where(user: current_user, seen: false)
      end

      def signed_out_paths
        SIGNED_OUT_PATHS.map do |path|
          build_navigtion_link(path)
        end.join
      end

      def build_navigtion_link(path)
        content_tag(:li, class: 'nav-item') do
          link_to(path[:path], class: 'nav-link', title: I18n.t(path[:text]), data: { toggle: 'tooltip', trigger: 'hover' }) do
            out = ''
            out.concat(
            content_tag(:div, class: 'svg d-inline') do
              image_tag(path[:svg])
            end)
            out.concat content_tag(:h5, I18n.t(path[:text]), class: 'd-xl-none d-inline')
          end
        end
      end

      def switch_locale
        actual_locale_data = LANGUAGES.find { |language| language[:locale] == I18n.locale.to_s }
        content_tag(:div, class: 'locale-switcher') do
          out =''
          out.concat(content_tag(:button, class: 'btn btn-light', data: { toggle: 'dropdown' }) do
            inner = ''
            inner.concat image_tag(actual_locale_data[:flag], width: '15', height: '15')
            inner.concat content_tag(:span, actual_locale_data[:locale].upcase, class: 'country-flag')
            inner.concat content_tag(:i, 'arrow_drop_down', class: 'material-icons')
          end)
          out.concat(content_tag(:ul, class: 'dropdown-menu') do
            LANGUAGES.map do |language|
              content_tag(:li) do
                link_to("/#{language[:locale]}") do
                  inner = ''
                  inner.concat image_tag(language[:flag], width: '15', height: '15')
                  inner.concat content_tag(:p, language[:language])
                end
              end
            end.join
          end)
        end
      end
    end
  end
end