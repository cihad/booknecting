class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :read]

  respond_to :js, only: :read

  def index
    @books = Book.search(params[:search])
  end

  def show
    @book = if params[:id].start_with?('ASIN')
      Book.find_by(amazon_asin: AmazonBook.unless_asin_prefix(params[:id])) ||
        AmazonBook.find(params[:id])
    else
      Book.find(params[:id])
    end
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

  def read
    current_user.read?(@book) ? current_user.unread(@book) : current_user.read(@book)

    respond_with @book
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :image, :image_cache)
    end
end
