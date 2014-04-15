class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :read]

  respond_to :js, only: :read

  def index
    @books = if params[:search].present?
      Book.search(params[:search])
    else
      Book.top(count: 10)
    end
  end

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
