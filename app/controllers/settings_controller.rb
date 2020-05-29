class SettingsController < ApplicationController
  before_action :check_user, only: [:index]

  def index
    render html: concept(Settings::Cell::Index), layout: 'application'
  end
end