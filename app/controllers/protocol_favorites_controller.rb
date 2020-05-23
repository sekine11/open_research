class ProtocolFavoritesController < ApplicationController
  def create
  	@protocol = Protocol.find(params[:protocol_id])
  	ProtocolFavorite.create(user_id: current_user.id, protocol_id: @protocol.id)
  end

  def destroy
  	@protocol = Protocol.find(params[:protocol_id])
    current_user.protocol_favorites.find_by(protocol_id: @protocol.id).destroy
  end
end
