class ProtocolsController < ApplicationController
  impressionist actions: [:show]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end

  def new
    @protocol = Protocol.new
  end

  def show
    @protocol = Protocol.find(params[:id])
  end

  def index
    @tags = Protocol.tags_on(:protocols)
    # タグ検索
    if params[:tag]
      @q = Protocol.ransack(params[:q])
      @protocols = Protocol.tagged_with(params[:tag]).includes(
      :user, :protocols, :protocol_taggings, :protocol_favorites
      ).order(updated_at: "DESC").page(params[:protocol_page]).per(20)
    else
      # 文字列検索
      if params[:q].present?
        # 文字列検索の前処理
        params[:q][:subject_or_content_cont_any] = params[:q][:subject_or_content_cont_any].split(/\p{blank}|\s|\t/)
        @q = Protocol.ransack(params[:q])
      else
        @q = Protocol.ransack(params[:q])
      end
      @protocols = @q.result(distinct: true).includes(
      :user, :protocols, :protocol_taggings, :protocol_favorites
      ).order(updated_at: "DESC").page(params[:protocol_page])
    end
    @rank_protocols = Protocol.order('impressions_count DESC').take(10)
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
