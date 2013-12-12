class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first # TODO: change it after implementing authentication
    if @post.save
      flash[:notice] = "Your Post was created."
      redirect_to posts_path
    else
      render :new
    end
    #render :text => post_params.inspect
  end

  private

    def post_params
      params.require(:post).permit(:title, :url, :description)
    end
end