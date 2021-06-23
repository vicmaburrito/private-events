class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
