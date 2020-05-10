class LabTasksController < ApplicationController
  def create
  	@lab_task = LabTask.new(lab_task_params)
  	@lab_task.user_id = current_user.id
  	laboratory = Laboratory.find(params[:laboratory_id])
  	@lab_task.laboratory_id = laboratory.id
  	@lab_task.save
  	redirect_to laboratory
  end

  def update
  	@lab_task = LabTask.find(params[:id])
  	@lab_task.update(status: params[:status])
  	laboratory = Laboratory.find(params[:laboratory_id])
  	redirect_to laboratory
  end

  def destroy
  	lab_task = LabTask.find(params[:id])
  	lab_task.destroy
  	laboratory = Laboratory.find(params[:laboratory_id])
  	redirect_to laboratory
  end

  private
  def lab_task_params
  	params.require(:lab_task).permit(:content, :status)
  end
end
