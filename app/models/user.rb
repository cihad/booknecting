class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :books

  # user.first_name = 'Cihad'
  # user.last_name = 'Paksoy'
  # user.name == 'Cihad Paksoy' => true
  def name
    "%s %s" % [first_name, last_name]
  end
end

