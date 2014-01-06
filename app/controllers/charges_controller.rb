class ChargesController < ApplicationController

def new
end

def create
  # @user = current_user
  # Amount in cents
  @amount = 100

  customer = Stripe::Customer.create(
    # :email => @user.email,
    :email => 'RailsUser@gmail.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end

#Source Tutorial
# https://stripe.com/docs/checkout/guides/rails

end
