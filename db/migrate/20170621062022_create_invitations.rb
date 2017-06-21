class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations, id: false do |t|
      t.integer :attendee_id
      t.integer :attended_event_id
    end
    add_index :invitations, :attendee_id
    add_index :invitations, :attended_event_id
    add_index :invitations, [:attendee_id, :attended_event_id], unique: true
  end
end
