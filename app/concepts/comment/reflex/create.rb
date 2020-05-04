# frozen_string_literal: true
module Comment::Reflex
  class Create < ApplicationReflex
    include ::Devise::Controllers::Helpers

    def form
      Comment.create(description: element['value'], user: current_user, spot: Spot.find(element.dataset['spot-id']))
    end
  end
end
