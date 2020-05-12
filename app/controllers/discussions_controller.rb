class DiscussionsController < ApplicationController
  
  def new
    @discussion = Discussion.new
  end

  def show
    @discussion = Discussion.find(params[:id])
    @discuss_comment = DiscussComment.new
  end

  def index
    if params[:tag]
      if params[:q] != nil
        @q = Discussion.ransack(params[:q].split)
      else
        @q = Discussion.ransack(params[:q])
      end
      @discussions = Discussion.tagged_with(params[:tag]).order(created_at: "DESC").page(params[:page]).per(20)
    else
      if params[:q] != nil
        @q = Discussion.ransack(params[:q].split)
      else
        @q = Discussion.ransack(params[:q])
      end
      @discussions = @q.result(distinct: true).order(updated_at: "DESC").page(params[:page]).per(20)
    end
    @rank_discussions = Discussion.all.order(created_at: "DESC")
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
      @discussion = Discussion.new
      render "new"
    end
  end

  def update
    if params[:status]
      @discussion = Discussion.find(params[:id])
      if @discussion.update(status: params[:status])
        redirect_to @discussion, notice: "議論を「終了」にしました"
      else
        render "edit"
      end
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
    redirect_to discussions_path
  end

  private
  def discussion_params
    params.require(:discussion).permit(:subject, :content, :status, :tags, discussion_list: [])
  end

end
