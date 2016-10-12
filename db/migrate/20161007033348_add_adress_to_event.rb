class AddAdressToEvent < ActiveRecord::Migration
  def change
    add_column :events, :housenumber,:string
    add_column :events, :street, :string
    add_column :events, :postcode, :integer
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :country, :string
  end
end
