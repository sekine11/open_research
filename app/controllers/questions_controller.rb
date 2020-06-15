class QuestionsController < ApplicationController
  impressionist actions: [:show]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
  end
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    @question = Question.new
  end

  def show
    @ques_comment = QuesComment.new
  end

  def index
    @tags = Question.tags_on(:questions)
    if params[:tag]
      @q = Question.ransack(params[:q])
      @questions = Question.tagged_with(params[:tag]).includes(
      :user, :questions, :question_taggings, :ques_favorites, :ques_comments
      ).order(commented_at: "DESC").page(params[:question_page])
    else
      if params[:q].present?
        params[:q][:subject_or_content_cont_any] = params[:q][:subject_or_content_cont_any].split(/\p{blank}|\s|\t/)
        @q = Question.ransack(params[:q])
      else
        @q = Question.ransack(params[:q])
      end
      @questions = @q.result(distinct: true).includes(
      :user, :questions, :question_taggings, :ques_favorites, :ques_comments
      ).order(commented_at: "DESC").page(params[:question_page])
    end
    # 過去7日間を指定
    ago = Range.new(Time.now - 604800, Time.now)
    @rank_questions = Question.where(created_at: ago).order('impressions_count DESC').take(10)
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.commented_at = Time.now
    if @question.save
      redirect_to @question, notice: "質問を投稿しました"
    else
      render "new"
    end
  end

  def update
    if params[:status]
      @question.update(status: params[:status])
    else
      if @question.update(question_params)
        redirect_to @question, notice: "質問を編集しました"
      else
        render "edit"
      end
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: "削除しました"
  end

  private

  def question_params
    params.require(:question).permit(:subject, :content, :status, :tags, question_list: [])
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
