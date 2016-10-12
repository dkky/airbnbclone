class UsersController < ApplicationController
  def show
    @review = Review.new
    @user = User.find(params[:id])
    @past_events = Event.where("user_id = ? AND start_date <= ?", @user.id, Date.today)
    @upcoming_events = Event.where("user_id = ? AND start_date > ?", @user.id, Date.today)
  end

  def myeventsandrequests
    @user = current_user
    @events = Event.where("user_id = ? AND start_date > ?", @user.id, Date.today)
    @requests = Request.where("user_id = ?", @user.id)
  end

end
