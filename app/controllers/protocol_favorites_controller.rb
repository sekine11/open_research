class ProtocolFavoritesController < ApplicationController
  def create
  	protocol = Protocol.find(params[:protocol_id])
  	ProtocolFavorite.create(user_id: current_user.id, protocol_id: protocol.id)
  	redirect_to protocol
  end

  def destroy
  	protocol = Protocol.find(params[:protocol_id])
    current_user.protocol_favorites.find_by(protocol_id: protocol.id).destroy
    redirect_to protocol
  end
end
