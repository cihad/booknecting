class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Recommendable
  recommends :books

  def view_name
    name || username
  end

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

