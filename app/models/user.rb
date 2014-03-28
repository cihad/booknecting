class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :books

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
    books << book
    like book
  end

  def unread book
    books.delete book
    unlike book
  end

  def read? book
    books.exists?(book) and likes?(book)
  end
end

