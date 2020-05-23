class LabInformationsController < ApplicationController
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
    @lab_information = LabInformation.new(lab_information_params)
    @lab_information.user_id = current_user.id
    @lab_information.laboratory_id = @laboratory.id
    @lab_information.save
    redirect_to laboratory_lab_information_path(@laboratory,@lab_information)
  end

  def destroy
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_information = LabInformation.find(params[:id])
    @lab_information.destroy
    redirect_to laboratory_lab_informations_path(@laboratory)
  end

  private
  def lab_information_params
    params.require(:lab_information).permit(:subject, :content)
  end

end
