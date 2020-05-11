class UserSitesController < ApplicationController

  def index
    model = UserSite.all.includes(:user)
    render html: cell(UserSite::Cell::Index, model), layout: 'application'
  end

  def edit
    @model = UserSite::Operation::Update::Present.(params: nil, user: current_user)['model']
    render html: cell(UserSite::Cell::Edit, @model), layout: 'application'
  end

  def update
    result = UserSite::Operation::Update.call(params: params, user: current_user)
    if result.success?
      redirect_to user_site_url(id: result['model'].id)
    else
      render cell(UserSite::Cell::Edit, result['contract.default'])
    end
  end

  def show
    user_site = UserSite.find(params[:id])
    render cell(UserSite::Cell::Show, user_site)
  end
end
