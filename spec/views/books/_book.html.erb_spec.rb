require "spec_helper"

describe "books/_book.html.erb" do
  
  let(:book) { stub_model Book, name: "The Book" }
  let(:image_url) { "http://example.org/image.jpg" }
  let(:users) { [stub_model(User), stub_model(User)] }

  before do
    image = double(medium: double(url: image_url))
    allow(book).to receive(:image).and_return(image)
    allow(book).to receive(:users).and_return(users)
    allow(view).to receive(:read_button).and_return("Read This Book")
    render 'books/book', book: book
  end

  it "displays book image" do
    expect(rendered).to have_selector "img[src='#{image_url}']"
  end

  it "displays book name with link" do
    expect(rendered).to have_selector "a", text: "The Book"
  end
 
  it "displays book read count" do
    expect(rendered).to have_selector ".description", text: 2
  end

  it "displays book read button" do
    expect(rendered).to match /Read This Book/
  end
  
end
