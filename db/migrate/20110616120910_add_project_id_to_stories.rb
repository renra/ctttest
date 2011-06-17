class AddProjectIdToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :project_id, :int
  end

  def self.down
    remove_column :stories, :project_id
  end
end
