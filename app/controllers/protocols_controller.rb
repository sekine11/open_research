class ProtocolsController < ApplicationController


  def new
    @protocol = Protocol.new
  end

  def show
    @protocol = Protocol.find(params[:id])
  end

  def index
    if params[:tag]
      @protocols = Protocol.tagged_with(params[:tag]).order(created_at: "DESC").page(params[:page]).per(20)
    else
      @protocols = Protocol.all.order(created_at: "DESC").page(params[:page]).per(20)
    end
    @rank_protocols = Protocol.all.order(created_at: "DESC")
  end

  def edit
    @protocol = Protocol.find(params[:id])
  end

  def create
    @protocol = Protocol.new(protocol_params)
    @protocol.user_id = current_user.id
    if @protocol.save
      redirect_to @protocol, notice: "質問を投稿しました"
    else
      @protocol = Protocol.new
      render "new"
    end
  end

  def update
    @protocol = Protocol.find(params[:id])
    if @protocol.update(protocol_params)
      redirect_to @protocol, notice: "質問を編集しました"
    else
      render "edit"
    end
  end

  def destroy
    protocol = Protocol.find(params[:id])
    protocol.destroy
    redirect_to protocols_path
  end

  private
  def protocol_params
    params.require(:protocol).permit(:subject, :content, :tags, protocol_list: [])
  end
end
