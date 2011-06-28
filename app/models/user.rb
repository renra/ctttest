class User < ActiveRecord::Base

  acts_as_authentic

  #acts_as_authentic do |c|
  #  c.login_field = :email
  #end

  has_many :stories, :foreign_key => 'requestor_id'
  has_many :responsibilities, :class_name => 'Story', :foreign_key => 'responson'
  has_one :account, :foreign_key => 'owner_id', :dependent => :destroy

  has_many :projects_developers, :foreign_key => 'developer_id'
  has_many :projects, :through => :projects_developers
  #has_and_belongs_to_many :projects, :foreign_key => 'developer_id', :join_table => 'projects_developers'
  has_many :accounts_team_members, :foreign_key => 'team_member_id'
  has_many :assigned_accounts, :through => :accounts_team_members, :source => :account
  #has_and_belongs_to_many :accounts, :foreign_key => 'team_member_id', :join_table => 'accounts_team_members'
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
    self.password = self.password_confirmation = SecureRandom.hex(8)
  end

  def assign_developers( project_id, developer_ids )
    project = Project.find( project_id, :include => :developers )

    begin
      project.developers = User.find(developer_ids)
    rescue
      project.developers = []
    end

    project.save
  end



  # three saves in a row, but how to avoid this and still have consistent data?
  def save_with_account_and_become_team_member
    ActiveRecord::Base.transaction do
      return false unless save
    
      acc = Account.new( {:owner_id => id} )
      return false unless acc.save

      add_team_member( acc.id )
    end
  end


  def add_team_member( acc_id = account.id, member = self )
    relation = AccountsTeamMember.new( :account_id => acc_id, :team_member_id => member.id )
    relation.save
  end

end
