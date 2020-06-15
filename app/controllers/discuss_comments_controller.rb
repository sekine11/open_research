class DiscussCommentsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @discuss_comment = DiscussComment.new(discuss_comment_params)
    @discuss_comment.user_id = current_user.id
    @discuss_comment.discussion_id = @discussion.id
    @discuss_comment.transaction do
      @discuss_comment.save
      @discussion.update(commented_at: Time.now)
      @discuss_comment = QuesComment.new
    end
    rescue => e
      redirect_back(fallback_location: root_path)
  end

  def destroy
    @discussion = Discussion.find(params[:discussion_id])
    discuss_comment = DiscussComment.find(params[:id])
    discuss_comment.destroy
    @discuss_comment = DiscussComment.new
  end

  private

  def discuss_comment_params
    params.require(:discuss_comment).permit(:content)
  end
end
