require 'spec_helper'

describe 'books/show.html.erb' do

  let(:book) { stub_model(Book, name: "The Book") }

  before do
    assign(:book, book)
  end

  it "displays book name" do
    render
    expect(rendered).to match /The Book/
  end

  describe "image" do
    it "when exists displays book image" do
      allow(book).to receive(:image?).and_return(true)
      allow(book).to receive(:image_url).and_return("image.png")
      render
      expect(rendered).to have_selector "img[width='260'][alt='The Book']"
    end

    it "when didnt exist displays book image" do
      render
      expect(rendered).to have_selector ".no-image"
    end
  end

  describe "when user signed in" do
    it "displays read button" do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:read_button).and_return('The Read Button')
      render
      expect(rendered).to match /The Read Button/
    end
  end

  describe "who read it" do
    it "displays title" do
      render
      expect(rendered).to match I18n.t('books.show.who_read_it')     
    end

    it "displays people" do
      users = [stub_model(User)]
      allow(book).to receive(:users).and_return(users)
      stub_template "users/_user.html.erb" => "The User Who Read It"
      render
      expect(rendered).to have_selector '.images'
      expect(rendered).to match /The User Who Read It/
    end

    it "displays read count" do
      users = [stub_model(User)]
      allow(book).to receive(:users).and_return(users)
      render
      expect(rendered).to match I18n.t('books.show.read_count', count: "1")
    end
  end

  it "displays tags" do
    tag = stub_model(Tag, name: "Example Tag")
    tags = [tag]
    allow(book).to receive(:tags).and_return(tags)
    render
    expect(rendered).to have_selector "a", text: "Example Tag"
  end
  
end