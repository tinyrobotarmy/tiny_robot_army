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
    @category = Category.create(params[:category])
    respond_with :admin, @category
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    respond_with :admin, @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_with :admin, @category
  end
end
