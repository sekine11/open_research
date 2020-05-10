class LabInformationChecksController < ApplicationController
  def create
  	laboratory = Laboratory.find(params[:laboratory_id])
  	lab_information = LabInformation.find(params[:lab_information_id])
  	check = LabInformationCheck.create(user_id: current_user.id, lab_information_id: params[:lab_information_id])
  	redirect_to laboratory_lab_information_path(laboratory,lab_information)
  end

  def destroy
  	laboratory = Laboratory.find(params[:laboratory_id])
  	lab_information = LabInformation.find(params[:lab_information_id])
  	current_user.lab_information_checks.find_by(lab_information_id: lab_information.id).destroy
  	redirect_to laboratory_lab_information_path(laboratory,lab_information)
  end
end
