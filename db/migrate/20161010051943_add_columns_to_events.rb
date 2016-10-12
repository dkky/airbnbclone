class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_pic, :json
    add_column :events, :category_id, :integer
  end
end
