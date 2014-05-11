require "spec_helper"

describe "devise/passwords/new.html.erb" do

  before do
    user = FactoryGirl.build_stubbed User
    allow(view).to receive(:resource).and_return(user)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  it "displays title" do
    expect(rendered).to have_page_title I18n.t('users.forgot_your_password')
  end

  it "displays email field" do
    expect(rendered).to have_selector 'label', text: I18n.t('activerecord.attributes.user.email')
  end
end