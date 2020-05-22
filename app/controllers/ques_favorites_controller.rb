class QuesFavoritesController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end

  def create
    @question = Question.find(params[:question_id])
    QuesFavorite.create(user_id: current_user.id, question_id: @question.id)
  end

  def destroy
    @question = Question.find(params[:question_id])
    current_user.ques_favorites.find_by(question_id: @question.id).destroy
  end
end
