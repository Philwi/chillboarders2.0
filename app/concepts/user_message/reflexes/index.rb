module UserMessage::Reflexes
  class Index < ApplicationReflex
    include ::Devise::Controllers::Helpers

    def get_history
      user_id = element.dataset['user-id']
      user_messages = UserMessage.where(user_id: user_id, for_user_id: current_user.id)
      user_messages.update_all(read: true)
      @user = User.find_by(id: user_id)
    end

    def create
      params = ActionController::Parameters.new({
        user_message: {
          body: element['value'],
          for_user_id:  element.dataset['for-user-id'].to_i,
        }
      })
      UserMessage::Operation::Create.(params: params, user: current_user)
      @user = User.find_by(id: element.dataset['for-user-id'])
    end
  end
end
