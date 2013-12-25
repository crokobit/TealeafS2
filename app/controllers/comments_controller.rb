class CommentsController < ApplicationController

  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = 'You leave a comment.'
      redirect_to posts_path(@comment.post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    Vote.create(creator: current_user,vote: params[:vote],voteable: @comment)
    flash[:notice] = 'Voted to comment'
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:description,:post_id)
  end
end
