class CreateTats < ActiveRecord::Migration
  def change
    create_table :tats do |t|

      t.timestamps null: false
    end
  end
end
