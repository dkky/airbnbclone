class RemoveEventPicFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :event_pic, :string
  end
end
