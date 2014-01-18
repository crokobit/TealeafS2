class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.where(name: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id #cookies
      flash[:notice] = 'Loged in'
      redirect_to root_path
    else
      flash[:error] = "Wrong"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end

end
