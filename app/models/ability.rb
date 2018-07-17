class Ability
  include CanCan::Ability

  # Reading is controlled by database structure and not by CanCan.
  def initialize(user)
    if user.admin?
      can [:delete], Course
      can [:delete], Modu
    end

    if user.teacher?
      can [:create, :update, :delete], Course
      can [:create, :update, :delete], Modu
    end

    if user.student?
    end
  end
end
