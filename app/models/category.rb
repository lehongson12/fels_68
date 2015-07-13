class Category < ActiveRecord::Base

  has_many :words, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  mount_uploader :picture, AvatarUploader

  private
  def picture_size
    errors.add :picture, t("category.picture_error") if picture.size > Settings.picture_size.megabytes  
  end

end
