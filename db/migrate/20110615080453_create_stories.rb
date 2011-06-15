class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.integer :scale_level_id
      t.integer :life_cycle_phase_id
      t.integer :requestor_id
      # a merge of two words - responsible person
      t.integer :responson_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
