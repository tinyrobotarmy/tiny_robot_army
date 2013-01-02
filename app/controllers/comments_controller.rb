class CommentsController < ApplicationController
  respond_to :html
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].merge(author: current_user))
    logger.debug "COMMENT: #{@comment.inspect}"
    respond_with @post, @comment, layout: !request.xhr?
  end

  def show
    respond_with @comment = Comment.find(params[:id]), layout: !request.xhr?
  end
end