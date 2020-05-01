class SpotsController < ApplicationController

  def index
    @spots = Spot.all
    render html: cell(Spot::Cell::Index, @spots, params: params), layout: 'application'
  end

  def new
    @model = Spot::Operation::Create::Present.(params: nil)['model']
    render html: cell(Spot::Cell::Create, @model), layout: 'application'
  end

  def create
    result = Spot::Operation::Create.call(params: params.permit!, user: current_user)
    if result.success?
      return redirect_to edit_spot_path(result['model'].id)
    else
      render cell(Spot::Cell::Create, result['contract.default'])
    end
  end

  def edit
    @model = Spot::Operation::Update::Present.(params: params, user: current_user)['model']
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
