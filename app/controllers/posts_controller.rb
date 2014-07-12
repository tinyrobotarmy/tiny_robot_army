class PostsController < ApplicationController
  respond_to :html

  def index
    @pinned = false
    @categories = Category.all
    respond_with @posts = Post.order('created_at DESC').paginate(page: params[:page] || 1, per_page: 10)
  end

  def show
    @new_comment = Comment.new()
    respond_with @post = Post.find(params[:id])
  end

end
