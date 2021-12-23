class Event < ApplicationRecord
  has_one_attached :picture
  validate :picture, :picture_content_type
  validates :name, presence: true

  has_many :event_users
  has_many :users, through: :event_users

  private

  def picture_content_type
    return true unless self&.picture&.attached?
    if ["image/jpeg", "image/png"].include? self.picture.content_type
      return true
    else
      errors.add(:picture, "Invalid Content Type")
      return false
    end
  end
end
