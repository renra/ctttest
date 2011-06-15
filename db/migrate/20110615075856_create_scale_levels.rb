class CreateScaleLevels < ActiveRecord::Migration
  def self.up
    create_table :scale_levels do |t|
      t.integer :level

      t.timestamps
    end
  end

  def self.down
    drop_table :scale_levels
  end
end
