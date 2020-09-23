class Answer < ApplicationRecord
  belongs_to :question
  has_one :take_answer
end
