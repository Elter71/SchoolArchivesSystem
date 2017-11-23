require 'active_interaction'
class DeletePost < ActiveInteraction::Base
  integer :id
  object :user
  validates :id, :user, presence: true

  def execute
    post = Post.find_by_id(id)
    if post
      check_authorization(post)
    else
      errors.add(:post, 'does not exist')
    end
  end

  private

  def check_authorization(post)
    if @user.ability.can? :delete, post
      post.delete
    else
      add_wrong_authorization_errors
    end
  end

  def add_wrong_authorization_errors
    errors.add(:user, 'wrong authorization')
  end
end
