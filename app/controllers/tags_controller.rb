class TagsController < ApplicationController
  before_action :set_tag, only: :show
  respond_to :js, only: :create

  def show
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.save
    respond_with @tag
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
