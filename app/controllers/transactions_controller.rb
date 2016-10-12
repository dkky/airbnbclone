class TransactionsController < ApplicationController
  def new
    gon.client_token = generate_client_token
    @event_id = params[:event_id]
    @charge = params[:charge]
    @comment = params[:comment]
  end

  def create
    @event = Event.find(params[:event_id])
    @no_of_kids = params[:charge].to_f / @event.price
    @request = current_user.requests.new(event_id: params[:event_id], comment: params[:comment], no_of_kids: @no_of_kids, status: "Pending")
    @result = Braintree::Transaction.sale(
              amount: params[:charge],
              payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      @request.save
      # RequestMailer.booking_emailcustomer(@reservation.user, @listing.user, @reservation.id).deliver_now
      # RequestMailer.booking_emailhost(@reservation.user, @listing.user, @reservation.id).deliver_now
      redirect_to @event, notice: "Congraulations! Your payment has been received and booking has been confirmed!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      redirect_to @event
    end
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end
end
