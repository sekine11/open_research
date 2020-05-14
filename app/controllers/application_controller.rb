class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def after_sign_in_path_for(resource)
		home_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end

  	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:public_name, :private_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:public_name, :private_name, :image])
  	end
end
