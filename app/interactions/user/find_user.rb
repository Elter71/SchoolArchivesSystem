require 'active_interaction'

class FindUser < ActiveInteraction::Base
  integer :id
  object :user
  validates :id, :user, presence: true

  def execute
    user = User.find_by_id(id)
    if user
      if_return_full_user(user)
    else
      errors.add(:id, 'does not exist')
    end
  end

  private

  def if_return_full_user(user)
    if user.ability.can?(:manage, @user)
      user
    else
      {first_name: user.first_name, last_name: user.last_name}
    end
  end
end
