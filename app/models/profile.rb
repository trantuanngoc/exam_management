class Profile < ApplicationRecord
  belongs_to :user

  def full_name
    (self.last_name || "").capitalize << " " << (self.first_name || "").capitalize
  end
end
