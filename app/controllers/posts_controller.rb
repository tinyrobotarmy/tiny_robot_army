class PostsController < ApplicationController
  respond_to :html

  def index
    @pinned = Post.pinned.includes(:author).first
    @categories = Category.all
    respond_with @posts = Post.includes(:author).order('created_at DESC').paginate(page: params[:page] || 1, per_page: 10)
  end

  def show
    @new_comment = Comment.new()
    respond_with @post = Post.find_by_slug!(params[:id])
  end

end
