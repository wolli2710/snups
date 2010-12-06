class AddNameHashToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :nameHash, :text
  end

  def self.down
    remove_column :images, :nameHash
  end
end
