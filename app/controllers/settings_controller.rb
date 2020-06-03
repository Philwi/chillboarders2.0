class SettingsController < ApplicationController
  before_action :check_user, only: [:index]

  def index
    meta_tags(title: 'Chillboarders - Settings', description: 'Page for user settings', keywords: '')
    render html: concept(Settings::Cell::Index), layout: 'application'
  end
end