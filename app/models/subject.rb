class Subject < ApplicationRecord
  validates :name, presence: true
  has_many :exams
  accepts_nested_attributes_for :exams, reject_if: :all_blank, allow_destroy: true
end
