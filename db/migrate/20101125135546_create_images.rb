class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :user_id
      t.integer :mission_id
	  t.integer :report_count, :default => 0
	  

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
