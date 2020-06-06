class SpotsController < ApplicationController
  before_action :check_user, only: [:create, :update, :new]

  def index
    meta_tags(title: I18n.t('seo.controller.spot.index.title'), description: I18n.t('seo.controller.spot.index.description'), keywords: I18n.t('seo.controller.spot.index.keywords'))
    # @bounds
    # => [[51.1356318430504, 13.931694030761719], [50.962967825970956, 13.544425964355469]]
    @spots ||=
      if @bounds
        Spot.where('lat BETWEEN ? AND ? AND lng BETWEEN ? AND ?', @bounds.second.first, @bounds.first.first, @bounds.second.second, @bounds.first.second)
      else
        Spot.all
      end
    render html: cell(Spot::Cell::Index, @spots, params: params), layout: 'application'
  end

  def new
    meta_tags(title: I18n.t('seo.controller.spot.new.title'), description: I18n.t('seo.controller.spot.new.description'), keywords: I18n.t('seo.controller.spot.new.keywords'))
    @model = Spot::Operation::Create::Present.(params: nil)['model']
    render html: cell(Spot::Cell::Create, @model), layout: 'application'
  end

  def create
    result = Spot::Operation::Create.call(params: params.permit!, user: current_user)
    if result.success?
      return redirect_to edit_spot_path(result['model'].id)
    else
      render cell(Spot::Cell::Create, result['contract.default'].to_model)
    end
  end

  def edit
    @model = Spot::Operation::Update::Present.(params: params, user: current_user)['model']
    meta_tags(title: I18n.t('seo.controller.spot.edit.title', title: @model.title), description: I18n.t('seo.controller.spot.edit.description', description: @model.description), keywords: I18n.t('seo.controller.spot.edit.keywords'))
    render html: cell(Spot::Cell::Edit, @model), layout: 'application'
  end

  def update
    result = Spot::Operation::Update.call(params: params.permit!, user: current_user)
    if result.success?
      return redirect_to edit_spot_path(result['model'].id)
    else
      render cell(Spot::Cell::Edit, result['contract.default'])
    end
  end
end
