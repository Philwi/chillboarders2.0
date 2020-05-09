class Spot < ApplicationRecord
  extend FriendlyId
  self.inheritance_column = nil

  # Associations
  belongs_to :user
  has_many_attached :images
  has_many :comments
  has_many :ratings

  friendly_id :title, use: :slugged
end
