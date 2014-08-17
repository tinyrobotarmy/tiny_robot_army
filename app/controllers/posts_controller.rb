class PostsController < ApplicationController
  respond_to :html

  def index
    @pinned = Post.pinned.includes(:author).first
    @categories = Category.all
    respond_with @posts = post_query.includes(:author).order('created_at DESC').paginate(page: params[:page] || 1, per_page: 10)
  end

  def show
    @new_comment = Comment.new()
    respond_with @post = Post.find_by_slug!(params[:id])
  end

  private
  def post_query
    @category = Category.find_by(id: params[:category])
    query = @category ? @category.posts.published.unpinned : Post.published.unpinned
    query = query.basic_search(params[:q]) if params[:q]
    query
  end

end
