class Project < ActiveRecord::Base
  validates_presence_of :title, :description, :manager_id, :account_id

  belongs_to :account
  belongs_to :manager, :class_name => 'User'
  has_many :stories
  has_many :projects_developers
  has_many :developers, :through => :projects_developers

  def count_stories
    waiting_count, in_progress_count, accepted_count = 0, 0, 0
    stories.each {|story| 
      case story.life_cycle_phase.phase
        when 'waiting'
          waiting_count += 1
        when 'started', 'finished', 'delivered'
          in_progress_count += 1
        when 'accepted'
          accepted_count += 1
      end
    }
    
    {:waiting => waiting_count, :in_progress => in_progress_count, :accepted => accepted_count}
  end
end
