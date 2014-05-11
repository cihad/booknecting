class Book < ActiveRecord::Base
  # Includes
  include PgSearch

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
    liked_by.includes(:actor).where(actor_type: "User").map(&:actor)
  end

  def tags
    liked_by.includes(:actor).where(actor_type: "Tag").map(&:actor)
  end

  def tag_exists? tag
    tag.read? self
  end

  def add_tag tag
    tag.read self
  end

  def remove_tag tag
    tag.unread self
  end
  
end
