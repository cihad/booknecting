require 'spec_helper'

describe "application/_header.html.erb" do

  it "display the alert and the notice" do
    render
    expect(rendered).to have_selector 'a', text: 'Booknecting'
  end

  describe "when user signed in" do
    it "displays sign out link" do
      view.stub(:user_signed_in?).and_return(true)
      render
      expect(rendered).to have_selector 'a', text: I18n.t('users.signout')
    end
  end

  describe "when user sign out" do
    it "displays sign in link" do
      view.stub(:user_signed_in?).and_return(false)
      render
      expect(rendered).to have_selector 'a', text: I18n.t('users.signin')
    end
  end

end