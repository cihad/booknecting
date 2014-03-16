require 'spec_helper'

describe 'books/show.html.erb' do

  before do
    assign(:book, stub_model(Book, name: "The Book"))
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

end