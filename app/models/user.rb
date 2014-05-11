class User < ActiveRecord::Base

  include Readable  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def view_name
    name || username
  end

  def similar_users
    similar_raters(100).select { |n| n.actor_type == "User" }
  end

end

