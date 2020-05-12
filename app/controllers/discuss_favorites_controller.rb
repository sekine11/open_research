class DiscussFavoritesController < ApplicationController
  def create
  	discussion = Discussion.find(params[:discussion_id])
  	DiscussFavorite.create(user_id: current_user.id, discussion_id: discussion.id)
  	redirect_to discussion
  end

  def destroy
  	discussion = Discussion.find(params[:discussion_id])
    current_user.discuss_favorites.find_by(discussion_id: discussion.id).destroy
    redirect_to discussion
  end
end
