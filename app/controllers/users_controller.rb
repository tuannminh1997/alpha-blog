class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :retype]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @pagy, @users = pagy(User.all, items: 5)
  end

  def new
    if logged_in?
      redirect_to articles_path
    else
      @user = User.new
    end
  end

  def show
    @pagy, @articles = pagy(@user.articles, items: 5)
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to #{ @user.username } , you have successfully sign up ."
      redirect_to articles_path
    else
      render 'users/new'
    end
  end

  def edit
  end

  def update
    if @user.update(users_params)
      flash[:success] = "Your profile was successfully updated"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def retype
    @user = current_user
  end

  def destroy
    if current_user.admin?
      @user.destroy
      session[:user_id] = nil if @user == current_user
      flash[:danger] = "Account and all associated articles successfully deleted"
      redirect_to root_path
    else
      user = User.find_by(email: current_user.email.downcase)
      if user && user.authenticate(users_params[:password])
        @user.destroy
        session[:user_id] = nil
        flash[:danger] = 'Account and all associated articles successfully deleted'
        redirect_to root_path
      else
        flash.now[:warning] = 'Incorrect email or password.'
        render 'users/retype'
      end
    end

  end

  private
  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:warning] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end