class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Welcome to #{ @user.username }, you have successfully sign up ."
      redirect_to articles_path
    else
      render 'users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      flash[:success] = "Your profile was successfully updated"
      redirect_to articles_path
    else
      render 'users/edit'
    end
  end

  private
  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

end