module ApplicationHelper

  def page_title(title)
    content_tag :h1, title, class: "ui dividing header"
  end

end
