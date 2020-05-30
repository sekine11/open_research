class UsersController < ApplicationController
  authorize_resource class: false
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end

  def hide
    current_user.update(status: false)
    session.clear
    redirect_to root_path
  end

  def reregistrations
    @user = User.new
  end

  def reactive
    user = User.find_by(email: params[:user][:email])
    binding.pry
    if user.valid_password?(params[:user][:password])
      user.update(status: true)
      redirect_to home_path
    end
  end

end
