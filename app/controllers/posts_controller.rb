class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    #@post.category_ids = params[:category_ids] strong parameter
    #binding.pry
    if @post.save
      flash[:notice] = "Your Post was created."
      redirect_to posts_path
    else
      render :new
    end
    #render :text => post_params.inspect
  end

  def edit
    
  end

  def update
    if @post.update(post_params)#@update???
      flash[:notice] = " This post was updated. "
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    #binding.pry
    vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    if vote.valid?
      flash[:notice] = 'vote!! success'
    else
      flash[:error] = 'you can vote only once'
    end
    redirect_to :back
    #binding.pry
  end

  def set_post
    @post = Post.find(params[:id])
  end


  private

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids:[])
    end
end