require "spec_helper"

describe "devise/sessions/new.html.erb" do

  before do
    user = FactoryGirl.build_stubbed User
    allow(view).to receive(:resource).and_return(user)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  it "displays email" do
    expect(rendered).to have_selector 'label', text: I18n.t('activerecord.attributes.user.email')
  end

  it "displays password" do
    expect(rendered).to have_selector 'label', text: I18n.t('activerecord.attributes.user.password')
  end

  it "displays remember me" do
    expect(rendered).to have_selector 'label', text: I18n.t('activerecord.attributes.user.remember_me')
  end

end