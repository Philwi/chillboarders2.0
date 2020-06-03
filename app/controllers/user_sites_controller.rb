class UserSitesController < ApplicationController

  def index
    meta_tags(title: 'Chillboarders - Skaters', description: 'List of all skaters at chillboarders', keywords: 'Skateboard, Skater, Users')
    @model ||= UserSite.search_skater(params).limit(6).order(:username)
    render html: cell(UserSite::Cell::Index, @model, params: params), layout: 'application'
  end

  def edit
    meta_tags(title: 'Chillboarders - Edit Skaters', description: 'Edit page for personal page of user', keywords: 'Skateboard, Skater, Users, Board')
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
    meta_tags(title: "Chillboarders - #{user_site.user.username} Board", description: 'Personal page of user', keywords: 'Skateboard, Skater, Users, Board, Usersite')
    if user_site
      render cell(UserSite::Cell::Show, user_site)
    else
      redirect_to root_path
    end
  end

  def modal_content
    @model = ActiveStorage::Attachment.find(params[:image])
  end

  def modal_close
  end
end
