require 'dry/validation'

class Spot::Contract::Update < Reform::Form
  include Dry::Validation

  property :title, writeable: false
  property :description, writeable: false
  property :type
  property :lat
  property :lng
  property :images
end