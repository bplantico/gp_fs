class SessionsController < ApplicationController

  def new
    if current_user
      flash[:warning] = "You are already logged in."
      redirect_user(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.api_key_active
        session[:user_id] = user.id
        flash[:success] = "You are now logged in!"
        redirect_user(user)
      else
        flash.now[:danger] = "Your account is inactive, contact an admin for help."
        render :new
      end
    else
      flash.now[:danger] = "Sorry, that email and password don't match."
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end

end
