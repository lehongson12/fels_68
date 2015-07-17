class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results

  accepts_nested_attributes_for :answers, allow_destroy: true,
                          reject_if: proc { |a| a[:content].blank? }
  validates :content, presence: true, uniqueness: true
  validate :check_correct_answer

  scope :search, ->content{where("content LIKE ?", "#{content}%" ) if content.present? }
  scope :filter_category, ->category{where category: category if category.present?}
  scope :learned, ->user{where("id IN (SELECT word_id FROM results WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id=?))", user.id)}
  scope :not_learned, ->user{where("id NOT IN (SELECT word_id FROM results WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id=?))", user.id)}
  scope :get_all, ->user{}
  scope :random_words, ->{order "RANDOM() LIMIT #{Settings.lesson.limit_words}"}

  private
  def check_correct_answer
    errors.add :base, I18n.t("errors.not_choice_correct") if answers.select{|opt| opt.is_correct}.blank?
  end
end
