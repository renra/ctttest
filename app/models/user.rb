class User < ActiveRecord::Base

  acts_as_authentic

  has_many :stories, :foreign_key => 'requestor_id'
  has_many :responsibilities, :class_name => 'Story', :foreign_key => 'responson'
  has_one :account, :foreign_key => 'owner_id', :dependent => :destroy

  has_many :projects_developers, :foreign_key => 'developer_id'
  has_many :projects, :through => :projects_developers
  has_many :accounts_team_members, :foreign_key => 'team_member_id'
  has_many :assigned_accounts, :through => :accounts_team_members, :source => :account
  has_many :owned_projects, :through => :account, :source => :projects

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

  def generate_password
    if Rails.env.development?
      pass = 'random'
    else
      pass = SecureRandom.hex(8)
    end

    self.password = self.password_confirmation = pass
  end

  def assign_developers( project_id, developer_ids )
    project = Project.find( project_id, :include => :developers )

    begin
      project.developers = User.find(developer_ids.to_a)
    rescue
      project.developers = []
    end

    project.save
  end



  def save_with_account_and_become_team_member
    self.account = Account.new( {:owner_id => id} )
    self.account.team_members << self

    save
  end


  def add_team_member( acc_id = self.account.id, member = self )
    if member.is_a?(Integer)
      team_member_id = member
    elsif member.is_a?(User)
      team_member_id = member.id
    end

    relation = AccountsTeamMember.new( :account_id => acc_id, :team_member_id => team_member_id )
    relation.save
  end

  def recruit_team_members( recruit_ids )
    account.team_members = [self] + User.find(recruit_ids).to_a
    save
  end


  def dismiss( member )
    if member.is_a?( Integer )
      member = User.find( member )
    end

    account.team_members -= [member]
    save
  end

end
