class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_activities = current_user.feed.recent.paginate page: params[:page],
      					 per_page: Settings.length.page                                                          
    end
  end
end
