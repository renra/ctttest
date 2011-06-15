class Story < ActiveRecord::Base
  belongs_to :scale_level
  belongs_to :life_cycle_phase
  belongs_to :requestor, :class_name => 'User'
  belongs_to :responson, :class_name => 'User'
end
