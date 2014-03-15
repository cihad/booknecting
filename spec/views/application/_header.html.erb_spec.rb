require 'spec_helper'

describe "application/_header.html.erb" do

  it "display the alert and the notice" do
    render
    expect(rendered).to have_selector 'a', text: 'Booknecting'
  end

  describe "when user signed in" do
    it "displays sign out link" do
      allow(view).to receive(:user_signed_in?).and_return(true)
      render
      expect(rendered).to have_selector 'a', text: I18n.t('users.signout')
    end
  end

  describe "when user sign out" do
    it "displays sign in link" do
      allow(view).to receive(:user_signed_in?).and_return(false)
      render
      expect(rendered).to have_selector 'a', text: I18n.t('users.signin')
    end
  end

  describe "when devise controller" do
    it "displays devise links in sub menu" do
      stub_template 'devise/shared/_links.html.erb' => 'The Links'
      allow(view).to receive(:devise_controller?).and_return(true)
      render
      expect(rendered).to match 'The Links'
    end
  end

end