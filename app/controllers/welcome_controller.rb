class WelcomeController < ApplicationController

  def home
    @reviews = Review.all
    @events = Event.where(event_type: "Event").order("created_at DESC").limit(4)
    @suggestions = Event.where(event_type: "Suggestion").limit(4)
    @users = User.all
    all_events = Event.all
    gon.hashhh = []
    all_events.each do |event|
      gon.hashhh << {lat: event.latitude, lng: event.longitude, infowindow: render_to_string(:partial => "event_map", :locals => { :event => event})}
    end
  end

end
