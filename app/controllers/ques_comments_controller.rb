class QuesCommentsController < ApplicationController
  def create
  	question = Question.find(params[:question_id])
  	ques_comment = QuesComment.new(ques_comment_params)
  	ques_comment.user_id = current_user.id
  	ques_comment.question_id = question.id
  	ques_comment.save
  	redirect_to question_path(question)
  end

  def destroy
  	question = Question.find(params[:question_id])
  	ques_comment = QuesComment.find(params[:id])
    ques_comment.destroy
    redirect_to question_path(question)
  end

  private
  def ques_comment_params
    params.require(:ques_comment).permit(:comment)
  end

end
