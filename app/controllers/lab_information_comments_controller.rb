class LabInformationCommentsController < ApplicationController
  load_and_authorize_resource :lab_information
  load_and_authorize_resource :lab_information_comment, through: :lab_information
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def create
  	@laboratory = Laboratory.find(params[:laboratory_id])
  	@lab_information = LabInformation.find(params[:lab_information_id])
  	comment = LabInformationComment.new(lab_information_comment_params)
  	comment.user_id = current_user.id
  	comment.lab_information_id = @lab_information.id
  	comment.save
    @comment = LabInformationComment.new
  end

  def destroy
  	laboratory = Laboratory.find(params[:laboratory_id])
  	lab_information = LabInformation.find(params[:lab_information_id])
  	comment = LabInformationComment.find(params[:id])
  	comment.destroy
  	redirect_to laboratory_lab_information_path(laboratory,lab_information)
  end

  private
  def lab_information_comment_params
  	params.require(:lab_information_comment).permit(:content)
  end
end
