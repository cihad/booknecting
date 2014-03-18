def have_page_title title
  have_selector 'h1.header', text: title
end

def have_sub_title title
  have_selector 'h2.header', text: title
end