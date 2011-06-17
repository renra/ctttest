class Ability
#begin
  include CanCan::Ability

  def initialize( user )
    if user
      if user.owner?
        can :manage, Project do |project|
          user.owned_projects.include?( project )
        end

        can :create, User
        can [:read, :update, :destroy], User do |user|
          user.developers.any? {|dev| dev.id == user.id}
        end

        can :read, Story do |story|
          user.account.projects.any? {|project| project.id == story.project_id}
        end
      end

      if user.developer?
        can :read, Story do |story|
          user.projects.any? {|project| project.id == story.project_id}
        end
        can [:update, :create, :destroy], Story do |story|
          user.id == story.requestor_id || user.id == story.responson_id
        end
      end
    end

  end
  
end
