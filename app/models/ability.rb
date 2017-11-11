class Ability
  include CanCan::Ability

  def initialize(user)
    admin if user.role? :admin
    user(user)
  end

  private def user(me)
    can :create, Post
    can :manage, me
    can :delete, me.posts # why it don't work?
  end

  private def admin
    can :manage, User.all
    can :change, Role
    can :manage, Post.all
  end

end
