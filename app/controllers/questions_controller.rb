class QuestionsController < ApplicationController
  impressionist actions: [:show]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @ques_comment = QuesComment.new
  end

  def index
    if params[:tag]
      @q = Question.ransack(params[:q])
      @questions = Question.tagged_with(params[:tag]).order(created_at: "DESC").page(params[:question_page]).per(20)
    else
      if params[:q] != nil
        params[:q][:subject_or_content_cont_any] = params[:q][:subject_or_content_cont_any].split(/\p{blank}|\s|\t/)
        @q = Question.ransack(params[:q])
      else
        @q = Question.ransack(params[:q])
      end
      @questions = @q.result(distinct: true).order(created_at: "DESC").page(params[:question_page]).per(20)
    end
    @rank_questions = Question.order('impressions_count DESC').take(10)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to @question, notice: "質問を投稿しました"
    else
      render "new"
    end
  end

  def update
  	if params[:status]
  		@question = Question.find(params[:id])
	    @question.update(status: params[:status])
  	else
	    @question = Question.find(params[:id])
	    if @question.update(question_params)
	      redirect_to @question, notice: "質問を編集しました"
	    else
	      render "edit"
	    end
	end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:subject, :content, :status, :tags, question_list: [])
  end

end
