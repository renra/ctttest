class LifeCyclePhase < ActiveRecord::Base
  has_many :stories

  def self.available_phases( current_phase = nil )
    if current_phase
      case current_phase.phase
      when 'not ready'
        LifeCyclePhase.where(:phase => 'waiting').to_a << current_phase
      when 'waiting'
        LifeCyclePhase.where(:phase => 'started').to_a << current_phase
      when 'started'
        LifeCyclePhase.where(:phase => 'finished').to_a << current_phase
      when 'finished'
        LifeCyclePhase.where(:phase => 'delivered').to_a << current_phase
      when 'delivered'
        LifeCyclePhase.where(:phase => ['accepted', 'rejected']) << current_phase
      when 'rejected'
        LifeCyclePhase.where(:phase => 'started').to_a << current_phase
      when 'accepted'
        [current_phase]
      end
    else
      LifeCyclePhase.where(:phase => ['not ready', 'waiting'])
    end
  end

end
