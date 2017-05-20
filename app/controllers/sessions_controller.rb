class SessionsController < ApplicationController


  def new
    #super
  end

  def create
      if request.env["omniauth.auth"]
        user = User.from_omniauth(request.env["omniauth.auth"])
        session[:user_id] = user.id
        redirect_to root_path
      else
        user = User.find_by_email params[:email]
        if user && user.valid_password?(params[:password])
        #if valid_password? params[:password]
          session[:user_id] = user.id
          redirect_to root_path, notice: 'Signed in!'
        else
          flash.now[:alert] = 'Wrong credentials'
          render :new
        end
      end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end


end
