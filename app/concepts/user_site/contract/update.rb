require 'dry/validation'

module UserSite::Contract
  class Update < Reform::Form
    include Dry::Validation

    property :headline
    property :text
    property :tricks
    property :embedded_music_player_html
    property :primary_color
    property :secondary_color
    property :tertiary_color

    validates :headline, presence: true
    validates :text, presence: true
    validates :primary_color, presence: true
    validates :secondary_color, presence: true
    validates :tertiary_color, presence: true
  end
end