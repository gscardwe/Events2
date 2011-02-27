class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :street
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :events, :user_id
  end

  def self.down
    drop_table :events
  end
end
