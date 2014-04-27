class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :destroy]
  before_action :set_book, only: [:create, :destroy]
  respond_to :js, only: [:create, :destroy]

  def show
  end

  def create
    @tag = Tag.find_or_create_by(name: params[:tag][:name].downcase)

    unless @book.tag_exists?(@tag)
      @book.add_tag(@tag)
      @is_new_added = true
    end

    respond_with @tag, @is_new_added
  end

  def destroy
    @book.remove_tag @tag if @book.tag_exists?(@tag)
    respond_with @tag
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
