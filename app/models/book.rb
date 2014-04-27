class Book < ActiveRecord::Base
  # Includes
  include PgSearch

  # Associations
  has_and_belongs_to_many :tags

  # Validates
  validates :name, presence: true

  # Image Attach
  mount_uploader :image, BookImageUploader

  # Postgresql Search
  pg_search_scope :search_by_name, against: :name, ignoring: :accents, using: :trigram

  def self.search text = ""
    text.present? ? search_by_name(text) : []
  end

  def users
    liked_by
  end

  def tag_exists? tag
    tags.exists? tag
  end

  def add_tag tag
    tags << tag
  end

  def remove_tag tag
    tags.destroy tag
  end
  
end
