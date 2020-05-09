require 'dry/validation'

class User::Contract::Update < Reform::Form
  include Dry::Validation

  property :email, writeable: false
  property :username, writeable: false
  property :avatar, writeable: false
  property :experience_level
  property :city
  property :country
  property :description
  property :favourite_trick
  property :social_media
  property :youtube
  property :instagram
  property :facebook

  def social_media=(value)
    hash = {}
    User::Cell::Edit::SOCIAL_MEDIA.each do |media|
      hash.merge(media => self.try(media))
    end
    super hash
  end
end
