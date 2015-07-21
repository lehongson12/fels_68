class Lesson < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results

  after_create :init_words
  before_save :update_correct_num

  after_save :save_activity

  scope :learning_lesson, ->{joins(:results).where results: {answer_id: nil}}

  private
  def init_words
    self.category.words.not_learned(self.user).random_words.each do |word|
      self.results.create word_id: word.id
    end
  end

  def update_correct_num
    self.correct_number = results.select{|result| result.answer.try(:is_correct?)}.count
  end

  def save_activity
    create_activity user_id, id, Settings.activities.learned
  end
end
