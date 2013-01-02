class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  respond_to :html

  def index
    respond_with @posts = Post.order('created_at DESC')
  end

  def show
    respond_with @post = Post.find(params[:id])
  end

  def new
    respond_with @post = Post.new, layout: !request.xhr?
  end

  def create
    respond_with @post = Post.create(params[:post].merge(author: current_user))
  end
end