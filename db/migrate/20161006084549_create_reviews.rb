class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.integer :score
      t.text :comment
      t.string :event_title

      t.timestamps null: false
    end
  end
end
