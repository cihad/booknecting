class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Recommendable
  recommends :books

  # user.first_name = 'Cihad'
  # user.last_name = 'Paksoy'
  # user.name == 'Cihad Paksoy' => true
  def name
    "%s %s" % [first_name, last_name]
  end

  def view_name
    (first_name and last_name) ? name : username
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

