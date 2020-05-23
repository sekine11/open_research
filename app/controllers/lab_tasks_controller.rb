class LabTasksController < ApplicationController
  def create
  	lab_task = LabTask.new(lab_task_params)
  	lab_task.user_id = current_user.id
  	@laboratory = Laboratory.find(params[:laboratory_id])
  	lab_task.laboratory_id = @laboratory.id
  	lab_task.save
    @lab_task = LabTask.new
    @lab_tasks = @laboratory.lab_tasks.order(created_at: "DESC")
  end

  def update
  	@task = LabTask.find(params[:id])
  	@task.update(status: params[:status])
  	@laboratory = Laboratory.find(params[:laboratory_id])
  end

  def destroy
  	lab_task = LabTask.find(params[:id])
  	lab_task.destroy
  	@laboratory = Laboratory.find(params[:laboratory_id])
    @lab_tasks = @laboratory.lab_tasks.order(created_at: "DESC")
  end

  private
  def lab_task_params
  	params.require(:lab_task).permit(:content, :status)
  end
end
