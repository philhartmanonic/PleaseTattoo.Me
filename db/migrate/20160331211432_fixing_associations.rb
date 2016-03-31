class FixingAssociations < ActiveRecord::Migration
  def change
  	remove_column :artists, :parlors_id
  	add_reference :artists, :parlor, index: true
  	remove_column :tats, :artists_id
  	add_reference :tats, :artist, index: true
  end
end
