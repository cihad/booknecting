require "spec_helper"

describe "tags/show.html.erb" do

  let(:tag) { FactoryGirl.build_stubbed Tag, name: "risale-i nur" }

  before do
    assign(:tag, tag)
    allow(tag).to receive(:similar_users).and_return([stub_model(Node)])
    allow(tag).to receive(:books).and_return([stub_model(Book, name: "Lemalar")])
    stub_template 'books/_book.html.erb' => '<%= book.name %>'
    stub_template 'nodes/_node.html.erb' => "Similar Users"
    render
  end

  it "displays tag name" do
    expect(rendered).to match "risale-i nur" 
  end

  it "displays books" do
    expect(rendered).to match "Lemalar"
  end

  it "displays tag similarities title" do
    expect(rendered).to match escape_once(I18n.t('tags.show.similar_users', tag: 'risale-i nur'))
  end

  it "displays tag similarities" do
    expect(rendered).to match "Similar Users"
  end

end