class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    #@event = Event.new(event_params)
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "Event Created"
      #@event.attendees << current_user
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :location,
                                 :description)
  end


end
