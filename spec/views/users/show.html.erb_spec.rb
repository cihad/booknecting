require "spec_helper"

describe "users/show.html.erb" do

  let(:user) {  FactoryGirl.create :user, email: "email@example.org" }

  let(:similar_user_1) { FactoryGirl.create(:user) }
  let(:similar_user_2) { FactoryGirl.create(:user) }

  let(:similar_raters) { [similar_user_1.node, similar_user_2.node] }

  before do
    allow(user).to receive(:view_name).and_return("Cihad Paksoy")
    allow(view).to receive(:gravatar_url).and_return("http://example.org/image.jpg")
    allow(user).to receive(:similar_raters).and_return(similar_raters)
    assign(:user, user)
    stub_template "books/_book.html.erb" => "<%= book.name %>"
    stub_template "users/_user.html.erb" => "<%= user.email %>"
    books = [stub_model(Book, name: "The Book"),
             stub_model(Book, name: "The Another Book")]
    allow(user).to receive(:books).and_return(books)
    render
  end

  it "displays user view name" do
    expect(rendered).to have_selector(".header", text: "Cihad Paksoy")
  end

  it "displays user avatar" do
    expect(rendered).to have_selector(".header img[@src='http://example.org/image.jpg']")
  end

  it "displays user books title" do
    expect(rendered).to match I18n.t('users.books.title')
  end

  it "displays user books" do
    expect(rendered).to have_content("The Book")
    expect(rendered).to have_content("The Another Book")
  end

  it "displays similar users title" do
    expect(rendered).to have_content(I18n.t('users.similar_users'))
  end

  it "displays other users similar to user" do
    expect(rendered).to have_content(similar_user_1.email)
    expect(rendered).to have_content(similar_user_2.email)
  end

end