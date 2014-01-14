class CommentsController < ApplicationController

  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
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
    @vote = Vote.create(creator: current_user,vote: params[:vote],voteable: @comment)
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Voted to comment'
        else
          flash[:error] = 'you can vote only once'
        end
        redirect_to :back
      end
      
      format.js 
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description,:post_id)
  end
end
