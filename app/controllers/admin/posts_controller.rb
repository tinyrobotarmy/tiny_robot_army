class Admin::PostsController < Admin::AdminController
  respond_to :html

  def show
    @new_comment = Comment.new()
    respond_with @post = Post.find(params[:id])
  end

  def new
    respond_with @post = Post.new, layout: !request.xhr?
  end

  def create
    puts "params: #{params.inspect}"
    respond_with @post = Post.create(params[:post].merge(author: current_user))
  end
end