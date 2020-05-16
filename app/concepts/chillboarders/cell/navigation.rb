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
        { text: I18n.t('.navigation.spots'), path: :spots, class: 'nav-link', svg: 'svgs/spot.svg' },
        { text: I18n.t('.navigation.user_site.index'), path: :user_sites, svg: 'svgs/skaters.svg' },
      ].freeze

      SIGNED_IN_PATHS = [
        { text: I18n.t('.navigation.spot.new'), path: :new_spot, svg: 'svgs/spots.svg' },
        { text: I18n.t('.navigation.user_site.edit'), path: :edit_user_sites, svg: 'svgs/skater.svg' },
        { text: I18n.t('.navigation.user.edit'), path: :edit_user_registration, svg: 'svgs/edit.svg' },
        { text: I18n.t('.navigation.sign_out'), path: :destroy_user_session, svg: 'svgs/logout.svg' },
      ].freeze

      SIGNED_OUT_PATHS = [
        { text: I18n.t('.navigation.sign_up'), path: :new_user_registration, svg: 'svgs/signup.svg' },
        { text: I18n.t('.navigation.sign_in'), path: :new_user_session, svg: 'svgs/login.svg' },
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

      def signed_out_paths
        SIGNED_OUT_PATHS.map do |path|
          build_navigtion_link(path)
        end.join
      end

      def build_navigtion_link(path)
        content_tag(:li, class: 'nav-item') do
          link_to(path[:path], class: 'nav-link', title: path[:text], data: { toggle: 'tooltip', trigger: 'hover' }) do
            out = ''
            out.concat(
            content_tag(:div, class: 'svg d-inline') do
              image_tag(path[:svg])
            end)
            out.concat content_tag(:h5, path[:text], class: 'd-xl-none d-inline')
          end
        end
      end
    end
  end
end