class LandingController < ApplicationController
  def index
    render html: concept(Landing::Cell::Index), layout: 'application'
  end
end