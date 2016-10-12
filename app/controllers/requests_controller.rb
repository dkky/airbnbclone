class RequestsController < ApplicationController
	def new
		@request = Request.new
		@event = Event.find(params["button"]["event_id"])
		#@event is only created temporarily as the event id will be obtained from the event show page
	end

	def create
		if Request.where(user_id: current_user.id, event_id: params[:event_id]).empty?
			@request = current_user.requests.new(comment: params[:booking_request][:comment], no_of_kids: params[:booking_request][:no_of_kids], status: "Pending", event_id: params[:event_id])
			@event = Event.find(params[:event_id])
			@host = User.find(@event.user_id)

			if !@event.isfree
				@charge = @event.price * params[:booking_request][:no_of_kids].to_i
			end

			if @event.isfree
				respond_to do |format|
			      if @request.save
			      	@data = "Your request to join the event has been sent"
			        format.js
			       #  RequestMailer.booking_emailcustomer(current_user, @host, @request.id, @event).deliver_now
			      	# RequestMailer.booking_emailhost(current_user, @host, @request.id, @event).deliver_now
			      else
			        format.html {}
			        format.json { render json: "Please submit a valid request" }
			      end
			    end
			else

		  	new_hash = params[:booking_request].merge!(event_id: @event.id, charge: @charge)
		  	byebug
	      redirect_to new_transaction_path(new_hash)
	    end
	  else
	  	respond_to do |format|
	  		@data = "You have already requested to join the event"
	  		format.js
	  	end
	  end

	end

	def confirm
		@request = Request.find(params[:id])
		@request.update(status: "Confirmed")
		respond_to do |format|
			@id = @request.id

			format.js
		end
	end

	def decline
		@request = Request.find(params[:id])
		@request.update(status: "Declined")
		respond_to do |format|
			@id = @request.id
			format.js
		end
	end

	private

	def request_params
		params.require(:request).permit(:comment, :no_of_kids)
	end
end
