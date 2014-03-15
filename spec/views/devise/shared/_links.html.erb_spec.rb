require 'spec_helper'

describe "devise/shared/_links.html.erb" do

  before do
    allow(view).to receive(:resource_name).and_return('user')
    devise_mapping = double(:registerable? => true, :recoverable? => true)
    allow(view).to receive(:devise_mapping).and_return(devise_mapping)
    allow(view).to receive(:controller_name).and_return('not_sessions_registrations_and_passwords')
    render
  end

  describe "when controller is not sessions" do
    it "displays sign in link" do
      expect(rendered).to have_selector 'a', text: I18n.t('users.signin')
    end
  end

  describe "when controller is not registrations" do
    it "displays sign up link" do
      expect(rendered).to have_selector 'a', text: I18n.t('users.signup')
    end
  end

  describe "when controller is not passwords and registrations" do
    it "displays sign up link" do
      expect(rendered).to have_selector 'a', text: I18n.t('users.forgot_your_password')
    end
  end

end