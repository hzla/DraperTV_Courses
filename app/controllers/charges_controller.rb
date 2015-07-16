class ChargesController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!

  def new
  end

  def create
    if !current_user.customer_id
      @customer = Stripe::Customer.create(
        :description => current_user.full_name,
        :source => params["stripeToken"]
      )
      current_user.update_attributes customer_id: @customer.id
    else
      @customer = Stripe::Customer.retrieve(current_user.customer_id)
    end
    @plan = params["plan"] || "Hero" 
    current_user.update_attributes email: params["email"], plan: @plan
    if @customer.subscriptions.count > 0
      @subscription = @customer.subscriptions.first
      @subscription.plan = @plan
      @subscription.save
    else
      @subscription = @customer.subscriptions.create plan: @plan
    end
  end
end
