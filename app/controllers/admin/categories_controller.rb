class Admin::CategoriesController < Admin::AdminController
  respond_to :html

  def index
    respond_with :admin, @categories = Category.all
  end

  def show
    respond_with :admin, @category = Category.find(params[:id])
  end

  def new
    respond_with :admin, @category = Category.new
  end

  def edit
    respond_with :admin, @category = Category.find(params[:id])
  end

  def create
    @category = Category.create(category_params)
    respond_with :admin, @category
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(category_params)
    respond_with :admin, @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_with :admin, @category
  end

  private
  def category_params
    params.require(:category).permit(:title, :slug, :description)
  end
end
