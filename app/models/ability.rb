class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :create, User
    can :create, Message
    if user
      can [:create, :index], [Expense, Income, Saving]
      can :destroy, [Expense, Income], :user_id => user.id
      can [:logout, :update], User, :id => user.id
    end

  end
end
