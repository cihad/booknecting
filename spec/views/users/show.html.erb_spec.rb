require "spec_helper"

describe "users/show.html.erb" do

  let(:user) {  stub_model User, email: "email@example.org" }

  before do
    allow(user).to receive(:view_name).and_return("Cihad Paksoy")
    allow(view).to receive(:gravatar_url).and_return("http://example.org/image.jpg")
    assign(:user, user)
    stub_template "books/_book.html.erb" => "<%= book.name %>"
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

end