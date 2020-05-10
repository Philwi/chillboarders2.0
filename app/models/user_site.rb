class UserSite < ApplicationRecord
  has_many_attached :images
  has_many_attached :videos

  has_many :comments
  belongs_to :user
end
