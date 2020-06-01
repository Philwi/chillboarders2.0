module Chillboarders::Contract::Contact
  class Create < Reform::Form
    property :email
    property :name
    property :body

    validates :email, presence: true, format: { with: Rails.configuration.email_regex }
    validates :body, presence: true, length: 6..5000
  end
end