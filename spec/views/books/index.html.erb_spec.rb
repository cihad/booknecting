require 'spec_helper'

describe 'books/index.html.erb' do

  let(:books) { [stub_model(Book, name: "The Book")] }

  before do
    assign(:books, books)
  end

  it "displays books" do
    render
    expect(rendered).to match /The Book/
  end
end