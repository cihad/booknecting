require "spec_helper"

describe "nodes/_node.html.erb" do
  
  before do
    user = FactoryGirl.create :user, email: "ali@example.org"
    stub_template 'users/_user.html.erb' => '<%= user.email %>'
    render 'nodes/node', node: user.node
  end

  it "renders node actor" do
    expect(rendered).to match "ali@example.org"
  end

end