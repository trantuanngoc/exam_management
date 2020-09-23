class TakeAnswer < ApplicationRecord
  belongs_to :user_exam
  belongs_to :answer
end
