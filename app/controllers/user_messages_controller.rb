class UserMessagesController < ApplicationController

  def create
    result = UserMessage::Operation::Create.(params: params, user: current_user)
    if result.success?
      flash[:notice] = I18n.t('.flash.notice.user_messages')
    else
      flash[:alert] = I18n.t('.flash.error.user_messages')
    end
    redirect_to user_site_path(id: params[:user_message][:for_user_id])
  end

  def update
  end
end