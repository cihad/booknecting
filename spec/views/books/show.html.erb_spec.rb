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

  describe "when user signed in" do
    it "displays read button" do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:read_button).and_return('The Read Button')
      render
      expect(rendered).to match /The Read Button/
    end
  end

  describe "when user didnt signed in" do
    it "doesnt display read button" do
      allow(view).to receive(:user_signed_in?).and_return(false)
      allow(view).to receive(:read_button).and_return('The Read Button')
      render
      expect(rendered).to_not match /The Read Button/
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

end