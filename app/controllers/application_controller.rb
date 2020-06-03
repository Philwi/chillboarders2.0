class ApplicationController < ActionController::Base
  around_action :switch_locale
  around_action :set_locale_from_url

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def check_user
    if current_user.blank?
      flash[:alert] = I18n.t('.errors.messages.no_permission')
      redirect_to :new_user_session
    end
  end

  def meta_tags(title:, description:, keywords: nil)
    @meta_title = title
    @meta_description = description
    @meta_keywords = keywords
  end
end
