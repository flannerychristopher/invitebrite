class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def index
    #@events = Event.all
    #@events = Event.paginate(page: params[:page], per_page: 5)
    @future_events = Event.future.paginate(page: params[:page], per_page: 5)
    @past_events = Event.past.reverse.last(5)
  end

  def past
    @past_events = Event.past.paginate(page: params[:page], per_page: 5)
  end

  def new
    @event = Event.new
  end

  def create
    #@event = Event.new(event_params)
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "Event Created"
      @event.attendees << current_user
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @invitation = Invitation.new
  end

  private

      def event_params
        params.require(:event).permit(:title, :date, :location,
                                     :description)
      end


end
