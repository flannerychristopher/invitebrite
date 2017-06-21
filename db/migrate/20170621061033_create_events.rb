class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string    :title
      t.text      :description
      t.string    :location
      t.datetime  :date

      t.integer   :creator_id,    foreign_key: true

      t.timestamps
    end
  end
end
