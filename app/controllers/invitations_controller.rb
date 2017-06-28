class InvitationsController < ApplicationController

  def new
    #@invitation = Invitation.new
  end

  def create
    #event = Event.find(invitation_params[:attended_event_id])
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
    invitation = Invitation.find_by(invitation_params[:id])
    # invitation.response = invitation_params[:response]
    # if invitation.update_attributes(:response => invitation_params[:response])
    if invitation.update_attributes(invitation_params)
      invitation.save
      byebug
      flash[:success] = "Reply sent!"
      redirect_to event
    else
      flash.now[:danger] = "error"
    end

    # invitation.update(invitation_params)
    # invitation.reload
    # byebug
    # redirect_to event

  end

  private

    def invitation_params
      params.require(:invitation).permit(:attended_event_id, :attendee_id, :response)
    end

  end
