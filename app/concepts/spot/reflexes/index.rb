
# frozen_string_literal: true

module Spot::Reflexes
  class Index < ApplicationReflex
    # Add Reflex methods in this file.
    #
    # All Reflex instances expose the following properties:
    #
    #   - connection - the ActionCable connection
    #   - channel - the ActionCable channel
    #   - request - an ActionDispatch::Request proxy for the socket connection
    #   - session - the ActionDispatch::Session store for the current visitor
    #   - url - the URL of the page that triggered the reflex
    #   - element - a Hash like object that represents the HTML element that triggered the reflex
    #
    # Example:
    #
    #   def example(argument=true)
    #     # Your logic here...
    #     # Any declared instance variables will be made available to the Rails controller and view.
    #   end
    #
    # Learn more at: https://docs.stimulusreflex.com

    def spots
      begin
        bounds = eval(CGI::escapeHTML(element[:value]))
        if bounds.is_a?(Array)
          @bounds = bounds
        else
          raise ArgumentError
        end
      rescue => e
        Rails.logger.error e, 'Wrong format in spot reflex'
      end
    end
  end
end
