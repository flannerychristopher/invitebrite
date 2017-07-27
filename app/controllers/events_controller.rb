class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def index
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
      @event.invitations.create(attendee_id: current_user.id, response: 'yes')
      @invitation = Invitation.new
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])

    if logged_in?
      @invitation = @event.invitations.find_by(attendee_id: current_user.id)
    else
      @invitation = Invitation.new
    end

    @new_invitation = Invitation.new
    @not_invited = User.includes(:invitations).where( :invitations => { :id => nil } )

    @yes_responses = @event.invitations.where(response: 'yes').page(params[:yes])
    @invited = @event.invitations.where(response: 'invited')
    @maybe_responses = @event.invitations.where(response: 'maybe')
    @no_responses = @event.invitations.where(response: 'no')
  end

  private

    def event_params
      params.require(:event).permit(:title, :date, :location, :description)
    end

end
