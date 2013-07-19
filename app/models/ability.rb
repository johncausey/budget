class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :create, User
    if user
      can :logout, :users
      can :update, User, :id => user.id
      can :manage, Expense, :user_id => user.id
      can :manage, Income, :user_id => user.id
      can :manage, Saving, :user_id => user.id
    end

  end
end
