class UserSitesController < ApplicationController

  def index
    meta_tags(title: I18n.t('seo.controller.user_site.index.title'), description: I18n.t('seo.controller.user_site.index.description'), keywords: I18n.t('seo.controller.user_site.index.keywords'))
    @model ||= UserSite.search_skater(params).first(6)
    render html: cell(UserSite::Cell::Index, @model, params: params), layout: 'application'
  end

  def edit
    meta_tags(title: I18n.t('seo.controller.user_site.edit.title'), description: I18n.t('seo.controller.user_site.edit.description'), keywords: I18n.t('seo.controller.user_site.edit.keywords'))
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
    meta_tags(title: I18n.t('seo.controller.user_site.show.title', username: user_site.user.username), description: I18n.t('seo.controller.user_site.show.description', username: user_site.user.username), keywords: I18n.t('seo.controller.user_site.show.keywords'))
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
