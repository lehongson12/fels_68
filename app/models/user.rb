class User < ActiveRecord::Base
  enum role: [:user, :mod, :admin]
  after_initialize :set_default_role, if: :new_record?
  
  attr_accessor :remember_token

  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower                               
  
  validates :name,  presence: true, length:  {maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 } ,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false	}  
  has_secure_password
  validates :password, length:  {minimum: 6} , allow_blank: true
  mount_uploader :avatar, AvatarUploader
  validate  :avatar_size
  
  # Returns the hash digest of the given string.
  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end
  # Unfollows a user.
  
  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def feed
    Activity.followed self
  end


  def following? other_user
    following.include? other_user
  end
  
  private

  # Validates the size of an uploaded picture.
  def avatar_size
    errors.add :avatar, t("edit_user.avatar_error") if avatar.size > Settings.avatar_size.megabytes
  end

  def set_default_role
    self.role ||= :user
  end
end
