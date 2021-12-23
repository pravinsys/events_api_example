class User < ApplicationRecord
  has_secure_password
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  has_many :event_users
  has_many :events, through: :event_users


  def self.current_user
    Thread.current[:user]
  end

  def self.current_user=(newUser)
    Thread.current[:user] = newUser
  end

end
