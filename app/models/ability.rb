class Ability
  include CanCan::Ability

  def initialize(user)
    admin if user.role? :admin
    user(user)
  end

  private def user(me)
    can :create, :post
    can :manage, me
    can :delete, me.post
  end

  private def admin
    can :change, Role
    can :manage, :post
  end

end
