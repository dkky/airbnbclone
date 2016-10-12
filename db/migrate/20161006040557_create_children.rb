class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name
      t.date :date_of_birth
      
      t.timestamps null: false
    end
  end
end
