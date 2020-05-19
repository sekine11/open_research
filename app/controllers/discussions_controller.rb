class DiscussionsController < ApplicationController
  impressionist actions: [:show]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end
  
  def new
    @discussion = Discussion.new
  end

  def show
    @discussion = Discussion.find(params[:id])
    @discuss_comment = DiscussComment.new
  end

  def index
    if params[:tag]
      @q = Discussion.ransack(params[:q])
      @discussions = Discussion.tagged_with(params[:tag]).order(created_at: "DESC").page(params[:discussion_page]).per(20)
    else
      if params[:q] != nil
        params[:q][:subject_or_content_cont_any] = params[:q][:subject_or_content_cont_any].split(/\p{blank}|\s|\t/)
        @q = Discussion.ransack(params[:q])
      else
        @q = Discussion.ransack(params[:q])
      end
      @discussions = @q.result(distinct: true).order(created_at: "DESC").page(params[:discussion_page]).per(20)
    end
    @rank_discussions = Discussion.order('impressions_count DESC').take(10)
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user_id = current_user.id
    if @discussion.save
      redirect_to @discussion, notice: "議論を開始しました"
    else
      render "new"
    end
  end

  def update
    if params[:status]
      @discussion = Discussion.find(params[:id])
      @discussion.update(status: params[:status])
    else
      @discussion = Discussion.find(params[:id])
      if @discussion.update(discussion_params)
        redirect_to @discussion, notice: "議論を編集しました"
      else
        render "edit"
      end
  end
  end

  def destroy
    discussion = Discussion.find(params[:id])
    discussion.destroy
    redirect_to discussions_path, notice: "削除しました"
  end

  private
  def discussion_params
    params.require(:discussion).permit(:subject, :content, :status, :tags, discussion_list: [])
  end

end
