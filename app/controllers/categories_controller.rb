class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_user, only: [:new, :create]
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "A Category was created."
      redirect_to category_path(@category)
    else
      render "new"
    end
  end

  def show
  end

  def index
    @categories = Category.all
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "category update success"
      redirect_to category_path(@category)
    else
      render "edit"
    end
  end

  def set_category
    @category = Category.find_by(slug: params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
