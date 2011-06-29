class Project < ActiveRecord::Base
  validates_presence_of :title, :description, :manager_id, :account_id

  belongs_to :account
  belongs_to :manager, :class_name => 'User'
  has_many :stories, :order => :position, :dependent => :destroy
  has_many :projects_developers
  has_many :developers, :through => :projects_developers

  def count_stories
    not_ready_count, waiting_count, in_progress_count, accepted_count, rejected_count = 0, 0, 0, 0, 0
    stories.each {|story| 
      case story.life_cycle_phase.phase
        when 'not ready'
          not_ready_count += 1
        when 'waiting'
          waiting_count += 1
        when 'started', 'finished', 'delivered'
          in_progress_count += 1
        when 'accepted'
          accepted_count += 1
        when 'rejected'
          rejected_count += 1
      end
    }
    
    {:not_ready => not_ready_count, :waiting => waiting_count, :in_progress => in_progress_count, :accepted => accepted_count, :rejected => rejected_count,
     :total => stories.size}
  end
end
