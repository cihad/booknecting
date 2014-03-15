require "spec_helper"

describe "devise/passwords/edit.html.erb" do

  before do
    user = stub_model User
    allow(view).to receive(:resource).and_return(user)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  it "displays page title" do
    expect(rendered).to have_page_title I18n.t('users.change_your_password')
  end

  it "displays new password field" do
    expect(rendered).to have_selector 'label', text: I18n.t('users.new_password')
  end

  it "displays confirm your new password field" do
    expect(rendered).to have_selector 'label', text: I18n.t('users.confirm_your_new_password')
  end

end