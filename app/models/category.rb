class Category < ActiveRecord::Base

  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  accepts_nested_attributes_for :words, allow_destroy: true,
                            reject_if: proc { |a| a[:content].blank? }
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  mount_uploader :picture, AvatarUploader

  private
  def picture_size
    errors.add :picture, t("category.picture_error") if picture.size > Settings.picture_size.megabytes  
  end

end
