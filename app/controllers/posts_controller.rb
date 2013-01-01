class PostsController < ApplicationController
  respond_to :html

  def index
    respond_with @posts = Post.order(:created_at)
  end

  def show
    respond_with @post = Post.find(params[:id])
  end

  def new
    respond_with @post = Post.new, :layout => !request.xhr?
  end

  def create
    respond_with @post = Post.create(params[:post].merge(author_id: User.first.id))
  end
end