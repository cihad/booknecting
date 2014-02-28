require 'spec_helper'

describe "books/new" do

  before do
    assign(:book, stub_model(Book))
    render
  end

  it "displays page title" do
    expect(rendered).to match /#{I18n.t('books.new.title')}/
  end

end