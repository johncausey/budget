class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :create, User
    can :create, Message
    if user
      can :logout, :users
      can :edit, User, :id => user.id
      # can :account_information, User, :id => user.id
      can :manage, [Expense, Income, Saving]
    end

  end
end
