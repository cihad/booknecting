class Tag < ActiveRecord::Base

  include Readable

  # Validates
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_validation :format_name

  private
    def format_name
      self.name = name.downcase
    end
  
end
