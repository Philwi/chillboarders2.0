require 'dry/validation'

class Comment::Contract::Create < Reform::Form
  include Dry::Validation

  property :description
  property :spot_id, writeable: false

  validates :description, presence: true, length: 6..5000
  validates :spot_id, presence: true
end