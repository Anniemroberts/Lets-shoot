class SubmissionsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @applications = @user.applications
  end

  def create
    application_params    = params.require(:application).permit(:body)
    @application         = Application.new application_params
    @job            = Job.find params[:job_id]
    @application.user = current_user
    @application.job = @job
    if @application.save
      Notification.create(recipient: @job.user, actor: current_user, action: "applied")
      redirect_to job_path(params[:job_id]), notice: 'You have applied for this job!'
    else
      flash[:alert] = 'please fix errors'
      render 'jobs/show'
    end
  end

  def hire
    @application = Application.find params[:format]
    @job = @application.job
    @application.accept!
    @job.fill!
    Notification.create(recipient: @application.user, actor: current_user, action: "hired")
  end

  def destroy
    application = Application.find params[:id]
    application.destroy
    redirect_to job_path(application.job_id)
  end

end
