class UserSitesController < ApplicationController

  def index
    @model ||= UserSite.search_skater(params).limit(6).order(:username)
    render html: cell(UserSite::Cell::Index, @model, params: params), layout: 'application'
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
    user_site = UserSite.find_by(slug: params[:id]) || UserSite.find_by(id: params[:id])
    render cell(UserSite::Cell::Show, user_site)
  end

  def modal_content
    @model = ActiveStorage::Attachment.find(params[:image])
  end

  def modal_close
  end
end
