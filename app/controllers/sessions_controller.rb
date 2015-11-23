class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you are logged in"
      redirect_to task_path

    else
      flash[:error] = "There was a problem with your username or password"
      redirect_to login_path
    end
  end

end