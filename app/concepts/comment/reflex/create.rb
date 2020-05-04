# frozen_string_literal: true
module Comment::Reflex
  class Create < ApplicationReflex
    include ::Devise::Controllers::Helpers

    def form
      binding.pry
      result = ::Comment::Operation::Create.(params: element, user: current_user)
    end
  end
end
