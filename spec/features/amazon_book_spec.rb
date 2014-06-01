require "spec_helper"

describe "AmazonBook" do

  let(:item) { double }
  let(:user) { FactoryGirl.create :user }

  before do
    allow(item).to receive(:get).with('ItemAttributes/Title').and_return("Agile Web Development with Rails 4")
    allow(item).to receive(:get).with('ASIN').and_return("EXAMPLEASIN")
    allow(item).to receive(:get_hash).with('LargeImage').and_return({"URL" => "http://example.org/image.jpg"})
    amazon_book = AmazonBook.new item
    allow(AmazonBook).to receive(:find).with('ASINEXAMPLEASIN').and_return(amazon_book)
    allow(AmazonBook).to receive(:search).with('Agile Web').and_return([amazon_book])
  end

  it "searches books from amazon", js: true do
    visit root_path
    fill_in "search", with: "Agile Web"
    page.execute_script("$('form.item').submit()")
    expect(page).to have_content "Agile Web Development with Rails 4"
  end

  it "saves the book to database from amazon when current user clicks to read button", js: true do
    login_as user, scope: :user

    visit book_path("ASINEXAMPLEASIN")
    expect {
      click_on I18n.t('users.books.read')            
      sleep 1
    }.to change(Book, :count).by(1)
  end

end