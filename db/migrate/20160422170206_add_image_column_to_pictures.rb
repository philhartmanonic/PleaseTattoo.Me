class AddImageColumnToPictures < ActiveRecord::Migration
  def change
  	add_attachment :pictures, :image
  end
end
