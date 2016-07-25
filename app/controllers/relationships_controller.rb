class RelationshipsController < ApplicationController #:nodoc:
  before_action :signed_in_user

  def create
    @task = Task.find(params[:relationship][:task_id])
    current_user.follow!(@task)
    redirect_to root_path
  end

  def destroy
    @task = Relationship.find(params[:id]).task
    current_user.unfollow!(@task)
    redirect_to root_path
  end
end
