class UsersController < ApplicationController
  def hide
  	current_user.update(status: false)
  	session.clear
  	redirect_to root_path
  end
  def reregistration
  	@user = User.new
  end

  def reactive
  	user = User.find_by(email: params[:email])
  	if user.valid_password?(params[:password])
  		user.update(status: true)
  		redirect_to home_path
  	end
  end
  
end