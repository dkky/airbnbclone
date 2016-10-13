class UsersController < ApplicationController
  def show
    @review = Review.new
    @user = User.find(params[:id])
    @past_events = Event.where("user_id = ? AND start_date <= ?", @user.id, Date.today)
    @upcoming_events = Event.where("user_id = ? AND start_date > ?", @user.id, Date.today)
    @selectable_events = []
    current_user.requests.each do |request|
      @selectable_events << Event.find(request.event_id).title
    end
  end

  def myeventsandrequests
    @user = current_user
    @events = Event.where("user_id = ? AND start_date > ? AND event_type = ?", @user.id, Date.today, "Event")
    @requests = Request.where("user_id = ?", @user.id)
  end

end
