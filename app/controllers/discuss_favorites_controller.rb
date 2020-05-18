class DiscussFavoritesController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end
  
  def create
  	@discussion = Discussion.find(params[:discussion_id])
  	DiscussFavorite.create(user_id: current_user.id, discussion_id: @discussion.id)
  end

  def destroy
  	@discussion = Discussion.find(params[:discussion_id])
    current_user.discuss_favorites.find_by(discussion_id: @discussion.id).destroy
  end
end
