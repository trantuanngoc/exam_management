class Answer < ApplicationRecord
  validates :content, presence: true
  belongs_to :question
  has_one :take_answer
end
