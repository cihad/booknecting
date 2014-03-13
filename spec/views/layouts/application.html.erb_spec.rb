require 'spec_helper'

describe "layouts/application.html.erb" do

  before do
    view.lookup_context.prefixes = %w[application]
    stub_template "application/_messages.html.erb" => "The Message"
    stub_template "application/_header.html.erb" => "The Header"
    render
  end

  it "displays Title" do
    expect(rendered).to have_selector "title", text: "Booknecting"
  end

  it "displays messages" do
    expect(rendered).to match 'The Message'
  end

  it "displays header" do
    expect(rendered).to match 'The Header'
  end
  
end