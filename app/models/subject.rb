class Subject < ApplicationRecord
  has_many :exams
  accepts_nested_attributes_for :exams
end
