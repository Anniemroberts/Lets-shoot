class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :cookie_set
  before_action :set_notifications, if: :user_signed_in?

  def set_notifications
     @notifications = Notification.where(recipient: current_user).recent
  end

  def authenticate_user!
    redirect_to new_session_path, alert: 'please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    User.find session[:user_id] if user_signed_in?
  end
  helper_method :current_user

  def cookie_set
    return unless current_user
    @user = current_user
    cookies[:user_name] = @user.id
  end

  # def current_user
  # user_id = request.headers['x-user-id'] || cookies[:user_id]
  #   @current_user ||= if user_id.present?
  #     User.find_by(id: user_id)
  #   else params[:token].present?
  #     User.find_by(token: params[:token])
  #   end
  # end
  # helper_method :current_user


end
