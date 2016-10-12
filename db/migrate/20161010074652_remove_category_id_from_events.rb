class RemoveCategoryIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :category_id, :integer
  end
end
