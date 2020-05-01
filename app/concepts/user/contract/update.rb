require 'dry/validation'

class User::Contract::Update < Reform::Form
  include Dry::Validation

  property :email, writeable: false
  property :username, writeable: false
  property :avatar
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

  # property :password
  # property :password_confirmation, virtual: true
  # TODO: update password elsewhere
  # validate do
  #   if password.present? && password_confirmation.present?
  #     errors.add(:password, I18n.t('.activerecord.errors.models.user.attributes.password.not_the_same_passwords')) if password != password_confirmation
  #   end
  #   if password.present? && password_confirmation.blank?
  #     errors.add(:password_confirmation, I18n.t('.activerecord.errors.models.user.attributes.password.password_confirmation_empty'))
  #   end
  #   if password.blank? && password_confirmation.present?
  #     errors.add(:password_confirmation, I18n.t('.activerecord.errors.models.user.attributes.password.password_empty'))
  #   end
  # end
end