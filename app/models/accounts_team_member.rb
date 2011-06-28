class AccountsTeamMember < ActiveRecord::Base
  belongs_to :team_member, :class_name => 'User'
  belongs_to :account
end
