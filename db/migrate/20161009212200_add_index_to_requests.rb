class AddIndexToRequests < ActiveRecord::Migration
  def change
    add_index :requests, :user_id
    add_index :requests, :event_id
  end
end