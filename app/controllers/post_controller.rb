class PostController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    outcome = CreatePost.run(params.require(:post).merge(user_id: current_user.id))
    if outcome.valid?
      redirect_to root_path
    else
      flash[:alert] = ResourcesMessage.new(:create_post, outcome.errors).message
      redirect_to post_new_path
    end
  end
end
