module ApplicationHelper

  def page_title(title = nil, &block)
    if block_given?
      content_tag :h1, class: "ui dividing header", &block 
    else
      content_tag :h1, title, class: "ui dividing header"
    end
  end

end
