class RemoveIndexFromInvitation < ActiveRecord::Migration[5.1]
  def change
    remove_index "invitations", name: "index_invitations_on_attended_event_id"
    remove_index "invitations", name: "index_invitations_on_attendee_id_and_attended_event_id", unique: true
    remove_index "invitations", name: "index_invitations_on_attendee_id"
  end
end
