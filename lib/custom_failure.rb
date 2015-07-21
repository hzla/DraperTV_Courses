class CustomFailure < Devise::FailureApp
  def redirect_url
     '/users/sign_in?error=incorrect_log_in'
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end