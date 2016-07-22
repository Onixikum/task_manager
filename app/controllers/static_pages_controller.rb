class StaticPagesController < ApplicationController #:nodoc:
  def home
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
  end
end
