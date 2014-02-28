class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update]

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: I18n.t('books.messages.created')
    else
      render action: 'new'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: I18n.t('books.messages.updated')
    else
      render action: 'edit'
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name)
    end
end
