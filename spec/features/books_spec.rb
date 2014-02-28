require 'spec_helper'

describe "Books" do

  let!(:book) { FactoryGirl.create :book }

  describe "when valid attributes" do
    it "creates a new book" do
      expect {
        visit new_book_path
        fill_in "book_name", with: "The Example Book"
        click_on I18n.t('helpers.submit.create')
      }.to change(Book, :count).by(1)

      expect(page).to have_content I18n.t('books.messages.created')
    end

    it "edit existing book" do
      expect {
        visit edit_book_path(book)
        fill_in "book_name", with: "The Another Book"
        click_on I18n.t('helpers.submit.update')
      }.to_not change(Book, :count)

      expect(book.reload.name).to eq("The Another Book")
      expect(page).to have_content I18n.t('books.messages.updated')
    end
  end

  describe "when unvalid attributes" do
    it "doesnt create a book" do
      expect {
        visit new_book_path
        fill_in "book_name", with: ""
        click_on I18n.t('helpers.submit.create')
      }.to_not change(Book, :count) 
    end

    it "doesnt edit existing book" do
      expect {
        visit edit_book_path(book)
        fill_in "book_name", with: ""
        click_on I18n.t('helpers.submit.update')
      }.to_not change { book.name }
    end
  end

end