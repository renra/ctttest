class Account < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :projects, :dependent => :destroy
  has_many :accounts_team_members
  has_many :team_members, :through => :accounts_team_members
  #has_and_belongs_to_many :team_members, :class_name => 'User', :join_table => 'accounts_team_members', :association_foreign_key => 'team_member_id'
end
