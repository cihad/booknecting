class Node < ActiveRecord::Base

  # Recommendable
  recommends :books

  # Associations
  belongs_to :actor, polymorphic: true

  def read book
    like book
  end

  def unread book
    unlike book
  end

  def read? book
    likes? book
  end

  def books
    likes
  end

end
