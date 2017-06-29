module EventsHelper

  # returns true is current_user is the even creator
  def creator?
    current_user === @event.creator
  end

  # returns true if current_user has received invitation for event
  def invited?
    !(current_user === @event.creator) && @event.attendees.include?(current_user)
  end

end
