class AddUserReferences < ActiveRecord::Migration
  def change
  	add_reference :tats, :user, index: true
  end
end
