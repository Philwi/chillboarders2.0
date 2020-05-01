require 'dry/validation'

class Spot::Contract::Create < Reform::Form
  include Dry::Validation

  property :title
  property :description
  property :type
  property :lat
  property :lng
  property :images

  validates :title, presence: true, length: 6..50
  validates :description, presence: true, length: 6..5000
  validates :lng, presence: true
  validates :lat, presence: true
  validates :images, presence: true
end