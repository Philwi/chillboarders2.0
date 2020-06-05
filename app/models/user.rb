class User < ApplicationRecord
  store_accessor :social_media, :facebook, :instagram, :youtube

  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# doesnt work actually, uncomment me if you have an own domain
#:confirmable, :lockable, :trackable

  friendly_id :username, use: :slugged

  # Associations
  has_one_attached :avatar
  has_many :spots
  has_many :comments
  has_many :ratings
  has_many :user_messages
  has_many :notifications
  has_one :user_site
end
