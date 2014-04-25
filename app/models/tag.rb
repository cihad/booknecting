class Tag < ActiveRecord::Base

  # Validates
  validates :name, presence: true
  
end
