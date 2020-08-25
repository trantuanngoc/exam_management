class Answer < ApplicationRecord
  belongs_to :question
  has_many :right_answers, class_name: Question, foreign_key: :answer_id, primary_key: :right_answer_id, optional: true
end
