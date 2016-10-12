class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :status
      t.string :comment
      t.string :no_of_kids
      t.references :user
      t.references :event
      t.timestamps null: false
    end
  end
end
