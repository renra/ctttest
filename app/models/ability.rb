class Ability
#begin
  include CanCan::Ability

  def initialize( user )
    if user
      can [:read, :update], User do |user_subject|
        user === user_subject
      end

      if user.owner?
        can :create, Project
        can [:read, :update, :destroy, :assign], Project do |project|
          user.owned_projects.include?( project )
        end

        can :create, User
        can [:read, :update, :destroy], User do |user_subject|
          user.account.team_members.any? {|team_member| team_member.id == user_subject.id}
        end

        can :read, Story do |story|
          user.account.projects.any? {|project| project.id == story.project_id}
        end
      end

      if user.developer?
        can :read, Project do |project|
          user.projects.any? {|p| p.id == project.id}
        end

        can :create, Story

        can :read, Story do |story|
          user.projects.any? {|project| project.id == story.project_id}
        end
        can [:update, :destroy], Story do |story|
          user.id == story.requestor_id || user.id == story.responson_id
        end
      end
    end

  end
  
end
