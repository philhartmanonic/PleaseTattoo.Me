class AddStreetNameToParlors < ActiveRecord::Migration
  def change
  	add_column :parlors, :street_name, :string
  end
end
