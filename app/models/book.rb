class Book < ActiveRecord::Base

  # Validates
  validates :name, presence: true

  # Associations
  has_and_belongs_to_many :users

  # Image Attach
  mount_uploader :image, BookImageUploader
  
end
