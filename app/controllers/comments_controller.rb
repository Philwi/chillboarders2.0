class CommentsController < ApplicationController
  def create
    result = ::Comment::Operation::Create.(params: params, user: current_user)
    if result.success?
      redirect_to spots_path
    else
      render cell(Comment::Cell::Create, result['contract.default'])
    end
  end
end
