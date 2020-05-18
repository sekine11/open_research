class LabInformationChecksController < ApplicationController
  load_and_authorize_resource :lab_information
  load_and_authorize_resource :lab_information_check, through: :lab_information
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def create
  	@laboratory = Laboratory.find(params[:laboratory_id])
  	@lab_information = LabInformation.find(params[:lab_information_id])
  	check = LabInformationCheck.create(user_id: current_user.id, lab_information_id: params[:lab_information_id])
  end

  def destroy
  	@laboratory = Laboratory.find(params[:laboratory_id])
  	@lab_information = LabInformation.find(params[:lab_information_id])
  	current_user.lab_information_checks.find_by(lab_information_id: @lab_information.id).destroy
  end
end
