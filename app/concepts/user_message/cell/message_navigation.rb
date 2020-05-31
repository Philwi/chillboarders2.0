module UserMessage::Cell
  class MessageNavigation < Trailblazer::Cell
    include ::Devise::Controllers::Helpers
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormOptionsHelper

    def messages
      ary = []
      UserMessage.where(for_user_id: current_user.id).order(created_at: :desc).each do |message|
        next if ary.find { |a| a.user_id == message.user_id }
        ary << message
      end
      ary.compact
    end

    def user_image(message)
      if message.user.avatar.present?
        message.user.avatar
      else
        'sign_in_image.jpg'
      end
    end
  end
end