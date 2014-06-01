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

  def amazon_book_path *args
    book_path *args
  end

  def amazon_book_tags_path *args
    book_tags_path *args
  end


end
