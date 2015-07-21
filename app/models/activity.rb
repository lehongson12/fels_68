class Activity < ActiveRecord::Base
  belongs_to :user 
  scope :recent, -> { order "created_at DESC" }
  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
  scope :followed, ->user{where "user_id IN (#{following_ids}) OR user_id = ?", user.id}
  
  validates :user_id, presence: true 
  validates :target_id, presence: true
  
  def target
    type_action == Settings.activities.learned ? Lesson.find_by(id: target_id) : User.find_by(id: target_id)  
  end
end
