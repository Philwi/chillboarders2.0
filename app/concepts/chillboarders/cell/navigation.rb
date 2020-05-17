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
      ].freeze

      SIGNED_IN_PATHS = [
        { text: '.navigation.spot.new', path: :new_spot, svg: 'svgs/spots.svg' },
        { text: '.navigation.user_site.edit', path: :edit_user_sites, svg: 'svgs/skater.svg' },
        { text: '.navigation.user.edit', path: :edit_user_registration, svg: 'svgs/edit.svg' },
        { text: '.navigation.sign_out', path: :destroy_user_session, svg: 'svgs/logout.svg' },
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
            out.concat content_tag(:h5, path[:text], class: 'd-xl-none d-inline')
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