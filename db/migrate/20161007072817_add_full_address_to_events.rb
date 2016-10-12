class AddFullAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :full_address, :string
  end
end
