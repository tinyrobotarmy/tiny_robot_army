class CommentsController < ApplicationController
  respond_to :html
  before_filter :require_user!, only: [:create]

  def create
    @post = Post.find_by_slug!(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(author: current_user))
    respond_with @post, @comment, layout: !request.xhr?
  end

  def show
    respond_with @comment = Comment.find(params[:id]), layout: !request.xhr?
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :author)
  end
end
