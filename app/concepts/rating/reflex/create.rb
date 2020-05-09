# frozen_string_literal: true
module Rating::Reflex
  class Create < ApplicationReflex
    include ::Devise::Controllers::Helpers

    def stars
      rating = element[:class].split('-').last.to_i
      Rating.create(rating: rating, user: current_user, spot_id: element.dataset['spot-id'])
      @spots = Spot.where(id: JSON.parse(element.dataset['spots'])) if element.dataset['spots']
    end
  end
end
