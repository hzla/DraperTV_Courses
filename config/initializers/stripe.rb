if Rails.env.production?
	Rails.configuration.stripe = {
	  :publishable_key => ENV['PUBLISHABLE_KEY'],
	  :secret_key      => ENV['SECRET_KEY']
	}

	Stripe.api_key = ENV['STRIPE_API_KEY']
else
	Rails.configuration.stripe = {
	  :publishable_key => ENV['TEST_PUBLISHABLE_KEY']
	}
	Stripe.api_key = ENV['TEST_STRIPE_API_KEY']
	p "in test mode"
end