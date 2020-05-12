class UserSite < ApplicationRecord
  extend FriendlyId

  has_many_attached :images
  has_many_attached :videos

  has_many :comments
  belongs_to :user

  friendly_id :username, use: :slugged

  def username
    user.username
  end

  class << self
    def search_skater(params)
      username = params.dig('search', 'username')
      city = params.dig('search', 'city')

      self.joins(:user).where('username ILIKE ? AND city ILIKE ?', "%#{username}%", "%#{city}%")
    end
  end
end
