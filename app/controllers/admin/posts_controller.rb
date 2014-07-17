class Admin::PostsController < Admin::AdminController
  respond_to :html


  def index
    respond_with :admin, @posts = Post.order('created_at DESC')
  end

  def show
    @new_comment = Comment.new()
    respond_with :admin, @post = Post.find_by_slug(params[:id])
  end

  def new
    respond_with :admin, @post = Post.new, layout: !request.xhr?
  end

  def create
    respond_with :admin, @post = Post.create(post_params.merge(author: current_user))
  end

  def edit
    respond_with :admin, @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    respond_with :admin, @post
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with(:admin, @post)
  end

  private
  def post_params
    params.require(:post).permit(:subject, :body, :author, :status_id, :category_ids)
  end

end
