class CreateProjectsDevelopers < ActiveRecord::Migration
  def self.up
    create_table :projects_developers, :id => false do |t|
      t.integer :project_id
      t.integer :developer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects_developers
  end
end
