class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end

    if user.teacher?
      can [:create], Course
      can [:create], Modu
    end

    if user.student?
    end
  end
end
