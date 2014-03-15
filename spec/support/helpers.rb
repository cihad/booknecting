def have_page_title title
  have_selector 'h1.header', text: title
end