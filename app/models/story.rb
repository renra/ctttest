class Story < ActiveRecord::Base
  acts_as_list :scope => :project

  validates_presence_of :title, :description, :requestor_id, :responson_id, :life_cycle_phase_id, :project_id, :scale_level_id

  belongs_to :scale_level
  belongs_to :life_cycle_phase
  belongs_to :project
  belongs_to :requestor, :class_name => 'User'
  belongs_to :responson, :class_name => 'User'
end
