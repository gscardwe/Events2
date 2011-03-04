class AddLatLongToRelationship < ActiveRecord::Migration
  def self.up
    add_column :relationships, :latitude, :float
    add_column :relationships, :longitude, :float
  end

  def self.down
    remove_column :relationships, :longitude
    remove_column :relationships, :latitude
  end
end
