class DiscussionsController < ApplicationController
  impressionist actions: [:show]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end
  before_action :find_discussion, only: [:show, :edit, :update, :destroy]

  def new
    @discussion = Discussion.new
  end

  def show
    @discuss_comment = DiscussComment.new
  end

  def index
    @tags = Discussion.tags_on(:discussions)
    # tag検索の分岐
    if params[:tag]
      @q = Discussion.ransack(params[:q])
      @discussions = Discussion.tagged_with(params[:tag]).includes(
      :user, :discussions, :discussion_taggings, :discuss_favorites, :discuss_comments
      ).order(commented_at: "DESC").page(params[:discussion_page]).per(20)
    else
      # 文字検索の分岐
      if params[:q].present?
        # スペース、タブ区切りでの検索のための前処理
        params[:q][:subject_or_content_cont_any] = params[:q][:subject_or_content_cont_any].split(/\p{blank}|\s|\t/)
        @q = Discussion.ransack(params[:q])
      else
        @q = Discussion.ransack(params[:q])
      end
      @discussions = @q.result(distinct: true).includes(
       :user, :discussions, :discussion_taggings, :discuss_favorites, :discuss_comments
      ).order(commented_at: "DESC").page(params[:discussion_page])
    end
    @rank_discussions = Discussion.order('impressions_count DESC').take(10)
  end

  def edit
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user_id = current_user.id
    @discussion.commented_at = Time.now
    if @discussion.save
      redirect_to @discussion, notice: "議論を開始しました"
    else
      render "new"
    end
  end

  def update
    if params[:status]
      @discussion.update(status: params[:status])
    else
      if @discussion.update(discussion_params)
        redirect_to @discussion, notice: "議論を編集しました"
      else
        render "edit"
      end
    end
  end

  def destroy
    discussion.destroy
    redirect_to discussions_path, notice: "削除しました"
  end

  private

  def discussion_params
    params.require(:discussion).permit(:subject, :content, :status, :tags, discussion_list: [])
  end

  def find_discussion
    @discussion = Discussion.find(params[:id])
  end
end
