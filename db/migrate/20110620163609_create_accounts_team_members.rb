class CreateAccountsTeamMembers < ActiveRecord::Migration
  def self.up
    create_table :accounts_team_members, :id => false do |t|
      t.integer :team_member_id
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts_team_members
  end
end
