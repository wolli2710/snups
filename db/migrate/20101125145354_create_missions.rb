class CreateMissions < ActiveRecord::Migration
  def self.up
    create_table :missions do |t|
      t.text :title, :unique => true
      t.boolean :status, :default => false
	  

      t.timestamps
    end
  end

  def self.down
    drop_table :missions
  end
end
