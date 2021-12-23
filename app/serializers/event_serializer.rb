class EventSerializer < ActiveModel::Serializer

  attributes :id, :name, :description, :start_date, :end_date, :picture_url
  has_many :users

  def picture_url
    event = self.object
    return nil unless event&.picture&.attached?
    Rails.application.routes.url_helpers.rails_blob_url(event.picture, only_path: true)
  end
end
