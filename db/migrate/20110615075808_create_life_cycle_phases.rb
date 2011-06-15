class CreateLifeCyclePhases < ActiveRecord::Migration
  def self.up
    create_table :life_cycle_phases do |t|
      t.string :phase

      t.timestamps
    end
  end

  def self.down
    drop_table :life_cycle_phases
  end
end
