class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully registered"
      redirect_to root_path
    else 
      render :new
    end
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def update
    @user = User.find_by(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have updated your profile"
      redirect_to root_path
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :manager)
  end

end