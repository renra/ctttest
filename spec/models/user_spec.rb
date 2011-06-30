require 'spec_helper'
require Rails.root.join('features', 'support', 'seed_data')

describe User do
  #before(:all) do
  #  @gandalf = Factory(:gandalf)
  #  @saruman = Factory(:saruman)
  #end
  before(:each) do
    @test_user = Factory.create(:user)
  end

  it 'should generate different passwords every time' do
    @test_user.generate_password.should_not eq(@test_user.generate_password)
  end

  it 'should complain about email, password and password confirmation' do
    #override
    @test_user = Factory(:bald_user)

    @test_user.save.should be_false
    @test_user.errors.size.should == 3
    @test_user.errors[:password_confirmation].should == ["is too short (minimum is 4 characters)"]
    @test_user.errors[:password].should == ["is too short (minimum is 4 characters)"]
    @test_user.errors[:email].should == ["should look like an email address."]
  end

  it 'should complain about password not matching its confirmation' do
    #override
    @test_user = Factory(:user_with_email_and_password_only)
    @test_user.password_confirmation = 'nonsense'

    @test_user.save.should be_false
    @test_user.errors.size.should == 1
    @test_user.errors[:password].should == ["doesn't match confirmation"]
  end

  it 'should save without errors' do
    @test_user.save.should be_true
  end

  it 'should not be an account owner' do
    @test_user.save
    @test_user.owner?.should be_false
  end

  it 'should save without errors' do
    @test_user.save_with_account_and_become_team_member.should be_true
    @test_user.account.team_members.size.should == 1
  end

  it 'should be an account owner' do
    @test_user.save_with_account_and_become_team_member
    @test_user.owner?.should be_true
  end

  it 'should be on the team' do
    @test_user.save_with_account_and_become_team_member
    @test_user.account.team_members.size.should == 1
    @test_user.account.team_members.should include(@test_user)
  end

  it 'should not be a developer' do
    @test_user.save
    @test_user.developer?.should be_false
  end

  it 'should be able to create a project' do
    @test_user.save_with_account_and_become_team_member
    @test_user.account.projects << Factory.build(:project, :manager_id => @test_user.id)
    @test_user.save.should be_true
    @test_user.owned_projects.size.should == 1
  end

  it 'should be able to assign himself as a developer' do
    @test_user.save_with_account_and_become_team_member
    @test_user.account.projects << Factory.build(:project, :manager_id => @test_user.id)
    @test_user.save
    project_id = @test_user.account.projects.first.id
    @test_user.assign_developers(project_id, [@test_user.id]).should be_true
  end

  it 'should be a developer' do
    @test_user.save_with_account_and_become_team_member
    @test_user.account.projects << Factory.build(:project, :manager_id => @test_user.id)
    @test_user.save
    project_id = @test_user.account.projects.first.id
    @test_user.assign_developers(project_id, [@test_user.id])
    @test_user.developer?.should be_true
  end

  it 'should be a developer - not passing an array of ids but a single id' do
    @test_user.save_with_account_and_become_team_member
    @test_user.account.projects << Factory.build(:project, :manager_id => @test_user.id)
    @test_user.save
    project_id = @test_user.account.projects.first.id
    @test_user.assign_developers(project_id, @test_user.id)
    @test_user.developer?.should be_true
  end

  it 'should be able to recruit a member to his team' do
    developer = Factory.create(:user)
    @test_user.save_with_account_and_become_team_member

    @test_user.recruit_team_members(developer.id)
    @test_user.account.team_members.size.should == 2
    @test_user.account.team_members.should include(@test_user, developer)
  end

  it 'should be able to recruit members to his team' do
    dev1 = Factory.create(:user)
    dev2 = Factory.create(:user)
    @test_user.save_with_account_and_become_team_member

    @test_user.recruit_team_members([dev1.id, dev2.id])
    @test_user.account.team_members.size.should == 3
    @test_user.account.team_members.should include(@test_user, dev1, dev2)
  end

  it 'should be able to dismiss members of his team' do
    developer = Factory.create(:user)
    @test_user.save_with_account_and_become_team_member

    @test_user.recruit_team_members(developer.id)
    @test_user.dismiss(developer)
    @test_user.account.team_members.size.should == 1
    @test_user.account.team_members.should include(@test_user)
  end
  
end
