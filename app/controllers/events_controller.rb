class EventsController < ApplicationController

before_action :set_event, only: [:show, :update, :edit, :destroy]




  def index
    @events = Event.where(event_type: "Event")
    @suggestions = Event.where(event_type: "Suggestion")
  end

  def new
    @event= Event.new
  end

  def create

    @event = Event.new(event_params)
    # @event.full_address = [params[:event][:housenumber], params[:event][:street], params[:event][:postcode], params[:event][:city], params[:event][:state], params[:event][:country]].join(',')

      if @event.save
        @event.update(user_id: current_user.id)
        redirect_to @event, notice: "Your event is successfully created!"
      else
        render 'new'
      end
  end

  def update
    if @event.update(event_params)

      @event.user_id = current_user.id
      redirect_to event_path(@event.id)
    else
      redirect_to edit_event_path(@event.id)
    end

  end

  def show
    @event = Event.find(params[:id])
    gon.hashh = {lat: @event.latitude, lng: @event.longitude, infowindow: "You are here"}
  end




private

  def event_params
      params.require(:event).permit(:event_type, :title, :location, :start_date, :end_date, :start_time, :end_time, :description, :isfree, :price, :open_spots, :age_range, :event_pic, :user_id, :housenumber, :street, :postcode, :city, :state, :country, {event_pic: []}, category_ids:[])
  end

  def set_event
    @event = Event.find(params[:id])

  end

end # END OF CLASS

