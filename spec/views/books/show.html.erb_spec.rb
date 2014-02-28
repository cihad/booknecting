require 'spec_helper'

describe 'books/show.html.erb' do

  before do
    assign(:book, stub_model(Book, name: "The Book"))
    render
  end

  it "displays book name" do
    expect(rendered).to match /The Book/
  end

end