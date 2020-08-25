class User < ApplicationRecord
  has_one :profile
  has_many :user_exams
  has_many :exams, through: :user_exams
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
