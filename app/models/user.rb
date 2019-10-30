class User < ApplicationRecord
  validates :name, presence: true

  def self.find_or_create_from_omniauth(auth)
    user = where(provider: auth[:provider], uid: auth[:uid]).first_or_create
    user.update(name: auth[:info][:name])
    user
  end
end
