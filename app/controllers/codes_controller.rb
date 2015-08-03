class CodesController < ApplicationController

  def update
  	body = params[:code]
  	code = Code.find_by_body_and_used(body, false)
  	if code
  		code.update_attributes used: true
  		current_user.update_attributes paid: true
  		redirect_to root_path and return
  	else
  		redirect_to new_charge_path(bad_code: true)
  	end

  end
end
