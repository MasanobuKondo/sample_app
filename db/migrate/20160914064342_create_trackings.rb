class CreateTrackings < ActiveRecord::Migration[5.0]
  def change
    create_table :trackings do |t|
      t.string :sid
      t.datetime :start_time
      t.string :from
      t.string :to
      t.string :duration1
      t.string :duration2

      t.timestamps
    end
  end
end
