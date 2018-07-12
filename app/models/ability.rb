class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end

    if user.teacher?
      can :show, :create
      can [:create], Course
      can [:create], Modu
    end
  end
end
