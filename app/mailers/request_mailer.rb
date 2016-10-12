class RequestMailer < ApplicationMailer
  def booking_emailhost(customer, host, request_id, event)
    @customer = customer
    @request_id = request_id
    @host = host
    @event = event

    mail(to: @host.email, subject: 'You have received a new request!')
  end

  def booking_emailcustomer(customer, host, request_id, event)
    @customer = customer
    @request_id = request_id
    @host = host
    @event = event

    mail(to: @customer.email, subject: "Your event booking request has been received, and is awaiting the host's confirmation.")
  end
end
