require 'spec_helper'

describe 'books/edit.html.erb' do

  it "displays title" do
    assign(:book, stub_model(Book))
    render
    expect(rendered).to match /#{I18n.t('books.edit.title')}/
  end 

end