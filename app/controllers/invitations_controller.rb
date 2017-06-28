class InvitationsController < ApplicationController

  def new
  end

  def create
    event.invitations.build(attendee_id: invitation_params[:attendee_id])
    if event.save
      redirect_to event
      flash[:success] = "Invitation sent!"
    else
      render 'new'
    end
  end

  def update
    event = Event.find(invitation_params[:attended_event_id])
    invitation = event.invitations.find_by(attendee_id: current_user.id)

    if invitation.update_attributes!(invitation_params)
      byebug
      flash[:success] = "Reply sent!"
      redirect_to event
    else
      flash.now[:danger] = "error"
    end
  end

  private

    def invitation_params
      params.require(:invitation).permit(:attended_event_id, :attendee_id, :response)
    end

  end
