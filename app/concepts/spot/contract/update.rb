require 'dry/validation'

class Spot::Contract::Update < Reform::Form
  include Dry::Validation

  property :title, writeable: false
  property :description, writeable: false
  property :type
  property :obstacles
  property :lat
  property :lng
  property :images

  validates :lng, presence: true
  validates :lat, presence: true
  validates :obstacles, presence: true
  validates :type, presence: true
  validates :images, presence: true
end