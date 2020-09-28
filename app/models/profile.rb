class Profile < ApplicationRecord
  belongs_to :user

  def full_name
    (last_name || "").capitalize << " " << (first_name || "").capitalize
  end
end
