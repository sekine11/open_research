class EventsController < ApplicationController
  load_and_authorize_resource :laboratory
  load_and_authorize_resource :event, through: :laboratory
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def create
    @laboratory = Laboratory.find(params[:laboratory_id])
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.laboratory_id = params[:laboratory_id]
    if @event.save
      @event = Event.new
      @events = Event.where(laboratory_id: params[:laboratory_id]).includes(:user)
    end
    @events = Event.where(laboratory_id: params[:laboratory_id]).includes(:user)
  end

  def destroy
    @laboratory = Laboratory.find(params[:laboratory_id])
    @event = Event.find(params[:id])
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end
