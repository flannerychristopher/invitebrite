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
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "Event Created"
      event.attendees << current_user
      @invitation = Invitation.new
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @invitation = @event.invitations.find(params[:id])
    # @event_attendees = @event.attendees.paginate(page: params[:page], per_page: 10)
    @nil_resonses = @event.invitations.where(response: nil)
    @yes_responses = @event.invitations.where(response: 'yes')
    @invited = @event.invitations.where(response: 'invited')
    @not_invited = Invitation.all.where(attended_event_id: @event.id).where(response: nil)
    @maybe_responses = @event.invitations.where(response: 'maybe')
    @no_responses = @event.invitations.where(response: 'no')
  end

  private

      def event_params
        params.require(:event).permit(:title, :date, :location,
                                     :description)
      end


end
