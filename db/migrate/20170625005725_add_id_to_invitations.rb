class AddIdToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :id, :primary_key
  end
end
