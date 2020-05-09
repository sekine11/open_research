class DiscussCommentsController < ApplicationController
  def create
  	discussion = Discussion.find(params[:discussion_id])
  	discuss_comment = DiscussComment.new(discuss_comment_params)
    discuss_comment.user_id = current_user.id
  	discuss_comment.discussion_id = discussion.id
  	discuss_comment.save
  	redirect_to discussion
  end

  def destroy
  	discussion = Discussion.find(params[:discussion_id])
  	discuss_comment = DiscussComment.find(params[:id])
    discuss_comment.destroy
    redirect_to discussion
  end

  private
  def discuss_comment_params
    params.require(:discuss_comment).permit(:content)
  end

end
