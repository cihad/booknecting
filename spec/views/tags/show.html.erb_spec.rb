require "spec_helper"

describe "tags/show.html.erb" do

  let(:tag) { stub_model Tag, name: "risale-i nur" }

  before do
    assign(:tag, tag)
    allow(tag).to receive(:books).and_return([stub_model(Book, name: "Lemalar")])
    stub_template 'books/_book.html.erb' => '<%= book.name %>'
    render
  end

  it "displays tag name" do
    expect(rendered).to match "risale-i nur" 
  end

  it "displays books" do
    expect(rendered).to match "Lemalar"
  end

end