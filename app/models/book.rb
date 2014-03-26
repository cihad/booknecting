class Book < ActiveRecord::Base
  # Includes
  include PgSearch

  # Validates
  validates :name, presence: true

  # Associations
  has_and_belongs_to_many :users

  # Image Attach
  mount_uploader :image, BookImageUploader

  # Postgresql Search
  pg_search_scope :search_by_name, against: :name, ignoring: :accents, using: :trigram

  def self.search text = ""
    text.present? ? search_by_name(text) : []
  end
  
end
