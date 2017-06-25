class AddResponseToInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :response, :string
  end
end
