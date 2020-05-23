class LaboratoriesController < ApplicationController
  def new
    @laboratory = Laboratory.new
  end

  def show
    @laboratory = Laboratory.find(params[:id])
    @lab_tasks = @laboratory.lab_tasks.order(created_at: "DESC")
    @lab_task = LabTask.new
    @events = Event.where(laboratory_id: params[:id])
    @event = Event.new
  end

  def edit
  end

  def update
  end

  def create
    @laboratory = Laboratory.new(laboratory_params)
    @laboratory.user_id = current_user.id
    @laboratory.save
    redirect_to @laboratory
  end

  private
  def laboratory_params
    params.require(:laboratory).permit(:name)
  end
end
