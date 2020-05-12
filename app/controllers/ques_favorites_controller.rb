class QuesFavoritesController < ApplicationController
  def create
  	question = Question.find(params[:question_id])
  	QuesFavorite.create(user_id: current_user.id, question_id: question.id)
  	redirect_to question
  end

  def destroy
  	question = Question.find(params[:question_id])
    current_user.ques_favorites.find_by(question_id: question.id).destroy
    redirect_to question
  end
end
