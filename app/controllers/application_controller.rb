class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      rails_admin_path
    when User
      home_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:public_name, :private_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:public_name, :private_name, :image])
  end

  def set_ranking
    @rank_protocols = Protocol.order('impressions_count DESC').take(10)
    @rank_discussions = Discussion.order('impressions_count DESC').take(10)
    @rank_questions = Question.order('impressions_count DESC').take(10)
  end

  def current_ability
    if user_signed_in?
      @current_ability ||= ::UserAbility.new(current_user)
    elsif admin_signed_in?
      @current_ability ||= ::AdminAbility.new(current_admin)
    else
      @current_ability ||= ::UserAbility.new(nil)
    end
  end
end
