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
    # 過去7日間を指定
    ago = Range.new(Time.now - 604800, Time.now)
    @rank_protocols = Protocol.where(created_at: ago).order('impressions_count DESC').take(10)
    @rank_discussions = Discussion.where(created_at: ago).order('impressions_count DESC').take(10)
    @rank_questions = Question.where(created_at: ago).order('impressions_count DESC').take(10)
  end
end
