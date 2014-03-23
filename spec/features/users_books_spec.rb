require 'spec_helper'

describe "Users Books" do

  let(:user) { FactoryGirl.create :user }
  let(:book) { FactoryGirl.create :book }

  describe "on book page" do
    it "increments read book count", js: true do
      login_as user, scope: :user

      expect {
        visit book_path book
        click_on I18n.t('users.books.read')
        sleep 0.2
      }.to change { user.books.count }.by(1)
    end

    it "descrements read book count", js: true do
      user.books << book
      login_as user, scope: :user

      expect {
        visit book_path book
        click_on I18n.t('users.books.read')
        sleep 0.2
      }.to change { user.books.count }.by(-1)
    end

    it "when click read button increments people who reat it count", js: true do
      login_as user, scope: :user

      visit book_path book
      click_on I18n.t('users.books.read')
      expect(page).to have_selector '.ui.right.floated.label', 
                    text: I18n.t('books.show.read_count', count: "1")
    end

    it "when click read button displays last read user on people who read it", js: true do
      login_as user, scope: :user

      visit book_path book
      click_on I18n.t('users.books.read')
      expect(page).to have_selector '.image', count: 1
    end
  end

  describe "on user page" do
    it "when click read button on user page increments read book count", js: true do
      user.books << book
      login_as user, scope: :user

      visit user_path user
      click_on I18n.t('users.books.read')
      sleep 0.2
      expect(page).to have_selector '.ui.right.floated.label',
                                    text: I18n.t('users.books.read_count_html'),
                                    count: 0
    end
    
  end
end