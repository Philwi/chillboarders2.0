class UserMessagesController < ApplicationController
  before_action :check_user

  def create
    result = UserMessage::Operation::Create.(params: params, user: current_user)
    if result.success?
      flash[:notice] = I18n.t('.flash.notice.user_messages')
    else
      flash[:alert] = I18n.t('.flash.error.user_messages')
    end
    redirect_to user_site_path(id: params[:user_message][:for_user_id] || result['model']&.for_user_id)
  end

  def index
    meta_tags(title: I18n.t('seo.controller.user_message.index.title'), description: I18n.t('seo.controller.user_message.index.description'), keywords: I18n.t('seo.controller.user_message.index.keywords'))
    @user ||= UserMessage.where(user_id: params[:user_id], for_user_id: current_user.id)
    render cell(UserMessage::Cell::Index, user: @user), layout: 'application'
  end

  def update
  end
end