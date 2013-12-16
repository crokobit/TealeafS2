class CommentsController < ApplicationController


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = User.first # TODO: change it after implementing authentication
    if @comment.save
      flash[:notice] = 'You leave a comment.'
      redirect_to posts_path(@comment.post)
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description,:post_id)
  end
end
