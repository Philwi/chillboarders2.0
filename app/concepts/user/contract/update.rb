require 'dry/validation'

class User::Contract::Update < Reform::Form
  include Dry::Validation

  property :email
  property :password
  property :password_confirmation, virtual: true
  property :username

  validates :email, presence: true, format: { with: Rails.configuration.email_regex }
  validates :password, length: 6..50, presence: true
  validates :password_confirmation, presence: true
  validates :username, presence: true

  validate do
    if password.present? && password_confirmation.present?
      errors.add(:password, I18n.t('.activerecord.errors.models.user.attributes.password.not_the_same_passwords')) if password != password_confirmation
    end
  end

end