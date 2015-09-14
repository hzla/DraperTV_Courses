class ChargesController < ApplicationController
  include ApplicationHelper
  skip_before_filter :ensure_payment


  def new
    @bad_code = params['bad_code'] == "true"
  end

  def create
    #create error catching
    if !current_user.customer_id #find or create customer from stripe
      @customer = Stripe::Customer.create(:description => current_user.full_name, :source => params["stripeToken"])
      current_user.update_attribute :customer_id, @customer.id
    else
      @customer = Stripe::Customer.retrieve(current_user.customer_id)
    end
    @plan = params["plan"] || "Hero" 
    #find or create subscription
    if @customer.subscriptions.count > 0
      @subscription = @customer.subscriptions.first
      @subscription.plan = @plan
      @subscription.save
    else
      @subscription = @customer.subscriptions.create plan: @plan
    end
    current_user.update_attributes email: params["email"], plan: @plan, paid: true
    UserMailer.payment_confirmation(current_user).deliver
    
    if params[:lesson_id] !=  ""
      redirect_to lesson_path(params[:lesson_id]) and return
    else
      redirect_to root_path 
      
    end
  end

  def edit 
  end

  def update
    @customer = Stripe::Customer.retrieve(current_user.customer_id)
    @plan = params["plan"] || "Hero"
    @subscription = @customer.subscriptions.first
    @subscription.plan = @plan
    @subscription.save
    current_user.update_attributes plan: @plan, paid: true
    redirect_to edit_user_path
  end

  def destroy
    if current_user.customer_id
      @customer = Stripe::Customer.retrieve(current_user.customer_id)
      subscription = @customer.subscriptions.each(&:delete)
      current_user.update_attribute :paid, false
      current_user.update_attribute :customer_id, nil
    else
      current_user.update_attributes paid: false
    end
    render json: {message:  "Your subscription has been cancelled."}
  end
end
