class Answer < ActiveRecord::Base
  belongs_to :word
  has_one :results, dependent: :destroy

end
