class Admin::ImagesController < Admin::AdminController
  respond_to :html, :json

  def index
    @images = Image.order('created_at DESC')
    respond_with [:admin, @images], :layout => !request.xhr?
  end

  def show
    respond_with :admin, @image = Image.find(params[:id])
  end

  def new
    respond_with :admin, @image = Image.new
  end

  def create
    @image = Image.create(images_params)
    respond_with :admin, @image
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_with :admin, @image
  end

  private
  def image_params
    params.require(:image).permit(:file)
  end
end
