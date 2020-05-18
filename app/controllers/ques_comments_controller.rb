class QuesCommentsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end

  def create
  	@question = Question.find(params[:question_id])
  	ques_comment = QuesComment.new(ques_comment_params)
  	ques_comment.user_id = current_user.id
  	ques_comment.question_id = @question.id
  	ques_comment.save
    @ques_comment = QuesComment.new
  end

  def destroy
  	@question = Question.find(params[:question_id])
  	ques_comment = QuesComment.find(params[:id])
    ques_comment.destroy
    @ques_comment = QuesComment.new
  end

  private
  def ques_comment_params
    params.require(:ques_comment).permit(:content)
  end

end
