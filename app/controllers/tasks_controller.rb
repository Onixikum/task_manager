class TasksController < ApplicationController #:nodoc:
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task created!'
      redirect_to root_url
    else
      @feed_item = []
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def update
    @task = current_user.tasks.find_by(id: params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = 'Task updated'
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_url
  end

  private

  def task_params
    params.require(:task).permit(:content)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url if @task.nil?
  end
end
