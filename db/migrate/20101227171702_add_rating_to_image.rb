class AddRatingToImage < ActiveRecord::Migration
  def self.up
     add_column :images, :pos, :integer, :default => 0
     add_column :images, :neg, :integer, :default => 0
  end

  def self.down
    remove_column :images, :pos
    remove_column :images, :neg
  end
end
