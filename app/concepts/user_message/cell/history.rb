module UserMessage::Cell
  class History < Trailblazer::Cell
    include ::Devise::Controllers::Helpers

    def user
      model[:user]
    end

    def user_messages
      if user = model[:user]
        UserMessage.where(user: user, for_user_id: current_user.id).or(UserMessage.where(user_id: current_user.id, for_user_id: user.id)).order(created_at: :desc)
      end
    end
  end
end