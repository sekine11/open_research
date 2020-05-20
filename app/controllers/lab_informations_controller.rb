class LabInformationsController < ApplicationController
  load_and_authorize_resource :laboratory
  load_and_authorize_resource :lab_information, through: :laboratory
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def new
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_information = LabInformation.new
  end

  def show
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_information = LabInformation.find(params[:id])
    @comment = LabInformationComment.new
  end

  def index
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_informations = @laboratory.lab_informations.order(created_at: "DESC").page(params[:page]).per(20)
  end

  def create
    @laboratory = Laboratory.find(params[:laboratory_id])
    if lab_information_params[:document] != ""
      lab_information_params[:document].open # cancancanと一緒にrefile使用で起こる不都合を修正
    end
    @lab_information = LabInformation.new(lab_information_params)
    @lab_information.user_id = current_user.id
    @lab_information.laboratory_id = @laboratory.id
    if @lab_information.save
      redirect_to laboratory_lab_information_path(@laboratory,@lab_information)
    else
      render "new"
    end
  end

  def destroy
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_information = LabInformation.find(params[:id])
    @lab_information.destroy
    redirect_to laboratory_lab_informations_path(@laboratory), notice: "お知らせを削除しました"
  end

  private
  def lab_information_params
    params.require(:lab_information).permit(:subject, :content, :document)
  end

end
