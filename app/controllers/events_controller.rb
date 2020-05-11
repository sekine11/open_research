class EventsController < ApplicationController
  def create
  	laboratory = Laboratory.find(params[:laboratory_id])
  	event = Event.new(event_params)
  	event.user_id = current_user.id
  	event.laboratory_id = params[:laboratory_id]
  	event.save
  	redirect_to laboratory
  end

  def destroy
  	laboratory = Laboratory.find(params[:laboratory_id])
  	event = Event.find(params[:id])
  	event.destroy
  	redirect_to laboratory
  end

  private
  def event_params
  	params.require(:event).permit(:title, :start, :end)
  end
end