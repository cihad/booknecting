require 'spec_helper'

describe "books/_form.html.erb" do

  before do
    @book = stub_model Book, name: "The Book"
    render 'books/form'
  end

  it "displays book name" do
    expect(rendered).to match /The Book/
  end

  it "displays book name label" do
    expect(rendered).to match /#{I18n.t('activerecord.attributes.book.name')}/
  end

end