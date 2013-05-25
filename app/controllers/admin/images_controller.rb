class Admin::ImagesController < Admin::AdminController
  respond_to :html, :json

  def index
    respond_with :admin, @images = Image.all
  end

  def show
    respond_with :admin, @image = Image.find(params[:id])
  end

  def new
    respond_with :admin, @image = Image.new
  end

  def create
    @image = Image.create(params[:image])
    respond_with :admin, @image
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_with :admin, @image
  end
end
