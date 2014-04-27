require 'spec_helper'

describe "Books" do

  let!(:book) { FactoryGirl.create :book }

  describe "when valid attributes" do
    it "creates a new book" do
      expect {
        visit new_book_path
        fill_in "book_name", with: "The Example Book"
        attach_file "book_image", Rails.root.join('spec/support/images/01.png')
        click_on I18n.t('helpers.submit.create')
      }.to change(Book, :count).by(1)

      expect(page).to have_text I18n.t('books.messages.created')
    end

    it "edit existing book" do
      expect {
        visit edit_book_path(book)
        fill_in "book_name", with: "The Another Book"
        attach_file "book_image", Rails.root.join('spec/support/images/01.png')
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

  describe "search by name" do
    it "finds correct books", js: true do
      FactoryGirl.create :book, name: "Sample Book"
      FactoryGirl.create :book, name: "Sample Magazine"
      FactoryGirl.create :book, name: "Great Book"

      visit root_path
      fill_in "search", with: "sample"
      page.execute_script("$('form.item').submit()")
      expect(page).to have_content "Sample Book"
      expect(page).to have_content "Sample Magazine"
    end
  end

  it "adds tag", js: true do
    visit book_path(book)
    fill_in "tag_name", with: "Example Tag"
    click_on I18n.t('helpers.submit.create')
    expect(page).to have_content "example tag"
  end

  it "removes tag", js: true do
    tag = FactoryGirl.create :tag, name: "Removeble Tag"
    book.add_tag tag

    visit book_path(book)
    page.execute_script("$('#tag_#{tag.id} .remove').click()")
    expect(page).to_not have_content "removeble tag"
  end

end