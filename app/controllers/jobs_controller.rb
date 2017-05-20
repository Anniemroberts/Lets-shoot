class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action(:find_job, { only: [:show, :edit, :destroy, :update] })
  before_action :authorize, only: [:edit, :destroy, :update]

  def new
    @job = Job.new
  end

  def create
    @job  = Job.new(job_params)
    @job.user = current_user
    if @job.save
      flash[:notice] = 'Job created successfully'
      redirect_to job_path(@job)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  def show
    @application = Application.new
  end

  def index
    @jobs = Job.all
    @jobs = Job.reversed
  end

  def jobs_posted
    @user = User.find(current_user)
    @jobs = Job.where(user_id: current_user)
  end

  def edit
  end

  def update
    #@question.slug = nil
    if @job.update job_params
      redirect_to job_path(@job), notice: 'Job updated!'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: 'Job deleted!'
  end

  def shooting
  end

  private

  def job_params
    params.require(:job).permit([:title,
                                :description,
                                :address,
                                :when,
                                :show,
                                :tcp,
                                :car,
                                :created_at])
  end

  def find_job
    @job = Job.find params[:id]
  end

  def authorize
    if cannot?(:manage, @job)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

end
