class AmazonBooksController < ApplicationController

  respond_to :js, only: :read

  def read
    @amazon_book = AmazonBook.find(params[:id])
    @book = @amazon_book.persist_from_amazon!
    current_user.read(@book)
    respond_with @book
  end
end
