class UsersController < ApplicationController
  respond_to :html, :json, only: [:search]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  def profile
    @user = User.find(params[:user_id])
    @jobs = Job.where(user_id: current_user)
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update user_params
      redirect_to user_profile_path(@user), notice: 'Job updated!'
    else
      render :edit
    end
  end

  def search
    @users = User.search(params[:query])
    if request.xhr?
      render :json => @users.to_json
    else
      @user = current_user
      render :profile
    end
  end


  private

  def user_params
    user_params = params.require(:user).permit(:first_name,
                                               :last_name,
                                               :email,
                                               :password,
                                               :password_confirmation,
                                               :image)
  end
end
