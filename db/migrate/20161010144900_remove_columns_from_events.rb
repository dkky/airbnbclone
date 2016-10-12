class RemoveColumnsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :housenumber
    remove_column :events, :street
    remove_column :events, :postcode
    remove_column :events, :city
    remove_column :events, :state
    remove_column :events, :country
    remove_column :events, :full_address
  end
end

