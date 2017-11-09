require 'active_interaction'
class FindPost < ActiveInteraction::Base
  integer :id
  validates :id, presence: true

  def execute
    post = Post.find_by_id(id)
    if post
      post
    else
      errors.add(:id, 'does not exist')
    end
  end

end
