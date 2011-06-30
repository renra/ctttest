class Account < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :projects, :dependent => :destroy
  has_many :accounts_team_members
  has_many :team_members, :through => :accounts_team_members
end
