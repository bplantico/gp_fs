class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]

  def new
    if current_user
      flash[:warning] = "You are already logged in."
      redirect_user(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Registration Successful! You are now logged in."
      redirect_to(profile_path)
    else
      flash.now[:danger] = @user.errors.full_messages
      @user.update(email: "", password: "")
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
