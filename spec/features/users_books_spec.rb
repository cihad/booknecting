require 'spec_helper'

describe "Users Books" do

  let(:user) { FactoryGirl.create :user }
  let(:book) { FactoryGirl.create :book }

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

end