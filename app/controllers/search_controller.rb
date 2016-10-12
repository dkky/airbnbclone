class SearchController < ApplicationController

  def search
    if params[:q].nil?
      @events = []
      gon.search_locations = []
    else
      @events = Event.search params[:q]
      # array = []
      # @events.each do |event|
      #   array << {lat: event.latitude, lng: event.longitude, infowindow: render_to_string(:partial => "map", :locals => { :event => event})}
      # end
      # gon.search_locations = array
      @hash = Gmaps4rails.build_markers(@events) do |event, marker|
        marker.lat event.latitude
        marker.lng event.longitude
        marker.json({:id => event.id })
        # marker.picture({
        #   anchor: [50,50],
        #   :url => "/mid-star.png",
        #   :width => 50,
        #   :height => 50})
        marker.infowindow render_to_string(:partial => "map", :locals => { :event => event})
      end
    end

  end


end
