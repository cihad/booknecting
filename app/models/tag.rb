class Tag < ActiveRecord::Base

  # Validates
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :books

  # Callbacks
  before_validation :format_name

  private
    def format_name
      self.name = name.downcase
    end

  
end
