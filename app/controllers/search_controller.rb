class SearchController < ApplicationController
  def results
    query = params[:s].presence || "*"
    @users = User.search(query)
    @jobs = Job.search(query)
    render :results
  end

  def autocomplete
   @users = User.search(params[:term], fields: [{first_name: :text_start}, {last_name: :text_start}],
    limit: 10).map {|u| u.first_name + ' ' + u.last_name}
   @jobs = Job.search(params[:term], fields: [{title: :text_start}, {show: :text_start}],
    limit: 10).map(&:title)
   @array = @users + @jobs
    render json: @array
  end
end
