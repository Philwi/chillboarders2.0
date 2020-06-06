class SettingsController < ApplicationController
  before_action :check_user, only: [:index]

  def index
    meta_tags(title: I18n.t('seo.controller.setting.index.title'), description: I18n.t('seo.controller.setting.index.description'), keywords: I18n.t('seo.controller.setting.index.keywords'))
    render html: concept(Settings::Cell::Index), layout: 'application'
  end
end