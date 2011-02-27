class AddZipToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :zip, :integer
  end

  def self.down
    remove_column :events, :zip
  end
end
