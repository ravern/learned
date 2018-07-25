class Ability
  include CanCan::Ability

  # Reading is controlled by database structure and not by CanCan.
  def initialize(user)
    if user.admin?
      can :delete, Course
      can :delete, Modu
      can :delete, Comment
    end

    if user.teacher?
      can :create, Course
      can [:update, :delete], Course do |course|
        user.courses.include?(course)
      end

      can :create, Modu
      can [:update, :delete], Modu do |modu|
        user.courses.include?(modu.course)
      end

      can :complete, Modu do |modu|
        user.enrolled_courses.include?(modu.course)
      end
    end

    if user.teacher? || user.student?
      can :create, Comment do |comment|
        user.all_courses.include?(comment.modu.course)
      end

      can :complete, Modu do |modu|
        user.enrolled_courses.include?(modu.course)
      end
    end
  end
end
