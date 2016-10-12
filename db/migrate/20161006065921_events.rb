class Events < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.string  :event_type
      t.string  :title, null: false
      t.string  :location
      t.date    :start_date
      t.date    :end_date
      t.time    :start_time
      t.time    :end_time
      t.string  :description
      t.boolean :isfree, default: true
      t.float   :price
      t.integer :open_spots, null: false
      t.string  :age_range
      t.string  :event_pic
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

