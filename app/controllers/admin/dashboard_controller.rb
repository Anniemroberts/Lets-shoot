class Admin::DashboardController < Admin::BaseController

  def create
    @user = User.find(params[:user_id])
    @user.is_admin = true
    if @user.save
      Notification.create(recipient: @user, actor: current_user, action: "admin")
      flash[:notice] = 'This user is now an admin.'
      redirect_to user_profile_path(@user)
    else
      flash.now[:alert] = 'This user could not be made admin.'
      redirect_to user_profile_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.is_admin = false
    if @user.save
      flash[:notice] = 'This user is no longer an admin.'
      redirect_to user_profile_path(@user)
    else
      flash.now[:alert] = 'You could not revoke these admin priviledges.'
      redirect_to user_profile_path(@user)
    end
  end

  def index
    @accepted_users = User.where(:is_auth => true)
    @pending_users = User.where(:is_auth => false)
  end

  def auth
    @user = User.find(params[:user_id])
    @user.is_auth = true
    if @user.save
      Notification.create(recipient: @user, actor: current_user, action: "verified")
      flash[:notice] = 'This user is now approved.'
      redirect_to admin_dashboard_index_path
    else
      flash.now[:alert] = 'This user could not be approved'
      redirect_to admin_dashboard_index_path
    end
  end

end
