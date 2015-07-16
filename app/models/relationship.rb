class Relationship < ActiveRecord::Base
  include ActivityLog
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  after_save :create_follow_activity
  before_destroy :create_unfollow_activity

  private
  def create_follow_activity
    create_activity follower_id, followed_id, Settings.activities.followed
  end

  def create_unfollow_activity
    create_activity follower_id, followed_id, Settings.activities.unfollowed
  end

end
