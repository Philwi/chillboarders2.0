require 'dry/validation'

module UserSite::Contract
  class Update < Reform::Form
    include Dry::Validation
  end
end