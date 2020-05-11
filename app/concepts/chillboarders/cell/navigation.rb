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

      SIGNED_IN_PATHS = [
        { text: I18n.t('.navigation.spot.new'), path: :new_spot},
        { text: I18n.t('.navigation.user_site.index'), path: :user_sites},
        { text: I18n.t('.navigation.user_site.edit'), path: :edit_user_sites},
        { text: I18n.t('.navigation.user.edit'), path: :edit_user_registration },
        { text: I18n.t('.navigation.sign_out'), path: :destroy_user_session },
      ].freeze

      SIGNED_OUT_PATHS = [
        { text: I18n.t('.navigation.sign_up'), path: :new_user_registration },
        { text: I18n.t('.navigation.sign_in'), path: :new_user_session },
      ].freeze

      def signed_in?
        options[:current_user].present?
      end

      def signed_in_paths
        SIGNED_IN_PATHS.map do |path|
          link_to(path[:text], path[:path], class: 'nav-link')
        end.join
      end

      def signed_out_paths
        SIGNED_OUT_PATHS.map do |path|
          link_to(path[:text], path[:path], class: 'nav-link')
        end.join
      end

      def avatar
        avatar_image =
          if options[:current_user].avatar.present?
            options[:current_user].avatar
          else
            'sign_in_image'
          end
        image_tag(avatar_image, class: "img-fluid", alt: "Useravatar Image", style: 'height: 2em; width: 2em;')
      end
    end
  end
end