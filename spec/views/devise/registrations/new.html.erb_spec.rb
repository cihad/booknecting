require 'spec_helper'

describe "devise/registrations/new.html.erb" do
  
  before do
    user = stub_model User
    allow(view).to receive(:resource).and_return(user)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  it "displays username field" do
    expect(rendered).to have_selector 'label',
      text: I18n.t('activerecord.attributes.user.username')
  end

  it "displays name field" do
    expect(rendered).to have_selector 'label',
      text: I18n.t('activerecord.attributes.user.name')
  end

  it "displays email field" do
    expect(rendered).to have_selector 'label',
      text: I18n.t('activerecord.attributes.user.email')
  end

  it "displays password field" do
    expect(rendered).to have_selector 'label',
      text: I18n.t('activerecord.attributes.user.password')
  end

  it "displays password confirmation field" do
    expect(rendered).to have_selector 'label',
      text: I18n.t('activerecord.attributes.user.password_confirmation')
  end

end