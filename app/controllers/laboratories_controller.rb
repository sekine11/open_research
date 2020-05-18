class LaboratoriesController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

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
    @laboratory = Laboratory.find(params[:id])
    @lab_member = LabMember.new
    @lab_members = @laboratory.lab_members
  end

  def update
    @laboratory = Laboratory.find(params[:id])
    @laboratory.update(laboratory_params)
    redirect_to edit_laboratory_path(@laboratory)
  end

  def create
    @laboratory = Laboratory.new(laboratory_params)
    @laboratory.user_id = current_user.id
    @laboratory.save
    lab_member = LabMember.create(user_id: current_user.id, laboratory_id: @laboratory.id, status: "admin")
    redirect_to @laboratory
  end

  private
  def laboratory_params
    params.require(:laboratory).permit(:name)
  end
end
