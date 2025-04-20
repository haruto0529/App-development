class Post < ApplicationRecord
  mount_uploader :image_url, ImageUrlUploader
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["title", "image_introduce"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
