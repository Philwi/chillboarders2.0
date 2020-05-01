class Spot < ApplicationRecord
  extend FriendlyId
  self.inheritance_column = nil

  # Associations
  belongs_to :user
  has_many_attached :images

  friendly_id :title, use: :slugged
end
