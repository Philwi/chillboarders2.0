class UserSitesController < ApplicationController
  def edit
    @model = UserSite::Operation::Create::Present.(params: nil)['model']
    render html: cell(UserSite::Cell::New, @model), layout: 'application'
  end

  def update
  end

  def show
  end
end
