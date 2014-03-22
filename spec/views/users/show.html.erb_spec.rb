require "spec_helper"

describe "users/show.html.erb" do

  let(:user) {  stub_model User, email: "email@example.org" }

  before do
    allow(user).to receive(:view_name).and_return("Cihad Paksoy")
    allow(view).to receive(:gravatar_url).and_return("http://example.org/image.jpg")
    assign(:user, user)
    render
  end

  it "displays user view name" do
    expect(rendered).to have_selector(".header", text: "Cihad Paksoy")
  end

  it "displays user avatar" do
    expect(rendered).to have_selector(".header img[@src='http://example.org/image.jpg']")
  end

end