class PostsController < ApplicationController
  respond_to :html

  def index
    respond_with @posts = Post.order('created_at DESC')
  end

  def show
    @new_comment = Comment.new()
    respond_with @post = Post.find(params[:id])
  end

end