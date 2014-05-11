class Tag < ActiveRecord::Base

  include Readable

  # Validates
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_validation :format_name

  def similar_users
    similar_raters(100).select { |n| n.actor_type == "User" }
  end

  private
    def format_name
      self.name = name.downcase
    end
  
end
