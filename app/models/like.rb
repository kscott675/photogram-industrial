# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :bigint           not null
#  photo_id   :bigint           not null
#
# Indexes
#
#  index_likes_on_fan_id    (fan_id)
#  index_likes_on_photo_id  (photo_id)
#
# Foreign Keys
#
#  fk_rails_...  (fan_id => users.id)
#  fk_rails_...  (photo_id => photos.id)
#
class Like < ApplicationRecord
  belongs_to :fan, class_name: "User"
  
  belongs_to :photo, class_name: "Photo", foreign_key: :photo_id, counter_cache: true

  has_many :likes, foreign_key: :fan_id, dependent: :destroy

  validates :fan_id, uniqueness: { scope: :photo_id, message: "has already liked this photo" }
end
