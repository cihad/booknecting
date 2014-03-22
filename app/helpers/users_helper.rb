require 'digest/md5'

module UsersHelper

  def gravatar_for user, size = 80
    link_to "#" do
      image_tag gravatar_url(user.email, size), alt: user.username, size: "80",    
                class: "ui rounded image"
    end
  end

  def gravatar_url email, size = 80
    hash = Digest::MD5.hexdigest email.downcase
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}" 
  end

end