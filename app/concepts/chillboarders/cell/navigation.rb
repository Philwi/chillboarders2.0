module Chillboarders
  module Cell
    class Navigation < Trailblazer::Cell
      include ::Cell::Slim
      include ::ActionView::Helpers::UrlHelper
      include ::ActionView::Helpers::TagHelper
      include ActionView::Helpers::TranslationHelper
      include ::Cell::Translation

      SIGNED_IN_PATHS = [
        { text: I18n.t('.navigation.sign_out'), path: :destroy_user_session },
        { text: I18n.t('.navigation.user.edit'), path: :edit_user_registration },
      ]

      SIGNED_OUT_PATHS = [
        { text: I18n.t('.navigation.sign_up'), path: :new_user_registration },
        { text: I18n.t('.navigation.sign_in'), path: :new_user_session },
      ]

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
    end
  end
end