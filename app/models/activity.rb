class Activity < ActiveRecord::Base
  belongs_to :user 
  scope :recent, -> { order "created_at DESC" }
  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
  scope :followed, -> user{ where "user_id IN (# { following_ids }) OR user_id = ?", user.id}
  def target
    User.find target_id
  end
end
