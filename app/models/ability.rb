class Ability
  include CanCan::Ability

  def initialize(user)
    admin if user.role? :admin
    user(user)
  end

  private def user(me)
    can :create, Post
    can :change_password, me
    can :see_details, me
    can :delete, me.posts.each {|post| post}
  end

  private def admin
    can :manage, Post
    can :manage, User
  end

end
