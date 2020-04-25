module Chillboarders
  module Cell
    class Navigation < Trailblazer::Cell
      include ::Cell::Slim
      include ::ActionView::Helpers::UrlHelper

      def signed_in?
        options[:current_user].present?
      end

    end
  end
end