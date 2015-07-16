class Ability
  include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)
        if user.role == "admin"
            can :manage, :all
        elsif user.role == "registered"
        elsif user.role == "alumni"
        elsif user.role == "active"
            can :read, :all
            can :manage, UserComment, :user_id => user.id
            can :manage, User, :id => user.id
            can :manage, UserAssignment, :user_id => user.id
            can :manage, Event, :user_id => user.id
            can :manage, Post, :user_id => user.id
        elsif user.role == "online"
            can :read, :all
            can :manage, UserComment
            can :manage, User, :id => user.id
            can :manage, UserAssignment, :user_id => user.id
            can :manage, Event, :user_id => user.id
            can :manage, Post, :user_id => user.id
            can :manage, Assignment
        elsif user.role == "boarding"
            can :read, :all
            can :manage, UserComment
            can :manage, User, :id => user.id
            can :manage, UserAssignment, :user_id => user.id
            can :manage, Event, :user_id => user.id
            can :manage, Post, :user_id => user.id
            can :manage, Assignment
        elsif user.role == "network"
            can :read, :all
            can :manage, UserComment, :user_id => user.id
            can :manage, User, :id => user.id
            can :manage, UserAssignment, :user_id => user.id
            can :manage, Event, :user_id => user.id
            can :manage, Post, :user_id => user.id
            can :manage, Assignment
        else
        end
    end
end
