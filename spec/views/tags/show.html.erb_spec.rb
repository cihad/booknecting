require "spec_helper"

describe "tags/show.html.erb" do

  let(:tag) { stub_model Tag, name: "Sample Tag" }

  before do
    assign(:tag, tag)
    render
  end

  it "displays tag name" do
    expect(rendered).to match "Sample Tag" 
  end

end