class AddNameAndAddressToParlors < ActiveRecord::Migration
  def change
  	add_column :parlors, :name, :string
  	add_column :parlors, :street_number, :integer
  	add_column :parlors, :street_direction, :string
  	add_column :parlors, :street_type, :string
  	add_column :parlors, :unit, :string
  	add_column :parlors, :city, :string
  	add_column :parlors, :state, :string
  	add_column :parlors, :zip, :string
  end
end
