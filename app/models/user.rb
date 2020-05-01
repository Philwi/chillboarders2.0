class User < ApplicationRecord
  store_accessor :social_media, :facebook, :instagram, :youtube

  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  friendly_id :username, use: :slugged

  # Associations
  has_one_attached :avatar
  has_many :spots
end
