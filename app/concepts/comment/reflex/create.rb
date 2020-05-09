# frozen_string_literal: true
module Comment::Reflex
  class Create < ApplicationReflex
    include ::Devise::Controllers::Helpers

    def form
      Comment.create(description: element['value'], user: current_user, spot: Spot.find(element.dataset['spot-id']))
      if element.dataset['spots']
        ids = JSON.parse(element.dataset['spots']).map { |spot| spot['id'] }
        @spots = Spot.where(id: ids)
      end
    end
  end
end
