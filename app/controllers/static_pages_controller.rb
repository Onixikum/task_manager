class StaticPagesController < ApplicationController #:nodoc:
  before_action :signed_in_user, only: :perform

  def home
    if signed_in?
      @feed_items = Task.paginate(page: params[:page])
      @num_of_tasks = Task.count
    end
  end

  def perform
    @user = current_user
    @feed_items = @user.feed.paginate(page: params[:page])
  end
end
