class AddAssociations < ActiveRecord::Migration
  def change
  	add_reference :artists, :parlors, index: true
  	add_reference :tats, :artists, index: true
  	add_reference :tags, polymorphic: true
  	add_column :tags, :name, :string
  	add_column :tags, :score, :integer
  end
end
