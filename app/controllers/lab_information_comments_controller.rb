class LabInformationCommentsController < ApplicationController
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
