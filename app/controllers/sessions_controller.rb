class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to articles_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:warning] = "Incorrect email or password."
      render 'new'
    end
  end

  def destroy
    session.delete :user_id
    flash[:success] = "Logged out"
    redirect_to root_path
  end

  def show
    byebug
  end
end
