class User < ActiveRecord::Base

  acts_as_authentic

  #acts_as_authentic do |c|
  #  c.login_field = :email
  #end

  has_many :stories, :foreign_key => 'requestor_id'
  has_many :responsibilities, :class_name => 'Story', :foreign_key => 'responson'
  has_one :account, :foreign_key => 'owner_id'

  has_and_belongs_to_many :projects, :foreign_key => 'developer_id', :join_table => 'projects_developers'
  has_many :owned_projects, :through => :account, :source => 'projects'

  def developers
    owned_projects.collect {|project| project.developers}.flatten
  end

  def developer?( project_id = nil )
    if project_id
      projects.any? { |project| project.id == project_id }
    else
      projects.size > 0
    end
  end

  def owner?( account_id = nil )
    if account_id
      account_id == account.id
    else
      !account.nil?
    end
  end

end
