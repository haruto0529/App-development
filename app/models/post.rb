class Post < ApplicationRecord
  enum category: { skateboarding: 0, snowboarding: 1, surfing: 2 }

  mount_uploader :image_url, ImageUrlUploader
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :category, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["title", "image_introduce"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def liked_by?(user)
    likes.exists?(user_id : user.id)
  end
end
