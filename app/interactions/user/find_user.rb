require 'active_interaction'

class FindUser < ActiveInteraction::Base
  integer :id
  object :user
  validates :id, :user, presence: true

  def execute
    user = User.find_by_id(id)
    if user && user.ability.can?(:manage, @user)
      user
    else
      errors.add(:id, 'does not exist')
    end
  end

end