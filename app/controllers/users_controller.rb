class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)

    if @user.save
      session[:user_id] = @user.id 
      flash[:notice] = "regisitered"
      redirect_to root_path
    else
      render :new
    end

  end

  def show; end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    if @user.update(user_param)
      flash[:notice] = 'Updated!'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def set_user
    @user = current_user
  end

  def require_same_user
    #binding.pry
    if @user.id != params[:id].to_i
      flash[:error] = 'WHAT!!'
      redirect_to root_path
    end
  end

  private

  def user_param
    params.require(:user).permit(:name, :password)
  end
end