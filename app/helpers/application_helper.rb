module ApplicationHelper

  def title(header = 'h1', title = nil, &block)
    if block_given?
      content_tag header, class: "ui dividing header", &block 
    else
      content_tag header, title, class: "ui dividing header"
    end
  end

  def page_title title = nil, &block
    title 'h1', title, &block
  end

  def sub_title title = nil, &block
    title 'h3', title, &block
  end

end
