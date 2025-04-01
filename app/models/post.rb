class Post < ApplicationRecord
  mount_uploader :image_url, ImageUrlUploader
  belongs_to :user
end
