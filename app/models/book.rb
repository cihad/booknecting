class Book < ActiveRecord::Base

  # Validates
  validates :name, presence: true
  
end
